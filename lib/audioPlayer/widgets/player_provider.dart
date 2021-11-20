import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';

import 'dummydata.dart';



class PlayerProvider extends GetxController {
  AudioPlayer audioPlayer;
  PlayerState audioPlayerState;
  Duration _duration = Duration();
  Duration _position = Duration();
  int _songId = 0;


  AudioPlayer get audioPlayers => audioPlayer;

  PlayerState get _audioPlayerState => audioPlayerState;

  Duration get duration => _duration;

  Duration get position => _position;

  bool get isPlaying => audioPlayerState.playing;

  int get songId => _songId;
  @override
  void onInit() {
    super.onInit();
  }
  String getArtist() {

    // if (audioPlayerState == PlayerState.PLAYING ||
    //     audioPlayerState == PlayerState.PAUSED) {
    //   return _songsData[_songId]['artist'];
    // }
    return "";
  }

  String getTitle() {
    // if (audioPlayerState == PlayerState.PLAYING ||
    //     audioPlayerState == PlayerState.PAUSED) {
    //   return _songsData[_songId]['title'];
    // }
    return "";
  }

  String getPositionFormatted() {
    String twoDigitSeconds =
        _position.inSeconds.remainder(Duration.secondsPerMinute) >= 10
            ? "${_position.inSeconds.remainder(Duration.secondsPerMinute)}"
            : "0${_position.inSeconds.remainder(Duration.secondsPerMinute)}";
    if (audioPlayerState.playing) {
      return "${_position.inMinutes}:$twoDigitSeconds";
    }
    return "";
  }

  String getDurationFormatted() {
    String twoDigitSeconds =
        _duration.inSeconds.remainder(Duration.secondsPerMinute) >= 10
            ? "${_duration.inSeconds.remainder(Duration.secondsPerMinute)}"
            : "0${_duration.inSeconds.remainder(Duration.secondsPerMinute)}";
    if (audioPlayerState.playing) {
      return "${_duration.inMinutes}:$twoDigitSeconds";
    }
    return "";
  }

  Map<String, String> getSongData([songId]) {
   // return _songsData[songId ?? _songId];
  }

  void play([songId]) {
    audioPlayer.play();
    // _songId = songId ?? _songId ?? 0;
    // audioCache.play(_songsData[_songId]['file']);
  }

  void pause() {
    audioPlayer.pause();
  }

  void seekSecond(int seconds) {
    audioPlayer.seek(Duration(seconds: seconds));
  }

  PlayerProvider() {
    audioPlayer = AudioPlayer();

    audioPlayer.durationStream.listen((Duration duration) {
      _duration = duration;
      update();
    });

    audioPlayer.positionStream.listen((Duration position) {
      _position = position;
      update();
    });

    audioPlayer.playerStateStream.listen((state) {
      audioPlayerState =state;
      update();

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
          _position = Duration();
          _duration = Duration();
          update();
          break;
    
      }
    });

  
  }
}
