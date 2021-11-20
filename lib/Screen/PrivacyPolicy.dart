import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/ads/adsProvider.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';


class PrivacyPolicy extends StatefulWidget {
  static const routeName="/PrivacyPolicy";
  const PrivacyPolicy({Key key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {


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
      appBar: appBar(context,title: "Privacy Policy"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text("At the point when you utilize our applications, you trust us with your data. This Privacy Policy is intended to assist you with getting what information we gather and why we need it. This is significant; We trust you will set aside an effort to peruse it cautiously. We have attempted to keep it as straightforward as could be expected."
                ,style: heading(),),

              SizedBox(height: 10,),
              Text("Device information:"
                ,style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold),),

              SizedBox(height: 10,),
              Text("This Quran application utilizing a standard database to gather data, for example, equipment model, working framework adaptation, portable organization data, city area, and opening any page in this application. We utilize this data so we realize the client experience in this application with the goal that this application can be surprisingly better in the following update."
                ,style: heading(),),

              SizedBox(height: 10,),
              Text("User location:"
                ,style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold),),

              SizedBox(height: 10,),
              Text("This app collects the location of the user to show results preferred in that region. This information is never saved nor shared. The only purpose of the location information is to provide the user with the best results according to his/her location."
                ,style: heading(),),

              SizedBox(height: 10,),
              Text("Storage access:"
                ,style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold),),

              SizedBox(height: 10,),
              Text("This Quran app has to get to capacity in your device so that one of the features works appropriately. Typically required in arrange to you'll downloading records of application needs-from our server to your capacity. So that the include can get to by offline. You must know, we do not take information from your capacity to our server."
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
