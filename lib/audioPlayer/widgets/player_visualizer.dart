import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quran_app/audioPlayer/widgets/player_current_song.dart';

import 'package:quran_app/audioPlayer/widgets/styleguide.dart';

class PlayerVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          for (int i = 0; i < 23; i++) VisualizerBar(math.Random().nextInt(i)),
        ],
      ),
    );
  }
}


