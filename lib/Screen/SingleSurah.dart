import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/customization/clippers.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';

class SingleSurah extends StatefulWidget {
  static const routeName = '/singleSurah';

  @override
  _SingleSurahState createState() => _SingleSurahState();
}

class _SingleSurahState extends State<SingleSurah> {

  Widget mainWidget(){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
              colors: [
                Color(0xfff36b5ab),
                Color(0xfff7dc695),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xfff6d9696),
              offset:  Offset(0.0, 0.1),
              blurRadius: 20,
              spreadRadius: 1,
            )
          ]
      ),
      child: Stack(
        children: [
          Container(
              child: Image.asset('assets/images/layers.png',fit: BoxFit.fill,)),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child:    Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipPath(
                    // clipper: StarClipper(8),
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Theme.of(context).primaryColorDark,
                          border: Border.all(color: Colors.white)
                      ),
                      child: Center(
                        child: Text("1",style: normalText(color: Colors.white),),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Al-Rehman",style:headingWhite(),),
                  SizedBox(height: 3,),
                  Text("The Merciful",style: normalText(color: Colors.grey[200]),),
                  SizedBox(height: 15,),
                  Text("Medinian - 78 Verses",style: normalText(color: Colors.grey[200]),),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(context,title: "Al-Rehman"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          children: [
            mainWidget(),
            SizedBox(height: 15,),
            Image.asset("assets/images/bism.png",color: Color(0xfff36b5ab ),),
            SizedBox(height: 5,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: [
                  SizedBox(width: 15,),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color:  Color(0xfff36b5ab),
                      shape: BoxShape.circle,boxShadow: [
                      BoxShadow(
                        color: Color(0xfff6d9696),
                        offset:  Offset(0.0, 0.1),
                        blurRadius: 20,
                        spreadRadius: -1,
                      )
                    ]

                    ),
                    child: Center(child:Text("1",style: normalText(color: Colors.white),),),
                  ),
                  Spacer(),
                  Icon(CupertinoIcons.play,color:  Color(0xfff36b5ab),size: 30,),
                  SizedBox(width: 5,),
                  Icon(Icons.share,color:  Color(0xfff36b5ab),size: 30,),
                  SizedBox(width: 5,),
                  Icon(Icons.bookmark_border,color:  Color(0xfff36b5ab),size: 30,),
                  SizedBox(width: 15,),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Align(
              alignment: Alignment.centerRight,
              child:Text("ٱلرَّحْمَٰنُ",style: heading(),),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child:Text("The Merciful",style: heading(),),
            ),
            SizedBox(height: 15,),
            Divider()
          ],
        ),
      ),
    );
  }
}
