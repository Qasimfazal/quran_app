import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/Utils/Utils.dart';
import 'package:quran_app/audioPlayer/widgets/styleguide.dart';
import 'package:rxdart/rxdart.dart';

import '../audioPlayer.dart';

class SongSeekbarCircle extends StatefulWidget {
  final url, surah, index;
  Function listner;
  AudioPlayer player;
  SongSeekbarCircle({this.url, this.surah, this.index,this.listner,this.player});
  @override
  _SongSeekbarCircleState createState() => _SongSeekbarCircleState(this.player);
}

class _SongSeekbarCircleState extends State<SongSeekbarCircle> {
  Offset manualSeekPosition = Offset(0, 0);
  bool isPanActive = false;
  double progress;
  double manualProgress;
  AudioPlayer _player;
  var time;
  Stream<DurationState> _durationState;
  _SongSeekbarCircleState(this._player);

  void setSeekbar(Offset localPosition) {
    manualSeekPosition = Offset(
      -MediaQuery.of(context).size.height * .25 * .5 + localPosition.dx,
      MediaQuery.of(context).size.height * .25 * .5 - localPosition.dy,
    );

    manualProgress = calculateSeekbarPosition();
    var position = double.parse(time.toString()) * manualProgress;
    _player.seek(Duration(seconds: position.floor()));
    print("position is "+position.toString());
    isPanActive = true;
  }

  @override
  void initState() {
    super.initState();
   _player = AudioPlayer();
    stateCheck();

    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _player.positionStream,
        _player.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
    _init();
    initialize();
  }


  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  initialize()async{
    await _player.setAudioSource(
      ConcatenatingAudioSource(
        // Start loading next item just before reaching it.
        useLazyPreparation: true, // default
        // Customise the shuffle algorithm.
        shuffleOrder: DefaultShuffleOrder(), // default
        // Specify the items in the playlist.
        children: [
          for (int i = 0; i < widget.surah.length; i++)
            AudioSource.uri(Uri.parse(widget.surah[i].link)),
        ],
      ),
      // Playback will be prepared to start from track1.mp3
      initialIndex: widget.index, // default
      // Playback will be prepared to start from position zero.
      initialPosition: Duration.zero, // default
    );
    // setState(() {
      Utils.audioList = true;
    // });
    // }
    // await _player.seekToNext();
    // await player.seekToPrevious();
// Jump to the beginning of track3.mp3.
  }


  Future<void> _init() async {
    try {
      await _player.setUrl(widget.url);
    } catch (e) {
      print("An error occured $e");
    }
  }

  double calculateSeekbarPosition() {
    double angle = math.atan2(-manualSeekPosition.dy, manualSeekPosition.dx);
    if (angle < math.pi * .5) {
      /* correct negative half */
      angle += 2 * math.pi;
    } else if (angle < math.pi * .75) {
      /* correct so that seekbar is at beginning */
      angle = math.pi * .75;
    }
    /* compensate for rotation */
    angle -= math.pi * .75;

    return math.min(angle / (math.pi * 1.5), 1);
  }

  stateCheck(){
    _player.playerStateStream.listen((state) {
      if (state.playing) {
        widget.listner.call(_player);
        switch (state.processingState) {
          case ProcessingState.idle:
            break;
          case ProcessingState.loading:
            break;
          case ProcessingState.buffering:
            break;
          case ProcessingState.ready:
            break;
          case ProcessingState.completed:
            _player.stop();
            int newIndex = widget.index +1;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>PlayerPage(
                    data: widget.surah,
                    index: newIndex,
                  ),));
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: StreamBuilder<DurationState>(
          stream: _durationState,
          builder: (context, snapshot) {
            final durationState = snapshot.data;
            final progres = durationState?.progress ?? Duration.zero;
            final progressSplit = progres.toString().split(".");
            var progressSeconds = progressSplit[0];
            final total = durationState?.total ?? Duration.zero;
            var split;
            var seconds = "0.0";
            if (total.toString() != "0:00:00.000000") {
              split = total.toString().split(".");
              seconds = split[0];
              var secondsSplit = seconds.split(":");
              var hour = int.parse(secondsSplit[0]) * 3600;
              var minutes = int.parse(secondsSplit[1]) * 60;
              var second = int.parse(secondsSplit[0]);
              time = hour + minutes + second;
            }
            progress = progres.inMilliseconds / total.inMilliseconds;

            // if(progressSeconds == seconds){
            //   _player.stop();
            //   int newIndex = widget.index +1;
            //   Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>PlayerPage(
            //           data: widget.surah,
            //           index: newIndex,
            //         ),));
            // }
            return Container(
              width: MediaQuery.of(context).size.height * .25,
              height: MediaQuery.of(context).size.height * .25,
              child: GestureDetector(
                onPanStart: (dragStartPosition) {
                  setSeekbar(dragStartPosition.localPosition);
                },
                onPanUpdate: (dragUpdate) {
                  isPanActive = true;
                  setSeekbar(dragUpdate.localPosition);
                },
                onPanCancel: () {
                  isPanActive = false;
                },
                onPanEnd: (dragUpdate) {

                  isPanActive = false;
                },
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * .01,
                      child: Text(
                        "$progressSeconds",
                        style: TextStyle(
                          color: textLightColor,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * .01,
                      right: 0,
                      child: Text(
                        "$seconds",
                        style: TextStyle(
                          color: textLightColor,
                        ),
                      ),
                    ),
                    CustomPaint(
                      painter: SeekbarPainter(
                          isPanActive ? manualProgress : progress),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.height * .075,
                          height: MediaQuery.of(context).size.height * .075,
                          decoration: BoxDecoration(
                            color: Color(0xFFfbbb8a),
                            gradient: RadialGradient(
                              colors: [
                                Color(0xFFffd390),
                                Color(0xFFfbbb8a),
                              ],
                              center: Alignment(-0.2, -0.2),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 10,
                              ),
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (!_player.playing) {
                                _player.play();
                              } else {
                                _player.pause();
                              }
                            },
                            child: Container(
                              child: Center(
                                child: PlayPauseButton(
                                  player: _player,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class PlayPauseButton extends StatefulWidget {
  final player;
  PlayPauseButton({this.player});
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(
          milliseconds: 400,
        ),
        vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.player.playing) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    return AnimatedIcon(
      icon: AnimatedIcons.play_pause,
      progress: _animationController,
      color: Colors.black,
      size: 38,
    );
  }
}

class SeekbarPainter extends CustomPainter {
  final double margin = .03;
  final double progressPercent;
  double radius;
  Rect mainRect;

  SeekbarPainter(this.progressPercent);

  void paint(Canvas canvas, Size size) {
    radius = math.min(size.width, size.height) / 2;

    mainRect = Rect.fromLTRB(
      radius * 2 * margin,
      radius * 2 * margin,
      radius * 2 * (1 - margin),
      radius * 2 * (1 - margin),
    );

    paintBackground(canvas, size);
    paintOuterLine(canvas, size);
    paintProgressArc(canvas, size);
  }

  void paintOuterLine(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = .8
      ..color = textLightColor
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      mainRect,
      math.pi * .75,
      math.pi * 1.5,
      false,
      paint,
    );

    paint.style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(
        size.width * (1 - margin * 5.6),
        size.width * (1 - margin * 5.6),
      ),
      2,
      paint,
    );
    canvas.drawCircle(
      Offset(
        size.width * (margin * 5.6),
        size.width * (1 - margin * 5.6),
      ),
      2,
      paint,
    );
  }

  void paintProgressArc(Canvas canvas, Size size) {
    if (progressPercent == double.nan) {
      return;
    }

    double filledArcAngle = math.pi * 1.5 * progressPercent;
    if (filledArcAngle > math.pi * .25) {
      filledArcAngle = math.pi * .25;
    }

    double progressBallPosX = size.width / 2 +
        (radius - 100 * margin * 2) *
            math.cos(math.pi * .7501 + math.pi * 1.5 * progressPercent);
    double progressBallPosY = size.width / 2 +
        (radius - 100 * margin * 2) *
            math.sin(math.pi * .7501 + math.pi * 1.5 * progressPercent);

    final Gradient gradientProgressBar = new SweepGradient(
      center: Alignment.center,
      colors: [
        Color(0xFF143b3e),
        Color(0xFF858d8e),
      ],
      startAngle: math.pi * .25,
      endAngle: math.pi * .2501 + math.pi * 1.5 * progressPercent,
    );

    final Paint paintProgressBar = Paint()
      ..shader = gradientProgressBar.createShader(mainRect)
      ..isAntiAlias = true
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Gradient gradientFilledArc = new SweepGradient(
      center: Alignment.center,
      colors: [
        Colors.transparent,
        Color(0xFFFFD08E).withOpacity(.3),
      ],
      startAngle:
          math.pi * .25 + math.pi * 1.5 * progressPercent - filledArcAngle,
      endAngle: math.pi * .2501 + math.pi * 1.5 * progressPercent,
    );

    final Paint paintFilledArc = Paint()
      ..shader = gradientFilledArc.createShader(mainRect)
      ..isAntiAlias = true;

    final Paint paintBallShadow = Paint()
      ..isAntiAlias = true
      ..color = Colors.black26
      ..style = PaintingStyle.fill;

    final Paint paintBall = Paint()
      ..isAntiAlias = true
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    /* Rotate canvas by 90 degrees to generate gradient with good tiling */
    canvas.save();
    canvas.rotate(math.pi / 2);
    canvas.translate(0, -size.width);
    /* Draw filled arc */
    canvas.drawArc(
      mainRect,
      math.pi * .25 + math.pi * 1.5 * progressPercent - filledArcAngle,
      filledArcAngle,
      true,
      paintFilledArc,
    );
    /* Draw progress bar */
    canvas.drawArc(
      mainRect,
      math.pi * .25,
      math.pi * 1.5 * progressPercent,
      false,
      paintProgressBar,
    );
    canvas.restore();

    /* Draw progress ball shadow */
    canvas.drawCircle(
      Offset(
        progressBallPosX,
        progressBallPosY,
      ),
      9,
      paintBallShadow,
    );

    /* Draw white progress ball */
    canvas.drawCircle(
      Offset(
        progressBallPosX,
        progressBallPosY,
      ),
      7.5,
      paintBall,
    );
  }

  void paintBackground(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = textLightColor.withOpacity(0.075);

    canvas.drawCircle(
      Offset(radius, radius),
      radius * (1 - margin * 2),
      paint,
    );
  }

  bool shouldRepaint(SeekbarPainter oldDelegate) {
    return false;
  }
}

class DurationState {
  const DurationState({
    this.progress,
    this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration total;
}
