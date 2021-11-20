import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/Core/provider.dart';
import 'package:quran_app/Screen/siparahView.dart';
import 'package:quran_app/Screen/surahView.dart';
import 'package:quran_app/Utils/Utils.dart';
import 'package:quran_app/ads/adsProvider.dart';
import 'package:quran_app/customization/animator.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';

class SiparahIndex extends StatefulWidget {
  static const routeName = '/siparah';

  @override
  _SiparahIndexState createState() => _SiparahIndexState();
}

class _SiparahIndexState extends State<SiparahIndex> {
  TextEditingController searchController = new TextEditingController();
  final _controller = Get.put(Provider());
  final _adsController = Get.put(AdsProvider());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getSurahList();
    _adsController.bannerAd();
  }

  @override
  void dispose() {
    _adsController.myBanner.dispose();
    super.dispose();
  }




  Widget futureBuilderUsage() {

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 5),
      itemCount: Utils.allsiparahList.length,
      itemBuilder: (context, index) {
        if (searchController.text.isEmpty) {
          return surahItem(Utils.allsiparahList[index]);
        } else {
          if (Utils.allsiparahList[index].englishName
              .toString()
              .toLowerCase()
              .contains(searchController.text) || Utils.allsiparahList[index].name
              .toString()
              .toLowerCase()
              .contains(searchController.text)) {
            return surahItem(Utils.allsiparahList[index]);
          } else {
            return Container();
          }
        }


      },
    );
  }

  Widget surahItem(surahs) {
    return InkWell(
      onTap: () {
        if(_controller.siparahList != null){
          _controller.siparahList = null;
        }
        _controller.getSiparahList(surahs.index);
        Navigator.pushNamed(context, SiparahView.routeName,arguments: SiparahView(siparahName: surahs.name,juzIndex: surahs.index,siparahEnglishName: surahs.englishName,verses: surahs.verses,));
      },
      child: WidgetAnimator(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
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
                          border: Border.all(
                              color: Theme.of(context).primaryColorDark)),
                      child: Center(
                        child: Text(
                          surahs.index.toString(),
                          style: smallText(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surahs.englishName,
                        style: heading(color: Colors.black),
                      ),


                    ],
                  ),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    child: Text(
                      surahs.name,
                      textAlign: TextAlign.end,
                      style: heading(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider()
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(context,
          leading: Icon(
            Icons.home_outlined,
            color: Theme.of(context).primaryColorDark,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextFormField(
                cursorColor: Colors.black,
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                style: normalText(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                    // width: 0.0 produces a thin "hairline" border
                    borderSide:
                    const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              futureBuilderUsage(),
              // ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: 10,
              //     padding: EdgeInsets.symmetric(vertical: 10),
              //     physics: NeverScrollableScrollPhysics(),
              //     itemBuilder: (context,index){
              //       return   Padding(
              //         padding: EdgeInsets.symmetric(vertical: 10),
              //         child: Column(
              //           children: [
              //             Row(
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 ClipPath(
              //                   // clipper: StarClipper(8),
              //                   child: Container(
              //                     height: 25,
              //                     width: 25,
              //                     decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(20),
              //                         // color: Theme.of(context).primaryColorDark,
              //                         border: Border.all(color: Theme.of(context).primaryColorDark)
              //                     ),
              //                     child: Center(
              //                       child: Text("1",style: normalText(color: Colors.black),),
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(width: 10,),
              //                 Column(
              //                   crossAxisAlignment:CrossAxisAlignment.start,
              //                   children: [
              //                     Text('Al-Fatiha',style: heading(color: Colors.black),),
              //                     SizedBox(height: 2,),
              //                     Text('Meccan - 7 Verses',style: normalText(color: Colors.grey[500]),),
              //                   ],
              //                 ),
              //                 Spacer(),
              //                 Text('الفاتحة‎',style: heading(),),
              //
              //               ],
              //             ),
              //             SizedBox(height: 5,),
              //             Divider()
              //           ],
              //         ),
              //       );
              //     }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _adsController.isLoaded == false?SizedBox.shrink():
      _adsController.adContainer,
    );
  }
}
