
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/Qibla/Qibla.dart';
import 'package:quran_app/Screen/About.dart';
import 'package:quran_app/Screen/PrivacyPolicy.dart';
import 'package:quran_app/ads/adsProvider.dart';
import 'package:quran_app/customization/widgets.dart';


class AppDrawer extends StatefulWidget {
  static const routeName="/AppDrawer";
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
      appBar: appBar(context,title: "Settings"),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(child: Container(
              height: 50,
              width: 50,
              child: Image.asset("assets/logo.png",fit: BoxFit.contain,),
            )
            ),
            Container(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          _adsController.showInterstitialAd();
                          Navigator.pushNamed(context, PrivacyPolicy.routeName);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height:150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xfff36b5ab),
                                    Color(0xfff7dc695),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xfff6d9696),
                                  offset:  Offset(0.0, 0.1),
                                  blurRadius: 20,
                                  spreadRadius: 1,
                                )
                              ]
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  child: Image.asset('assets/images/layers.png',fit: BoxFit.fill,)),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      // height: 200,
                                        width: 50,
                                        child:Image.asset("assets/front/privacyimage.png")
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Privacy Policy",style: TextStyle(color: Colors.white,fontSize: 16))
                                  ]
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: (){
                          _adsController.showInterstitialAd();
                         Navigator.pushNamed(context,About.routeName);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height:150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xfff36b5ab),
                                    Color(0xfff7dc695),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xfff6d9696),
                                  offset:  Offset(0.0, 0.1),
                                  blurRadius: 20,
                                  spreadRadius: 1,
                                )
                              ]
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  child: Image.asset('assets/images/layers.png',fit: BoxFit.fill,)),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      // height: 200,
                                        width: 50,
                                        child:Image.asset("assets/front/aboutimage.png")
                                    ),
                                    SizedBox(height: 10,),
                                    Text("About",style: TextStyle(color: Colors.white,fontSize: 16),)
                                  ]
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                /*  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>Qibla()
                          ));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      height:150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              colors: [
                                Color(0xfff36b5ab),
                                Color(0xfff7dc695),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xfff6d9696),
                              offset:  Offset(0.0, 0.1),
                              blurRadius: 20,
                              spreadRadius: 1,
                            )
                          ]
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                              child: Image.asset('assets/images/layers.png',fit: BoxFit.fill,)),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // height: 200,
                                    width: 50,
                                    child:Image.asset("assets/front/qiblaimage.png")
                                ),
                                SizedBox(height: 10,),
                                Text("Qibla",style: TextStyle(color: Colors.white,fontSize: 16))
                              ]
                          ),
                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
            )
            // _createDrawerItem(icon: Icons.privacy_tip_rounded, text: 'Privacy Policy',onTap: (){
            //
            // }),
            // _createDrawerItem(icon: Icons.note_outlined, text: 'Terms & Conditions',onTap: (){
            //
            // }),
            //
            // _createDrawerItem(
            //     icon: Icons.account_box_sharp, text: 'About',onTap: (){
            //
            // }),

          ],
        ),
      ),
      bottomNavigationBar: _adsController.isLoaded == false?SizedBox.shrink():
      _adsController.adContainer,
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon,color:  Theme.of(context).primaryColorDark,size: 25,),
          SizedBox(width: 5,),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}