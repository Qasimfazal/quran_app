import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/Core/provider.dart';
import 'package:quran_app/Screen/sajdaView.dart';
import 'package:quran_app/Screen/surahView.dart';
import 'package:quran_app/Utils/Utils.dart';
import 'package:quran_app/ads/adsProvider.dart';
import 'package:quran_app/customization/animator.dart';
import 'package:quran_app/customization/loaderClass.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';

class SajdaListView extends StatefulWidget {
  static const routeName = '/sajda';

  @override
  _SajdaListState createState() => _SajdaListState();
}

class _SajdaListState extends State<SajdaListView> {
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

    _controller.getSajdaList();
  }

  Widget futureBuilderUsage(double height,controller) {
    // return FutureBuilder(
    //   future: Provider().getsajdaList(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: Loader(),);
    //       // return LoadingShimmer(
    //       //   text: "Ayahs",
    //       // );
    //     }
    //     else if (snapshot.hasError || (snapshot.hasData == null)) {
    //       return Center(
    //           child: Text("Connectivity Error! Please Check your Connection"));
    //     }
    //     else {
    //
    //     }
    //   },
    // );

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 5),
      itemCount: controller.sajdaList.sajdaAyahs.length,
      itemBuilder: (context, index) {
        if (searchController.text.isEmpty) {
          return surahItem(controller.sajdaList.sajdaAyahs, index,controller);
        } else {
          if (controller.sajdaList.sajdaAyahs[index].surahEnglishName
              .toString()
              .toLowerCase()
              .contains(searchController.text) ||controller.sajdaList.sajdaAyahs[index].surahName
              .toString()
              .toLowerCase()
              .contains(searchController.text) ) {
            return surahItem(controller.sajdaList.sajdaAyahs, index,controller);
          } else {
            return Container();
          }
        }
      },
    );
  }

  Widget surahItem(sajdaAyahs, index,controller) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SajdaView(
                  surahName: sajdaAyahs[index].surahName,
                  surahEnglishName: sajdaAyahs[index].surahEnglishName,
                  englishNameTranslation: sajdaAyahs[index].englishNameTranslation,
                  juz: sajdaAyahs[index].juzNumber,
                  manzil: sajdaAyahs[index].manzilNumber,
                  ruku: sajdaAyahs[index].rukuNumber,
                  sajdaAyahs:sajdaAyahs[index].text,
                  sajdaNumber: sajdaAyahs[index].sajdaNumber,
                  revelationType: sajdaAyahs[index].revelationType,
                  num: sajdaAyahs[index].number.toString(),
                )));
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
                          sajdaAyahs[index].number.toString(),
                          style: smallerText(color: Colors.black),
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
                        sajdaAyahs[index].surahEnglishName,
                        style: heading(color: Colors.black),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        '${sajdaAyahs[index].revelationType}',
                        style: normalText(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    sajdaAyahs[index].surahName,
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
                  controller.sajdaList == null
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
