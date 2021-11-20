import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class Player extends StatefulWidget {
  final url;
  Player({this.url});

  @override
  _PlayerState createState() => _PlayerState();
}




class _PlayerState extends State<Player> {


   AudioPlayer _player;
   Stream<DurationState> _durationState;
  var _labelLocation = TimeLabelLocation.below;
  var _labelType = TimeLabelType.totalTime;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _player.positionStream,
        _player.playbackEventStream,
            (position, playbackEvent) => DurationState(
          progress: position,
          buffered: playbackEvent.bufferedPosition,
          total: playbackEvent.duration,
        ));
    _init();
  }

  Future<void> _init() async {
    try {
      await _player.setUrl(widget.url);
    } catch (e) {
      print("An error occured $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _playButton(),
        SizedBox(width: 5,),
        Container(
            width: MediaQuery.of(context).size.width/1.5,
            child: _progressBar()),

      ],
    );
  }



  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: _durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          onSeek: (duration) {
            _player.seek(duration);
          },
          timeLabelLocation: _labelLocation,
          timeLabelType: _labelType,
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: EdgeInsets.all(8.0),
            width: 32.0,
            height: 32.0,
            child: CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return IconButton(
            icon: Icon(Icons.play_arrow),
            iconSize: 32.0,
            onPressed: (){
              // _player.stop();
              _player.play();},
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: Icon(Icons.pause),
            iconSize: 32.0,
            onPressed: _player.pause,
          );
        } else {
          return IconButton(
            icon: Icon(Icons.replay),
            iconSize: 32.0,
            onPressed: () => _player.seek(Duration.zero),
          );
        }
      },
    );
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