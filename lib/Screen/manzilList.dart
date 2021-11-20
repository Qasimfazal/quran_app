import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/Core/provider.dart';
import 'package:quran_app/Screen/manzilView.dart';
import 'package:quran_app/Utils/Utils.dart';
import 'package:quran_app/ads/adsProvider.dart';
import 'package:quran_app/customization/animator.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';

class ManzilList extends StatefulWidget {
  static const routeName = '/manzil';

  @override
  _ManzilListState createState() => _ManzilListState();
}

class _ManzilListState extends State<ManzilList> {
  TextEditingController searchController = new TextEditingController();
  final _controller = Get.put(Provider());
  final _adsController = Get.put(AdsProvider());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      itemCount: Utils.manzilList.length,
      itemBuilder: (context, index) {
        var i = index + 1;
        if (searchController.text.isEmpty) {
          return surahItem(Utils.manzilList[index], i);
        } else {
          if (Utils.manzilList[index].name
              .toString()
              .toLowerCase()
              .contains(searchController.text)) {
            return surahItem(Utils.manzilList[index], i);
          } else {
            return Container();
          }
        }
      },
    );
  }

  Widget surahItem(surahs, indexs) {
    return InkWell(
      onTap: () {
        if(_controller.manzilList != null){
          _controller.manzilList.manzilAyahs.clear();
        }
        // if (_controller.manzilList != null) {
        //   _controller.manzilList = null;
        // }

        Navigator.pushNamed(context, ManzilView.routeName,
            arguments: ManzilView(siparahName: surahs.name, juzIndex: indexs));
        _controller.getManzilList(indexs);

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
                          indexs.toString(),
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
                        surahs.name,
                        style: heading(color: Colors.black),
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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(context,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.home_outlined,
              color: Theme.of(context).primaryColorDark,
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              buildTextFormField(),
              SizedBox(
                height: 20,
              ),
              futureBuilderUsage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _adsController.isLoaded == false?SizedBox.shrink():
      _adsController.adContainer,
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
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
          borderSide: const BorderSide(color: Colors.white, width: 0.0),
        ),
        border: const OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
