import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:quran_app/Qibla/loading_indicator.dart';
import 'package:quran_app/Qibla/qiblah_compass.dart';
import 'package:quran_app/Qibla/qiblah_maps.dart';
import 'package:quran_app/ads/adsProvider.dart';
import 'package:quran_app/customization/widgets.dart';


class Qibla extends StatefulWidget {
  static const routeName="/Qibla";

  const Qibla({Key key}) : super(key: key);

  @override
  _QiblaState createState() => _QiblaState();
}

class _QiblaState extends State<Qibla> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,title: "Qibla Direction"),
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingIndicator();
          if (snapshot.hasError)
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );

          if (snapshot.data)
            return QiblahCompass();
          else
            return Container(
              child: Center(
                child: Text("Unable to get Qibla Directions"),
              ),
            );
        },
      ),
      bottomNavigationBar: _adsController.isLoaded == false?SizedBox.shrink():
      _adsController.adContainer,
    );
  }
}
