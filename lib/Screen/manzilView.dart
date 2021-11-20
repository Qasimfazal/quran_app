import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:quran_app/Core/provider.dart';
import 'package:quran_app/Model/surat.dart';
import 'package:quran_app/customization/animator.dart';
import 'package:quran_app/customization/loaderClass.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';

class ManzilView extends StatelessWidget {
  static const routeName = '/manzilView';

  final String siparahName;
  final juzIndex,verses;

  ManzilView(
      {this.siparahName,this.juzIndex,this.verses});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<Provider>(
        builder: (controller){
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: appBar(context,title: siparahName),
            body: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric( vertical: 10),
                  child: Column(
                      children: [
                      mainWidget(context,controller),
                  SizedBox(
                    height: 15,
                  ),
                        controller.manzilList == null ?
                  LoadingShimmer()
                          : controller.manzilList.manzilAyahs.length == 0?
                        LoadingShimmer():ListView.builder(

                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.manzilList.manzilAyahs.length,
                  itemBuilder: (context, index) {
                    return line(height, index, width,controller.manzilList.manzilAyahs,context);
                  }),
              ],
            ),
          )));
        });

  }

  Widget line(double height, int index, double width,ayatsList,context) {
    var ayaats = ayatsList[index].ayahsText;
    int inds = index + 1;
    // if( ayatsList[index].ayahsText.toString().contains("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ")){
    //  // var ayaaats = ayatsList[index].toString().split("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ");
    //  // ayaats = ayaaats[1];
    //   ayaats = ayatsList[index].ayahsText;
    //   print(ayaats);
    // }else{
    //   ayaats = ;
    // }
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: WidgetAnimator(
        ListTile(
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
                inds.toString(),
               // / textAlign: TextAlign.right,
                style: smallText(color: Colors.white),
              ),
            ),
          ),
          // title: Container(),
          title: Text(ayaats,
              textAlign: TextAlign.right, style: ayats(),),

        ),
      ),
    );
    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: 70,
    //   child: ListTile(
    //
    //     trailing: Text(ayaats, style: ayats(),maxLines: 12,),
    //   ),
    // );
    // return
    //   Padding(
    //     padding: const EdgeInsets.only(right: 10,left: 10),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.end,
    //       children: [
    //         Text(ayaats, style: ayats(),maxLines: 12,),
    //       ],
    //     ),
    //   );

  /*  return WidgetAnimator(
      Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.all(4.0),
        color: Colors.green,
        width: width*0.25,
          child: Text(ayaats, textAlign: TextAlign.right,style: ayats())),
    );*/
  }


  Widget mainWidget(context,controller) {
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
                          juzIndex.toString(),
                          style: smallText(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Manzil",
                    style: headingWhite(),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    siparahName,
                    style: normalText(color: Colors.grey[200]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Text(
                  //   "$verses Verses",
                  //   style: normalText(color: Colors.grey[200]),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
