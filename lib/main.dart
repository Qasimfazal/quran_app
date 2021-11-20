import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quran_app/Qibla/Qibla.dart';
import 'package:quran_app/Screen/About.dart';
import 'package:quran_app/Screen/AzaanScreen.dart';
import 'package:quran_app/Screen/PrivacyPolicy.dart';
import 'package:quran_app/Screen/drawer.dart';
import 'package:quran_app/Screen/manzilList.dart';
import 'package:quran_app/Screen/manzilView.dart';
import 'package:quran_app/Screen/siparahView.dart';
import 'package:quran_app/Screen/quranAudio.dart';
import 'package:quran_app/Utils/preference.dart';
import 'package:quran_app/home_page.dart';
import 'package:quran_app/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Screen/QuranImages.dart';
import 'Screen/SingleSurah.dart';
import 'Screen/SiparahIndex.dart';
import 'Screen/audioSurahList.dart';
import 'Screen/sajdaList.dart';
import 'Screen/surahList.dart';

StreamController<bool> isLightTheme = StreamController();


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void _launchURL(String _url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Preferences.init();
  await Firebase.initializeApp();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/logo');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  print(initializationSettings);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print(message.data);
    print(message.notification.body);
    _launchURL(message.notification.body);

  });
  /// Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  FirebaseMessaging.instance.getInitialMessage();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp()
  );
}

class MyApp extends StatelessWidget {

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    backgroundColor: Color(0xfffe3f1f6),
    primaryColorDark: Color(0xfff1f6266),


  );
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: lightTheme,
      onGenerateRoute: (settings){
        WidgetBuilder builder = (context) => SplashScreen();
        switch (settings.name){
          case SplashScreen.routeName:
            builder = (context) => SplashScreen();
            break;
          case HomePage.routeName:
            builder = (context) => HomePage();
            break;
          case SurahIndex.routeName:
            builder = (context) => SurahIndex();
            break;
          case AudioSurahIndex.routeName:
            builder = (context) => AudioSurahIndex();
            break;
          case SingleSurah.routeName:
            builder = (context) => SingleSurah();
            break;
          case SiparahIndex.routeName:
            builder = (context) => SiparahIndex();
            break;
          case SajdaListView.routeName:
            builder = (context) => SajdaListView();
            break;
          case SiparahView.routeName:
            SiparahView  arguments= settings.arguments;
            builder = (context) => SiparahView(siparahName: arguments.siparahName,juzIndex: arguments.juzIndex,siparahEnglishName: arguments.siparahEnglishName,verses: arguments.verses,);
            break;
          case ManzilList.routeName:
            builder = (context) => ManzilList();
            break;
          case ManzilView.routeName:
            ManzilView  arguments= settings.arguments;
            builder = (context) => ManzilView(siparahName: arguments.siparahName,juzIndex: arguments.juzIndex,);
            break;
          case QuranImages.routeName:
            builder = (context) => QuranImages();
            break;
          case QuranAudio.routeName:
            builder = (context) => QuranAudio();
            break;
          case About.routeName:
            builder = (context) => About();
            break;
          case AppDrawer.routeName:
            builder = (context) => AppDrawer();
            break;
          case Qibla.routeName:
            builder = (context) => Qibla();
            break;
          case PrivacyPolicy.routeName:
            builder = (context) => PrivacyPolicy();
            break;
          case  AzaanScreen.routeName:
            builder = (context) => AzaanScreen();
            break;
        }
        return new MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

