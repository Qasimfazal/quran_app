import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/Model/surat.dart';
import 'package:quran_app/Utils/Utils.dart';
import 'package:quran_app/customization/animator.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';

class SajdaView extends StatelessWidget {
  static const routeName = '/sajdaView';

  final String sajdaAyahs;
  final int juz;
  final int ruku;
  final int manzil;
  final int sajdaNumber;
  final String surahName;
  final String surahEnglishName;
  final String englishNameTranslation;
  final String revelationType;
  final  num;
  SajdaView (
      {this.sajdaAyahs,
        this.revelationType,
        this.juz,
        this.ruku,
        this.manzil,
        this.sajdaNumber,
        this.surahEnglishName,
        this.englishNameTranslation,
        this.surahName,this.num});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: appBar(context,title: surahName),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mainWidget(context),
                SizedBox(
                  height: 15,
                ),
                line(height, width),
                SizedBox(
                  height: 25,
                ),
                Text("Sajda Informatrion",style: heading(),),
                SizedBox(
                  height: 3,
                ),
                Text("Juz: ${Utils.allsiparahList[juz-1].name}",style: heading(),),
                SizedBox(
                  height: 3,
                ),
                Text("Ruku: ${ruku.toString()}",style: heading(),),
                SizedBox(
                  height: 3,
                ),
                Text("Manzil: ${manzil.toString()}",style: heading(),),
                SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
        ));
  }

  Widget line(double height, double width) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.015, 0, 0, 0),
      child: WidgetAnimator(
        ListTile(
          title: Text(sajdaAyahs,
              textAlign: TextAlign.right, style: ayats()),
        ),
      ),
    );
  }


  Widget mainWidget(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(colors: [
            Color(0xfff36b5ab),
            Color(0xfff7dc695),
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          boxShadow: [
            BoxShadow(
              color: Color(0xfff6d9696),
              offset: Offset(0.0, 0.1),
              blurRadius: 20,
              spreadRadius: 1,
            )
          ]),
      child: Stack(
        children: [
          Container(
              child: Image.asset(
                'assets/images/layers.png',
                fit: BoxFit.fill,
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
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
                          border: Border.all(color: Colors.white)),
                      child: Center(
                        child: Text(
                          num,
                          style: smallerText(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    surahEnglishName,
                    style: headingWhite(),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    surahName,
                    style: normalText(color: Colors.grey[200]),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    englishNameTranslation,
                    style: normalText(color: Colors.grey[200]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "$revelationType",
                    style: normalText(color: Colors.grey[200]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
