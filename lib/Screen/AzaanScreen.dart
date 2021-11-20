import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:quran_app/Core/Apis.dart';
import 'package:quran_app/ads/adsProvider.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';

class AzaanScreen extends StatefulWidget {
  static const routeName = '/AzaanScreen';

  const AzaanScreen({Key key}) : super(key: key);

  @override
  _AzaanScreenState createState() => _AzaanScreenState();
}


class _AzaanScreenState extends State<AzaanScreen> {
  Location location = new Location();
  LocationData _locationData;
  var prayerTimes;
  var zone;
  String selectedUser;
  final _adsController = Get.put(AdsProvider());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocation();
    _adsController.bannerAd();

  }

  @override
  void dispose() {
    _adsController.myBanner.dispose();
    super.dispose();
  }


  // setzone(var calculate,lat,lng) async {
  //   final nyUtcOffset = Duration(hours: -0);
  //   final date = DateComponents.from(DateTime.now());
  //   final myCoordinates = Coordinates(lat,lng); // R
  //   final params = calculate;
  //   params.madhab = Madhab.hanafi;
  //   prayerTimes= PrayerTimes(myCoordinates, date, params);
  //   setState(() {
  //   });
  // }
  getlocation() async {
        _locationData = await location.getLocation();
        var response = await QuranAPI().getNamaz(_locationData.latitude, _locationData.longitude);
        print(response.toString());
        Map<String, dynamic> data = response.data;
        prayerTimes=data['data']['timings'];
        zone=data['data']['meta'];
        setState(() {});
  }
  // List<String> users = <String>[
  //   'muslim_world_league', 'north_america', 'dubai', 'egyptian','kuwait','singapore','turkey','tehran'
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,title: "Adhan Timmings",actions: <Widget>[
        // Container(
        //   child: Padding(
        //       padding: EdgeInsets.only(right: 10.0),
        //       child: DropdownButton<String>(
        //         hint:  Text("Select Zone",style: TextStyle(fontSize: 12),),
        //         value: selectedUser,
        //         onTap: (){
        //         },
        //         onChanged: (Value) {
        //           setState(() {
        //             selectedUser = Value;
        //           });
        //           if(selectedUser=="muslim_world_league"){
        //             setzone(CalculationMethod.muslim_world_league.getParameters(),30.3753,69.3451);
        //           }else if(selectedUser=="north_america"){
        //             setzone(CalculationMethod.north_america.getParameters(),54.5260, 105.2551);
        //           }else if(selectedUser=="dubai"){
        //             setzone(CalculationMethod.dubai.getParameters(),25.2048,55.2708);
        //           }else if(selectedUser=="egyptian"){
        //             setzone(CalculationMethod.egyptian.getParameters(),26.8206,30.8025);
        //           }else if(selectedUser=="kuwait"){
        //             setzone(CalculationMethod.kuwait.getParameters(),29.3117,47.4818);
        //           }else if(selectedUser=="singapore"){
        //             setzone(CalculationMethod.singapore.getParameters(),1.3521,103.8198);
        //           }else if(selectedUser=="turkey"){
        //             setzone(CalculationMethod.turkey.getParameters(),38.9637,35.2433);
        //           }else if(selectedUser=="tehran"){
        //             setzone(CalculationMethod.tehran.getParameters(),35.6892,51.3890);
        //           }
        //         },
        //         items: users.map((value) {
        //           return  DropdownMenuItem<String>(
        //             value: value,
        //             child: Text(value, style:  TextStyle(color: Colors.black),),
        //           );
        //         }).toList(),
        //       ),
        //   ),
        // ),
      ],),
      body:prayerTimes==null? Center(
        child: CircularProgressIndicator(
          color: Colors.black54,
        ),
      ):Container(
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.20,
                    child: Image.asset("assets/icons/sample.3jpg",fit: BoxFit.fill,),
                  ),
                  Text(prayerTimes==null?"Pk Zone":" Your Local Timezone : "+zone['timezone'],style: TextStyle(color: Colors.white,fontFamily: 'Sen',fontSize: 18,fontWeight: FontWeight.bold))
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,top: 150),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            NamazCard(Color(0xfff197ea0),Color(0xfff8aa3e6),"FAJR",prayerTimes['Fajr'],"assets/icons/fajar.png"),
                            NamazCard(Color(0xfff197ea0),Color(0xfff73bec3), "SUNRISE",prayerTimes['Sunrise'],"assets/icons/fajaricon.png"),
                            NamazCard(Color(0xfff197ea0),Color(0xfffc980bd), "DHUHR",prayerTimes['Dhuhr'],"assets/icons/zuharicon.png"),
                            NamazCard( Color(0xfff197ea0),Color(0xfff9e82dd),"ASR",prayerTimes['Asr'],"assets/icons/asaricon.png"),
                            NamazCard(Color(0xfff197ea0), Color(0xfffb385d0),"MAGHRIB",prayerTimes['Maghrib'],"assets/icons/magribicon.png"),
                            NamazCard(Color(0xfff197ea0),Color(0xfff73bec3), "ISHA",prayerTimes['Isha'],"assets/icons/ishaicon.png"),
                /*            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text("Fajar :",style: heading()),
                                Spacer(),
                                Text(DateFormat.jm().format(prayerTimes.fajr)==null?"":DateFormat.jm().format(prayerTimes.fajr).toString(),style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text("sunrise :",style: heading()),
                                Spacer(),
                                Text(DateFormat.jm().format(prayerTimes.sunrise)==null?"":DateFormat.jm().format(prayerTimes.sunrise).toString(),style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text("dhuhr :",style: heading()),
                                Spacer(),
                                Text(DateFormat.jm().format(prayerTimes.dhuhr)==null?"":DateFormat.jm().format(prayerTimes.dhuhr).toString(),style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text("asr :",style: heading()),
                                Spacer(),
                                Text(DateFormat.jm().format(prayerTimes.asr)==null?"":DateFormat.jm().format(prayerTimes.asr).toString(),style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text("maghrib :",style: heading()),
                                Spacer(),
                                Text(DateFormat.jm().format(prayerTimes.maghrib)==null?"":DateFormat.jm().format(prayerTimes.maghrib).toString(),style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text("isha :",style: heading()),
                                Spacer(),
                                Text(DateFormat.jm().format(prayerTimes.isha)==null?"":DateFormat.jm().format(prayerTimes.isha).toString(),style: TextStyle(color: Colors.black,fontFamily: 'Sen',fontSize: 22,fontWeight: FontWeight.bold)),
                              ],
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _adsController.isLoaded == false?SizedBox.shrink():
      _adsController.adContainer,
    );
  }
  Widget NamazCard(var color1,color2,name,time,image){
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: color2,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.asset(image,height: 50,width: 50,color: color1,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(name==null?"Namaz":name,style: TextStyle(color: Colors.white,fontFamily: 'Sen',fontSize: 20,fontWeight: FontWeight.bold)),
                    ),
                   SizedBox(height: 2,),
                    SizedBox(
                      height: 1.0,
                      width: MediaQuery.of(context).size.width*0.55,
                      child: new Center(
                        child: new Container(
                          margin: new EdgeInsetsDirectional.only(start: 0, end: 0),
                          height: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 2,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(time==null?"Time":time,style: TextStyle(color: Colors.white,fontFamily: 'Sen',fontSize: 20,fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
