import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:quran_app/Qibla/Qibla.dart';
import 'package:quran_app/Screen/AzaanScreen.dart';
import 'package:quran_app/Screen/drawer.dart';
import 'package:quran_app/Utils/Utils.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'Core/provider.dart';
import 'Screen/surahView.dart';
import 'Utils/preference.dart';
import 'package:quran_app/ads/adsProvider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final _controller = Get.put(Provider());
  final _adsController = Get.put(AdsProvider());
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  static FirebaseInAppMessaging fiam = FirebaseInAppMessaging();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller.onInit();
    Preferences().setIndex(1);

    // FirebaseInAppMessaging.instance.triggerEvent('chikecn');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //do your stuff
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _adsController.myBanner.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _adsController.onInit();
  // }

  Widget appBar() {
    return AppBar(
      toolbarHeight: 30,
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      centerTitle: true,
      /*actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
              onTap: () {
                // fiam.triggerEvent('chikecn');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AppDrawer()));
              },
              child: Icon(
                CupertinoIcons.settings,
                size: 30,
                color: Theme.of(context).primaryColorDark,
              )),
        ),
      ],*/
      // leading: InkWell(
      //   onTap: (){
      //     _drawerKey.currentState.openDrawer();
      //   },
      //    child: Icon( CupertinoIcons.text_justifyleft,color: Theme.of(context).primaryColorDark,)),
      title: Text(
        'Al-Quran 360',
        style: heading(),
      ),
    );
  }

  Widget DailyQoute() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(colors: [
            Color(0xfff8aa3e6),
            Color(0xfff5f96e1),
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          boxShadow: [
            BoxShadow(
              color: Color(0xfff8aa3e6),
              offset: Offset(0.0, 0.1),
              blurRadius: 20,
              spreadRadius: 1,
            )
          ]),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  // image: DecorationImage(image: AssetImage(Utils.gridModelList[index].layers,),fit: BoxFit.fill,)
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Center(
                      child: Text(
                          "," +
                              "When things are too hard to handle retreat & count your blessings instead." +
                              ",",
                          style: headingWhite())),
                )),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // Utils.gridModelList[index].name != "Sajda Index"?
          //       Container(
          //            height: 40,
          //            width: MediaQuery.of(context).size.width*0.5,
          //           child:Image.asset('assets/images/tajwidLayer.png',fit: BoxFit.fill,)),
          //       // child: Lottie.asset(Utils.gridModelList[index].image,fit: BoxFit.fill,)),
          //
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget imageContainer() {
    return Lottie.asset(
      'assets/images/lottie.json',
      width: 150,
      height: 150,
      fit: BoxFit.fill,
    );
  }

  Widget mainWidget() {
    return InkWell(
      onTap: () {
        _adsController.myBanner.dispose();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SurahAyats(
              ayatsList: Utils.recent.ayahs,
              surahName: Utils.recent.name,
              surahEnglishName: Utils.recent.englishName,
              englishMeaning: Utils.recent.englishNameTranslation,
              verses: Utils.recent.ayahs.length.toString(),
              type: Utils.recent.revelationType,
              ayahNum: Utils.recent.number.toString(),
            ),
          ),
        );
      },
      child: Container(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text("Last Read",style: normalText(color: Colors.grey[200]),),
                //     SizedBox(height: 20,),
                //     Text(Utils.recent.englishName,style:headingWhite(),),
                //     SizedBox(height: 3,),
                //     Text(Utils.recent.ayahs.length.toString() + "Verses",style: normalText(color: Colors.grey[200]),),
                //     SizedBox(height: 3,),
                //     Row(
                //       children: [
                //         Text("Go to",style: normalText(color: Colors.white),),
                //         SizedBox(width: 3,),
                //         Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,size: 15,)
                //       ],
                //     ),
                //
                //   ],
                // ),
                Spacer(),
                Container(
                    // height: 200,
                    width: 50,
                    child: Image.asset(
                      'assets/images/quran3.png',
                      fit: BoxFit.cover,
                    ))
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridBuilder() {
    return Container(
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        itemCount: Utils.gridModelList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              _adsController.showInterstitialAd();
              Navigator.pushNamed(
                  context, Utils.gridModelList[index].pageRoute);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [
                    Utils.gridModelList[index].topColor,
                    Utils.gridModelList[index].bottomColor,
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  boxShadow: [
                    BoxShadow(
                      color: Utils.gridModelList[index].topColor,
                      offset: Offset(0.0, 0.1),
                      blurRadius: 20,
                      spreadRadius: 1,
                    )
                  ]),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          image: DecorationImage(
                            image: AssetImage(
                              Utils.gridModelList[index].layers,
                            ),
                            fit: BoxFit.fill,
                          )),
                      // child: Image.asset( ,fit: )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Utils.gridModelList[index].name != "Sajda Index"?
                        Container(
                            height: 80,
                            width: 80,
                            child: Image.asset(
                              Utils.gridModelList[index].image,
                              fit: BoxFit.contain,
                            )),
                        // child: Lottie.asset(Utils.gridModelList[index].image,fit: BoxFit.fill,)),
                        Spacer(),
                        Text(
                          Utils.gridModelList[index].name,
                          style: headingWhite(),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Go to",
                              style: normalText(color: Colors.white),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.white,
                              size: 15,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2.2 : 2.0),
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdsProvider>(builder: (controller) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                // dotsAnimation(height, width),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    imageContainer(),
                    //DailyQoute(),
                    // SizedBox(height: 10,),
                    Utils.recent == null ? Container() : mainWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    gridBuilder(),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color: Colors.yellow),
          selectedLabelStyle: TextStyle(color: Colors.yellow),
          fixedColor: Colors.black,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Color(0xfff73bec3),
                  size: 30,
                ),
                label: 'Home',
                tooltip: ",ddldlld",
                backgroundColor: Theme.of(context).backgroundColor),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/qiblaimage.ico',
                height: 30,
                width: 30,
                color: Color(0xfff9e82dd),
              ),
              label: 'Qibla',
              backgroundColor: Theme.of(context).backgroundColor,
            ),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/azaanicon.png',
                  height: 30,
                  width: 30,
                  color: Color(0xfffc980bd),
                ),
                label: 'Azaan',
                backgroundColor: Theme.of(context).backgroundColor),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Color(0xfff8aa3e6),
                  size: 30,
                ),
                label: 'Settings',
                backgroundColor: Theme.of(context).backgroundColor),
          ],
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          elevation: 0,
          enableFeedback: false,
          iconSize: 25,
          onTap: _onItemTapped,
        ),
      );
      // controller.isLoaded == false?SizedBox.shrink():
      //         controller.adContainer
    });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    _selectedIndex = index;
    if (index == 1) {
      _adsController.showInterstitialAd();
      Navigator.pushNamed(context, Qibla.routeName);
    }else if(index ==2){
      _adsController.showInterstitialAd();
      Navigator.pushNamed(context, AzaanScreen.routeName);
    }else if(index==3){
      _adsController.showInterstitialAd();
      Navigator.pushNamed(context, AppDrawer.routeName);
    }
  }

  dotsAnimation(screenHeight, screenWidth) {
    return CircularParticle(
      key: UniqueKey(),
      awayRadius: 80,
      numberOfParticles: 200,
      speedOfParticles: 1,
      height: screenHeight,
      width: screenWidth,
      onTapAnimation: true,
      particleColor: Colors.white.withAlpha(150),
      awayAnimationDuration: Duration(milliseconds: 600),
      maxParticleSize: 8,
      isRandSize: true,
      isRandomColor: true,
      randColorList: [
        Colors.red.withAlpha(210),
        Colors.white.withAlpha(210),
        Colors.yellow.withAlpha(210),
        Colors.green.withAlpha(210)
      ],
      awayAnimationCurve: Curves.easeInOutBack,
      enableHover: true,
      hoverColor: Colors.white,
      hoverRadius: 90,
      connectDots: false, //not recommended
    );
  }
}
