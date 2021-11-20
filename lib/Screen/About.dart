import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/ads/adsProvider.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';



class About extends StatefulWidget {
  static const routeName = '/About';

  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

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
      appBar: appBar(context,title: "About"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text("Al-Quran 360 is a free mobile-religious application that provides the Muslim community with the service of Online Quran. Here the users can read, recite, listen and even learn the Holy Quran."
            ,style: heading(),),

              SizedBox(height: 10,),
              Text("It also provides information about some aspects of the Quran such as where the 7 sajdah.When you open our app, the services that are shown to you are:"
                ,style: heading(),),

              SizedBox(height: 10,),
              Text("Full Quran :"
                ,style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold),),

              SizedBox(height: 10,),
              Text("The whole Quran is uploaded and available here in the form of digital pages. This way our app serves as a pocket Quran! Just take out your mobile and start reciting. anywhere, anytime."
                ,style: heading(),),

              SizedBox(height: 10,),
              Text("Manzil:"
                ,style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold),),

              SizedBox(height: 10,),
              Text("The manzil is uploaded here for you to read. Start your day, end it, start and end anything and have it blesses by reciting the manzil in our app before and after."
                ,style: heading(),),

              SizedBox(height: 10,),
              Text("Juzz index:"
                ,style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold),),

              SizedBox(height: 10,),
              Text("All the 30 parts (para’s) of the holy Quran are listed here for you to easily access in case if you wanted to read a specific one."
                ,style: heading(),),

              SizedBox(height: 10,),
              Text("Sajda index:"
                ,style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold),),

              SizedBox(height: 10,),
              Text("The exact points are pointed here where there is sajdah in the Quran."
                ,style: heading(),),

              SizedBox(height: 10,),
              Text("Quran audio:"
                ,style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold),),

              SizedBox(height: 10,),
              Text("Want to listen to the soulful recitation of the Holy Quran? The complete Holy Quran is available in the form of audio in the voice of a professional Qari."
                ,style: heading(),),
              SizedBox(height: 10,),
              Text("Translation:"
                ,style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold),),

              SizedBox(height: 10,),
              Text("The holy book of the Quran is translated into Urdu and English for your understanding. Our goal is to make the teachings of Islam easily approachable for everyone."
                ,style: heading(),),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _adsController.isLoaded == false?SizedBox.shrink():
      _adsController.adContainer,
    );
  }
}
