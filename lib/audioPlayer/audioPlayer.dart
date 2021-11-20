import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/Utils/preference.dart';
import 'package:quran_app/audioPlayer/widgets/player_current_song.dart';
import 'package:quran_app/audioPlayer/widgets/styleguide.dart';



typedef void OnError(Exception exception);

class PlayerPage extends StatefulWidget {
  final data,index;
  PlayerPage({this.data,this.index});
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _pageAnimation;
  AnimationController _pageController;
  double panStartY;
  double panPosY = 0;
  double panStartAnimation;
  var duration;
  final StreamController _streamController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    getDuration();
    _pageController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _pageAnimation = Tween<double>(begin: 0, end: 1).animate(_pageController)
      ..addListener(
            () {
          _streamController.sink.add(_pageController.value);
        },
      );
  }
  getDuration()async{
    final player = AudioPlayer();
    var durationCheck = await player.setUrl(widget.data[widget.index].link);
    var split = durationCheck.toString().split(".");
    setState(() {
      duration = split[0];
      Preferences().setDuration(duration);
    });
    print("Duration is "+duration.toString());
  }
  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void startPan(double posY) {
    panStartY = posY;
    panStartAnimation = _pageController.value;
    panPosY = 0;
  }

  void endPan(Velocity velocity) {
    if (panStartAnimation == 0) {
      if (velocity.pixelsPerSecond.dy < -50) {
        _pageController.animateTo(1);
      } else {
        _pageController.animateTo(0);
      }
    } else {
      if (velocity.pixelsPerSecond.dy > 50) {
        _pageController.animateTo(0);
      } else {
        _pageController.animateTo(1);
      }
    }
  }

  void updatePan(double offsetY) {
    panPosY += offsetY;
    if (panStartAnimation == 0) {
      if (panPosY > 0) {
        panPosY = 0;
      }
      _pageController.value =
      (panPosY.abs() / MediaQuery.of(context).size.height);
    }
    if (panStartAnimation == 1) {
      if (panPosY < 0) {
        panPosY = 0;
      }
      _pageController.value =
          1 - (panPosY.abs() / MediaQuery.of(context).size.height);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      backgroundColor: backgroundDarkColor,
      body: Stack(
        children: <Widget>[
          PlayerCurrentSong(1 - _pageController.value,widget.data,widget.index,duration),
         // AllTracks(_streamController.stream),

        ],
      ),
    );

  }
}
