import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ads/adsProvider.dart';
import 'customization/customSplash.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver{

  final _adsController = Get.put(AdsProvider());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _adsController.onInit();

  }

  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {1: HomePage(), 2: HomePage()};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSplash(
        imagePath: 'assets/launcher.jpg',
        backGroundColor: Theme.of(context).backgroundColor,
        animationEffect: 'zoom-in',
        logoSize: 200,
        home: HomePage.routeName,
        customFunction: duringSplash,
        duration: 2500,
        type: CustomSplashType.StaticDuration,
        outputAndHome: op,
      ),
    );
  }
}
