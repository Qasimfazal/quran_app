import 'package:flutter/material.dart';
import 'package:quran_app/Model/SiparahModel.dart';
import 'package:quran_app/Model/gridModel.dart';
import 'package:quran_app/Screen/QuranImages.dart';
import 'package:quran_app/Screen/SiparahIndex.dart';
import 'package:quran_app/Screen/audioSurahList.dart';
import 'package:quran_app/Screen/manzilList.dart';
import 'package:quran_app/Screen/sajdaList.dart';
import 'package:quran_app/Screen/pageturn.dart';
import 'package:quran_app/Screen/quranAudio.dart';

class Utils{
  static var surahLists;
  static var urduTranslationList;
  static var englishTranslationList;
  static var siparahLists;
  static var sajdaList;
  static var manzilLists;
  static var recent;
  static bool audioList = false;
 static List<GridModel> gridModelList = [
   GridModel(
     name: "Full Quran",
     layers: 'assets/images/tajwidLayer.png',
     //image: 'assets/5.json',
     image: 'assets/front/full quran-01-01-01.png',
     pageRoute: QuranImages.routeName,
     topColor: Color(0xfff8aa3e6),
     bottomColor: Color(0xfff5f96e1),
       isAdd: false
   ),
    GridModel(
      name: "Manzil",
      layers: 'assets/images/quranLayer.png',
      //image: 'assets/4.json',
      image: 'assets/front/manzil-01.png',
      pageRoute: ManzilList.routeName,
      topColor: Color(0xfff73bec3),
      bottomColor: Color(0xfff197ea0),
      isAdd: false
    ),

    GridModel(
      name: "Sajda Index",
      layers: 'assets/images/sajdaLayer.png',
     // image: 'assets/3.json',
      image: 'assets/front/sajda index-01.png',
      pageRoute: SajdaListView.routeName,
      topColor: Color(0xfffc980bd),
      bottomColor: Color(0xfffd377a2),
        isAdd: false

    ),

   GridModel(
     name: "Juzz Index",
     layers: 'assets/images/bookmarkLayer.png',
    // image: 'assets/2.json',
     image: 'assets/front/juzz index-01.png',
     pageRoute: SiparahIndex.routeName,
     topColor: Color(0xfff8aa3e6),
     bottomColor: Color(0xfff5f96e1),
       isAdd: false
   ),

    GridModel(
      name: "Quran Audio",
      layers: 'assets/images/tajwidLayer.png',
      //image: 'assets/6.json',
      image: 'assets/front/audio-01.png',
      pageRoute: QuranAudio.routeName,
      topColor: Color(0xfff9e82dd),
      bottomColor: Color(0xfffb385d0),
        isAdd: false
    ),
    GridModel(
      name: "Translation",
      layers: 'assets/images/tajwidLayer.png',
     // image: 'assets/7.json',
      image: 'assets/front/translation-01-01.png',
      pageRoute: AudioSurahIndex.routeName,
      topColor: Color(0xfff9e82dd),
      bottomColor: Color(0xfffb385d0),
        isAdd: false
    ),
  ];

 static List<SiparahListModel> allsiparahList = [
   SiparahListModel("الم","Alif Lam Meem",1,148),
   SiparahListModel("سَيَقُولُ","Sayaqool",2,111),
   SiparahListModel("تِلْكَ الرُّسُلُ","Tilkal Rusull",3,126),
   SiparahListModel("لَنْ تَنَالُوا","Lan Tana Loo",4,131),
   SiparahListModel("وَالْمُحْصَنَاتُ","Wal Mohsanat",5,124),
   SiparahListModel("لَا يُحِبُّ اللَّهُ","La Yuhibbullah",6,110),
   SiparahListModel("وَإِذَا سَمِعُوا","Wa Iza Samiu",7,149),
   SiparahListModel("وَلَوْ أَنَّنَا","Wa Lau Annana",8,142),
   SiparahListModel("وَإِذَا سَمِعُوا","	Qalal Malao",9,159),
   SiparahListModel("وَاعْلَمُوا","Wa A'lamu",10,127),
   SiparahListModel("يَعْتَذِرُونَ","Yatazeroon",11,151),
   SiparahListModel("وَمَا مِنْ دَابَّةٍ","Wa Mamin Da'abat",12,170),
   SiparahListModel("	وَمَا أُبَرِّئُ","Wa Ma Ubrioo",13,154),
   SiparahListModel("رُبَمَا","Rubama",14,227),
   SiparahListModel("سُبْحَانَ الَّذِي","Subhanallazi",15,185),
   SiparahListModel("قَالَ أَلَمْ","Qal Alam",16,269),
   SiparahListModel("اقْتَرَبَ","Aqtarabo",17,190),
   SiparahListModel("قَدْ أَفْلَحَ","Qadd Aflaha",18,202),
   SiparahListModel("وَقَالَ الَّذِينَ","Wa Qalallazina",19,339),
   SiparahListModel("أَمَّنْ خَلَقَ","A'man Khalaq",20,171),
   SiparahListModel("اتْلُ مَا أُوحِيَ","Utlu Ma Oohi",21,178),
   SiparahListModel("وَمَنْ يَقْنُتْ","Wa Manyaqnut",22,169),
   SiparahListModel("	وَمَا لِيَ","Wa Mali",23,357),
   SiparahListModel("فَمَنْ أَظْلَمُ","Faman Azlam",24,175),
   SiparahListModel("	إِلَيْهِ يُرَدُّ","Elahe Yuruddo",25,246),
   SiparahListModel("حم","Ha'a Meem",26,195),
   SiparahListModel("قَالَ فَمَا خَطْبُكُمْ","Qala FamaKhatbukum",27,399),
   SiparahListModel("قَدْ سَمِعَ اللَّهُ","Qadd Sami Allah",28,137),
   SiparahListModel("	تَبَارَكَ الَّذِي","Tabarakallazi",29,431),
   SiparahListModel("عَمَّ يَتَسَاءَلُونَ","Amma Yatasa'aloon",30,564 ),
 ];

 static List<Manzil> manzilList =[
   Manzil("Chapter 1"),
   Manzil("Chapter 2"),
   Manzil("Chapter 3"),
   Manzil("Chapter 4"),
   Manzil("Chapter 5"),
   Manzil("Chapter 6"),
   Manzil("Chapter 7"),
 ];
}