import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/Core/provider.dart';
import 'package:quran_app/Screen/surahView.dart';
import 'package:quran_app/Utils/Utils.dart';
import 'package:quran_app/ads/adsProvider.dart';
import 'package:quran_app/customization/animator.dart';
import 'package:quran_app/customization/loaderClass.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';

import 'AudioSurahViews.dart';

class AudioSurahIndex extends StatefulWidget {
  static const routeName = '/audiosurah';

  @override
  _AudioSurahIndexState createState() => _AudioSurahIndexState();
}

class _AudioSurahIndexState extends State<AudioSurahIndex> {
  TextEditingController searchController = new TextEditingController();
  final _controller = Get.put(Provider());
  final _adsController = Get.put(AdsProvider());


  @override
  void dispose() {
    _adsController.myBanner.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _adsController.bannerAd();

    _controller.getAudioSurahList();
  }
  Widget futureBuilderUsage(double height,controller) {

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 5),
      itemCount: controller.audioSurahList.surahs.length,
      itemBuilder: (context, index) {
        if (searchController.text.isEmpty) {
          return surahItem(controller.audioSurahList.surahs, index,controller);
        } else {
          if (controller.audioSurahList.surahs[index].englishName
              .toString()
              .toLowerCase()
              .contains(searchController.text)||controller.audioSurahList.surahs[index].name
              .toString()
              .toLowerCase()
              .contains(searchController.text)) {
            return surahItem(controller.audioSurahList.surahs, index,controller);
          } else {
            return Container();
          }
        }
      },
    );
  }

  Widget surahItem(surahs, index,controller) {
    return InkWell(
      onTap: () {
       // Utils.recent = controller.audioSurahList.surahs[index];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AudioSurahAyats(
              ayatsList: surahs[index].ayahs,
              urduTranslation: controller.urduTranslation.surahs[index].ayahs,
              englishTranslation: controller.englishTranslation.surahs[index].ayahs,
              surahName: surahs[index].name,
              surahEnglishName: surahs[index].englishName,
              englishMeaning: surahs[index].englishNameTranslation,
              verses: surahs[index].ayahs.length.toString(),
              type: surahs[index].revelationType,
              ayahNum: surahs[index].number.toString(),
            ),
          ),
        );
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
                          surahs[index].number.toString(),
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
                        surahs[index].englishName,
                        style: heading(color: Colors.black),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        '${surahs[index].revelationType} - ${surahs[index].ayahs.length} Verses',
                        style: normalText(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    surahs[index].name,
                    style: heading(),
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
    final height = MediaQuery.of(context).size.height;
    return GetBuilder<Provider>(
      builder: (controller){
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
                  controller.audioSurahList == null
                      ? LoadingShimmer()
                      : futureBuilderUsage(height,controller)
                ],
              ),
            ),
          ),
          bottomNavigationBar: _adsController.isLoaded == false?SizedBox.shrink():
          _adsController.adContainer,
        );
      },
    );
  }
}
