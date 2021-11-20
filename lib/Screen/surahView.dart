import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/Model/englishTranslation.dart';
import 'package:quran_app/Model/surat.dart';
import 'package:quran_app/Model/urduTranslation.dart';
import 'package:quran_app/customization/animator.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';

class SurahAyats extends StatelessWidget {
  final List<Ayat> ayatsList;
  final  urduTranslation;
  final  englishTranslation;
  final String surahName;
  final String surahEnglishName;
  final String englishMeaning;
  final String verses;
  final String type;
  final String ayahNum;
  SurahAyats(
      {this.ayatsList,
      this.urduTranslation,
      this.englishTranslation,
      this.englishMeaning,
      this.surahEnglishName,
      this.surahName,
      this.verses,
      this.type,
      this.ayahNum});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: appBar(context, title: surahName),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                mainWidget(context),
                SizedBox(
                  height: 15,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: ayatsList.length,
                    itemBuilder: (context, index) {
                      return line(context,height, index, width);
                    }),
              ],
            ),
          ),
        ));
  }

  Widget line(context,double height, int index, double width) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.015, 0, 0, 0),
      child: WidgetAnimator(
        Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              trailing: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: Color(0xfff36b5ab),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xfff6d9696),
                        offset: Offset(0.0, 0.1),
                        blurRadius: 20,
                        spreadRadius: -1,
                      )
                    ]),
                child: Center(
                  child: Text(
                    ayatsList[index].number.toString(),
                    textAlign: TextAlign.right,
                    style: smallText(color: Colors.white),
                  ),
                ),
              ),
              title: Text(ayatsList[index].text,
                  textAlign: TextAlign.right, style: ayats()),
            ),

          ],
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
                          ayahNum,
                          style: smallText(color: Colors.white),
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
                    englishMeaning,
                    style: normalText(color: Colors.grey[200]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "$type - $verses Verses",
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
