import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/Utils/Utils.dart';
import 'package:quran_app/Utils/preference.dart';

import 'package:quran_app/audioPlayer/widgets/dummydata.dart';
import 'package:quran_app/audioPlayer/widgets/styleguide.dart';
import '../audioPlayer.dart';
import '../widgets/song_seekbar_circle.dart';
import '../widgets/player_visualizer.dart';
import '../widgets/app_title.dart';
import 'dart:math' as math;

class PlayerCurrentSong extends StatefulWidget {
  final double heightFactor;
  final surah,index,duration;
  PlayerCurrentSong([this.heightFactor = 1,this.surah,this.index,this.duration]);

  @override
  _PlayerCurrentSongState createState() => _PlayerCurrentSongState(this.heightFactor,this.surah,this.index,this.duration);
}

class _PlayerCurrentSongState extends State<PlayerCurrentSong> {
  final double heightFactor;
  final surah,index;
  var duration;
  AudioPlayer _player;

  _PlayerCurrentSongState([this.heightFactor = 1,this.surah,this.index,this.duration]);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Preferences().setPlayerIndex(index);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(_player != null){
      _player.dispose();
    }
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    // Preferences().setPlayerIndex(index);
    // if(_player.duration != null){
    //   duration = _player.duration;
    // }
    return Positioned(
      width: MediaQuery.of(context).size.width,
      top: 0,
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: heightFactor,
          child: Container(
            height: MediaQuery.of(context).size.height * .7,
            child: Stack(
              children: <Widget>[
                BackgroundSplash(),
                AppTitle("Quran Player"),
                SongHeader(
                "${surah[ Preferences().playerIndex].sora}","${surah[ Preferences().playerIndex].readerName}",Preferences().audioduration==null?widget.duration:Preferences().audioduration
                ),
                // _player.playerStateStream.listen((state) {
                //   if (state.playing) {
                //
                //   }
                // });
              _player == null || _player.playing == false?Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .275,
                  left: MediaQuery.of(context).size.width * .05,
                  right: MediaQuery.of(context).size.width * .05,
                ),
                height: MediaQuery.of(context).size.height * .2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    for (int i = 0; i < 23; i++)
                      VisualizerBar(math.Random().nextInt(14)),
                  ],
                ),
              ):StreamBuilder<Object>(
                stream: _player.playbackEventStream,
                builder: (context, snapshot) {
                  _player.playerStateStream.listen((state) {
                    if (state.playing) {
                      Future.delayed(Duration(seconds: 3),(){
                        setState(() {

                        });
                        // for (int i = 0; i < 23; i++) VisualizerBar(math.Random().nextInt(14));
                      });
                    }
                  });
                  return Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .275,
                      left: MediaQuery.of(context).size.width * .05,
                      right: MediaQuery.of(context).size.width * .05,
                    ),
                    height: MediaQuery.of(context).size.height * .2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        for (int i = 0; i < 23; i++) VisualizerBar(math.Random().nextInt(14)),
                      ],
                    ),
                  );
                }
              ),
                Container(
                  height: MediaQuery.of(context).size.width * .5,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .25,
                    left: MediaQuery.of(context).size.width * .25,
                    right: MediaQuery.of(context).size.width * .25,
                  ),
                  child: SongSeekbarCircle(player: _player,url: surah[index].link,surah: surah,index: index,listner: (value){
                  setState(() {
                    _player = value;
                  });

                  },),
                ),
                // CurrentSongButtons(),
                Preferences().playerIndex == 0? Container():Positioned(
                  bottom: 30,
                  left: 20,
                  child: InkWell(
                    onTap: ()async{
                      if(_player!= null){
                        await _player.seekToPrevious();
                        var index = Preferences().playerIndex - 1;
                        Preferences().setPlayerIndex(index).then((value) async {
                          getduration(index);
                        });
                      }
                      else{
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerPage(
                                data: surah,
                                index: Preferences().playerIndex - 1,
                              ),
                            ));
                      }
                      // if(_player != null){
                      //   if (_player.playing)
                      //   {
                      //     _player.stop();
                      //   }
                      // }
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) =>PlayerPage(
                      //         data: surah,
                      //         index: index-1,
                      //       ),));
                    },
                    child: CornerButton(
                      icon: Icons.fast_rewind,
                      player: _player,
                      corner: CornerPositions.bottomLeft,
                      songId:
                      Preferences().playerIndex -1,
                      surah: surah,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 20,
                  child: InkWell(
                    onTap: ()async{
                      // _player.dispose();
                      if(_player!= null){
                        await _player.seekToNext();
                        var index = Preferences().playerIndex + 1;
                        Preferences().setPlayerIndex(index).then((value) async {
                          getduration(index);
                        });

                      }

                      else{
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerPage(
                                data: surah,
                                index: index + 1,
                              ),
                            ));
                      }
                    },
                    child: CornerButton(
                      icon: Icons.fast_forward,
                      player: _player,
                      corner: CornerPositions.bottomRight,
                      songId:
                      Preferences().playerIndex+1,
                      surah: surah,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  getduration(int index) async {
    final player = AudioPlayer();
    var durationCheck = await player.setUrl(surah[index].link);
    var split = durationCheck.toString().split(".");
    duration = split[0];
    Preferences().setDuration(duration);
  }
}

class SongHeader extends StatefulWidget {
  final String _title;
  final String _artist;
   var duration;

  SongHeader(
    this._title,
    this._artist,
    this.duration,
  );

  @override
  _SongHeaderState createState() => _SongHeaderState();
}

class _SongHeaderState extends State<SongHeader> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .15,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "${widget._title}",
            style: TextStyle(
              fontSize: 17,
              color: textLightColor,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${widget._artist}",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: textLightColor,
                ),
              ),
              SizedBox(width: 15,),
              // _duration.length > 0
              //     ? Container(
              //         margin: EdgeInsets.symmetric(
              //           horizontal: 12,
              //         ),
              //         decoration: BoxDecoration(
              //           color: textLightColor,
              //           shape: BoxShape.circle,
              //         ),
              //         width: 4.0,
              //         height: 4.0,
              //       )
              //     : Container(),
              Text(
                widget.duration==null?"": widget.duration.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: textLightColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CurrentSongButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .24 +
            MediaQuery.of(context).size.width * .5,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * (.7 - .25) -
            MediaQuery.of(context).size.width * .5 -
            30 -
            35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
               // Provider.of<PlayerProvider>(context).seekSecond(0);
              },
              icon: Icon(
                Icons.replay,
                color: textLightColor.withOpacity(.8),
              ),
              padding: EdgeInsets.all(0),
              iconSize: 32,
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                color: textLightColor.withOpacity(.8),
              ),
              padding: EdgeInsets.all(0),
              iconSize: 32,
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: textLightColor.withOpacity(.8),
              ),
              padding: EdgeInsets.all(0),
              iconSize: 32,
            ),
          ],
        ),
      ),
    );
  }
}

class CornerButton extends StatelessWidget {
  final IconData icon;
  final CornerPositions corner;
  final int songId;
  final surah;
  AudioPlayer player;

  CornerButton({
    this.icon,
    this.corner,
    this.songId,
    this.surah,
    this.player,
  });

  @override
  Widget build(BuildContext context) {
    int currentSongId =  1;
    String title = "${surah[songId].sora}";
    String artist = "${surah[songId].readerName}";
    bool hideElement =
        ((corner == CornerPositions.bottomLeft && currentSongId < 1) ||
            (corner == CornerPositions.bottomRight && currentSongId > 1));

    return AnimatedOpacity(
      opacity: hideElement ? 0 : 1,
      duration: Duration(milliseconds: 250),
      child: GestureDetector(

        child: Container(
          child: Row(
            children: <Widget>[
              corner == CornerPositions.bottomRight
                  ? CornerButtonLabel(
                      artist: artist,
                      title: title,
                      corner: corner,
                    )
                  : Container(
                      child: null,
                    ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColorDark,
                ),
                width: 35.0,
                height: 35.0,
                child: Center(
                  child: Icon(
                    icon,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              corner == CornerPositions.bottomLeft
                  ? CornerButtonLabel(
                      artist: artist,
                      title: title,
                      corner: corner,
                    )
                  : Container(
                      child: null,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CornerButtonLabel extends StatelessWidget {
  final String artist;
  final String title;
  final CornerPositions corner;

  CornerButtonLabel({
    this.title,
    this.artist,
    this.corner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: corner == CornerPositions.bottomRight ? 10 : 0,
        left: corner == CornerPositions.bottomLeft ? 10 : 0,
      ),
      child: Column(
        crossAxisAlignment: corner == CornerPositions.bottomRight
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            artist,
            style: TextStyle(
              color: textLightColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
              color: textLightColor,
              fontSize: 13,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width / 3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: splashColor,
            spreadRadius: MediaQuery.of(context).size.width / 4,
            blurRadius: MediaQuery.of(context).size.width / 4,
          )
        ],
      ),
      child: null,
    );
  }
}

enum CornerPositions {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}
class VisualizerBar extends StatelessWidget {
  final _activeTiles;

  VisualizerBar(this._activeTiles);

  @override
  Widget build(BuildContext context) {

    // Future.delayed(Duration(seconds: 2),(){
    //   return buildContainer(context);
    // });
    return buildContainer(context);

  }

  Widget buildContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9 / 25,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            for (int i = 13; i > 0; i--)
              VisualizerTile(TilePosition.top, _activeTiles >= i),
            for (int i = 1; i <= 13; i++)
              VisualizerTile(TilePosition.bottom, _activeTiles >= i),
          ],
        ),
      ),
    );
  }

}

class VisualizerTile extends StatelessWidget {
  final TilePosition _tilePosition;
  final bool _isActive;

  VisualizerTile(
      this._tilePosition,
      this._isActive,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isActive
          ? (_tilePosition == TilePosition.top ? tileColorTop : tileColorBottom)
          : Colors.transparent,
      height: MediaQuery.of(context).size.height * .275 / 52,
      child: null,
    );
  }
}

enum TilePosition { top, bottom }