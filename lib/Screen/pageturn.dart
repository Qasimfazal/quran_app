import 'package:flutter/material.dart';

import 'package:quran_app/Screen/QuranImages.dart';
import 'package:quran_app/Utils/preference.dart';
import 'package:quran_app/customization/pageTurnWidget.dart';


class PageTurnPage extends StatefulWidget {
  static const routeName = '/quranImages';


  @override
  _PageTurnPageState createState() => _PageTurnPageState();

}
class _PageTurnPageState extends State<PageTurnPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.5,
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    if (_controller.status == AnimationStatus.dismissed || _controller.status == AnimationStatus.reverse) {
      _controller.forward();

    } else {
      _controller.reverse();

    }
  }
  int index = Preferences().index;
  int inds = Preferences().index +1;
  int indss = Preferences().index -1;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
     //   onTap: _onTap,
        onHorizontalDragEnd: (details) {

          // if (details.primaryVelocity <= 0) {
          //   // swiping in right direction
          //   setState(() {
          //
          //     if(index != 1){
          //       index = index -1;
          //       Preferences().setIndex(index);
          //     }
          //     //_controller.value = details.primaryVelocity;
          //   });
          // }else{
          //   setState(() {
          //     if(index != 604){
          //       index = index +1;
          //       Preferences().setIndex(index);
          //     }
          //     //_controller.value = details.velocity.pixelsPerSecond.dx;
          //
          //   });
          //
          // }
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // PageTurnWidget(
            //   amount:  AlwaysStoppedAnimation(0.0),
            //   child:  Image.asset("assets/images/quran/$indss.png",fit: BoxFit.fill,),
            // ),
            PageTurnImage(
              amount: AlwaysStoppedAnimation(1.0),
              image: AssetImage("assets/images/quran/$index.png",),
            ),
            PageTurnWidget(
              amount: _controller,
              child:  Image.asset("assets/images/quran/$inds.png",fit: BoxFit.fill,),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              height: MediaQuery.of(context).size.height,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return Slider(
                    value: _controller.value,
                    activeColor: Colors.transparent,
                    inactiveColor: Colors.transparent,
                    onChangeEnd: (value){
                      print("end is "+value.toString());
                      if(value == 0.0){
                        Future.delayed(Duration.zero,(){
                          setState(() {
                            if (index != 1) {
                              inds = index;
                              index = index - 1;

                              Preferences().setIndex(index);
                            }
                          });
                        });
                      }
                    },


                    onChangeStart: (value){
                      print("start is "+value.toString());
                      if(value == 1.0){
                        Future.delayed(Duration.zero,(){
                          setState(() {
                            if(index != 604){
                              index = index +1;
                              inds = index +1;
                              Preferences().setIndex(index);
                            }
                          });
                        });

                      }
                    },
                    onChanged: (double value) {
                      _controller.value = value;

                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}