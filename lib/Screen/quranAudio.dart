import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/Core/provider.dart';
import 'package:quran_app/Screen/surahView.dart';
import 'package:quran_app/Utils/Utils.dart';
import 'package:quran_app/ads/adsProvider.dart';
import 'package:quran_app/audioPlayer/audioPlayer.dart';
import 'package:quran_app/customization/animator.dart';
import 'package:quran_app/customization/loaderClass.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';

class QuranAudio extends StatefulWidget {
  static const routeName = '/quranAudio';

  @override
  _QuranAudioState createState() => _QuranAudioState();
}

class _QuranAudioState extends State<QuranAudio> {
  TextEditingController searchController = new TextEditingController();

  final _controller = Get.put(Provider());

  final _adsController = Get.put(AdsProvider());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getAudio();
    _adsController.bannerAd();
  }

  @override
  void dispose() {
    _adsController.myBanner.dispose();
    super.dispose();
  }






  Widget futureBuilderUsage(double height,controller) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 5),
      itemCount: controller.count,
      itemBuilder: (context, index) {
        if (searchController.text.isEmpty) {
          return surahItem(controller.data, index,controller);
        } else {
          if (controller.data[index].sora
              .toString()
              .toLowerCase()
              .contains(searchController.text)) {
            return surahItem(controller.data, index,controller);
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
        //BotToast.showLoading();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>PlayerPage(
              data: surahs,
              index: index,
            ),

          ),
        );
        // BotToast.closeAllLoading();
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
                          surahs[index].soraNumber.toString(),
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
                        surahs[index].sora,
                        style: heading(),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        '${surahs[index].type} - ${surahs[index].ayatsNumber} Verses',
                        style: normalText(color: Colors.grey[500]),
                      ),
                    ],
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
                  controller.audioList == null
                      ? Center(
                    child: LoadingShimmer(),
                  )
                      : futureBuilderUsage(height,controller.audioList)
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
