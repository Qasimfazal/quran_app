import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/Utils/preference.dart';
import 'package:quran_app/customization/widgets.dart';

class QuranImages extends StatefulWidget {
  static const routeName = '/quranImages';
  // final index;
  // QuranImages({this.index});

  @override
  _QuranImagesState createState() => _QuranImagesState();
}

class _QuranImagesState extends State<QuranImages>with TickerProviderStateMixin {
  List<AnimationController> _controllers = [];
  bool _isForward;

  int index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if(Preferences().bookmark == 0){
      index = Preferences().bookmark+1;
    }else{
      index = Preferences().bookmark;
    }
  }
  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    int ind = index +1;
    int inds = index -1;
    if(inds == 0){
      inds = 1;
    }
    if(ind == 605){
      ind = 604;
    }

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon( Icons.stay_primary_landscape_sharp,color: Theme.of(context).primaryColorDark,),title: Container()),
            BottomNavigationBarItem(icon: Icon( Icons.stay_primary_portrait_sharp,color: Theme.of(context).primaryColorDark,),title: Container()),
          ],
          onTap: (index){
            if(index == 0){
             setState(() {
               SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
             }); // it starts the animation
            }else{
              setState(() {
                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
              });
            }
          },
        ),
        appBar: appBar(context,
            color: Colors.transparent,
            leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                Icons.home_outlined,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
        actions: [
          Container(
            child: InkWell(
              onTap: (){
                if(Preferences().bookmark == index){
                  Preferences().setBookmark(0);
                }else{
                  Preferences().setBookmark(index);
                }

                setState(() {

                });
              },
              child: Icon(
                Preferences().bookmark == index?Icons.bookmark:Icons.bookmark_border,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ]
        ),

        body: OrientationBuilder(
          builder: (context, orientation) {
            if(orientation == Orientation.portrait){

              return buildDismissible(inds, ind, context,BoxFit.fill);
            }else{
              return buildDismissible(inds, ind, context,BoxFit.cover);
            }

          }
        ),
      ),
    );
  }

  Widget buildDismissible(int inds, int ind, BuildContext context,BoxFit boxFit) {
    return Dismissible(

              // onHorizontalDragEnd: (details) {
              //
              //   if (details.primaryVelocity <= 0) {
              //     // swiping in right direction
              //     setState(() {
              //       if(index != 1){
              //         index = index -1;
              //         Preferences().setIndex(index);
              //       }
              //     });
              //   }else{
              //     setState(() {
              //       if(index != 604){
              //         index = index +1;
              //         Preferences().setIndex(index);
              //       }
              //     });
              //
              //   }
              // },



            key: UniqueKey(),
            behavior: HitTestBehavior.opaque,
            direction: index == 1?DismissDirection.startToEnd:index == 604 ?DismissDirection.endToStart:DismissDirection.horizontal,
            dragStartBehavior: DragStartBehavior.down,
            secondaryBackground: Image.asset("assets/images/quran/$inds.png",fit: boxFit,) ,
            background: Image.asset("assets/images/quran/$ind.png",fit: boxFit,),
            resizeDuration: null,
            onDismissed: (DismissDirection direction){
              if (direction == DismissDirection.startToEnd) {
                setState(() {
                  if (index != 604) {
                    index = index + 1;
                    Preferences().setIndex(index);
                  }
                });
              } else {
                setState(() {
                  if (index != 1) {
                    index = index - 1;
                    Preferences().setIndex(index);
                  }
                });
              }
      },

            child:  boxFit == BoxFit.fill?Container(
             height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/images/quran/$index.png",fit: boxFit,),
            ):SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/images/quran/$index.png",fit: boxFit,),
              ),
            ),
          );
  }

}
