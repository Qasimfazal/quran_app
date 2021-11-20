import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:quran_app/Core/Apis.dart';
import 'package:quran_app/Model/audioSurah.dart';
import 'package:quran_app/Model/englishTranslation.dart';
import 'package:quran_app/Model/manzil.dart';
import 'package:quran_app/Model/quran.dart';
import 'package:quran_app/Model/sajda.dart';
import 'package:quran_app/Model/siparah.dart';
import 'package:quran_app/Model/surat.dart';
import 'package:quran_app/Model/urduTranslation.dart';
import 'package:quran_app/Utils/Utils.dart';

class Provider extends GetxController{
  SurahsList surahList;
  AudioSurahsList audioSurahList;
  SurahsListUrduTranslation urduTranslation;
  SurahsListEnglishTranslation englishTranslation;
  SiparahModel siparahList;
  SajdaList sajdaList;
  ManzilModel manzilList;
  Quran audioList;
  Location location = new Location();
  LocationData _locationData;



  @override
  Future<void> onInit() async {
    super.onInit();
    _locationData = await location.getLocation();
  }

  getSurahList() async {
    if (Utils.surahLists == null) {
      surahList = await QuranAPI().getSurahList();

      Utils.surahLists = surahList;
      // Utils.urduTranslationList = urduTranslation;
      // Utils.englishTranslationList = englishTranslation;
      update();
    } else {
      surahList = Utils.surahLists;
      // urduTranslation = Utils.urduTranslationList;
      // englishTranslation = Utils.englishTranslationList;
      print(surahList.surahs.length);
      update();

    }
  }

  getAudioSurahList() async {

      audioSurahList = await QuranAPI().getAudioSurahList();
      urduTranslation = await QuranAPI().getTranslationUrdu();
      englishTranslation = await QuranAPI().getTranslationEnglish();
      update();

  }
  getSajdaList() async {
    if (Utils.sajdaList == null) {
      sajdaList = await QuranAPI().getSajda();
      Utils.sajdaList = sajdaList;
      update();
    } else {
      sajdaList = Utils.sajdaList;
      // print(sajdaList.surahs.length);
      update();

    }
  }
  getSiparahList(index) async {

      siparahList = await QuranAPI().getJuzz(index);
      Utils.siparahLists = siparahList;
      update();

  }
  getManzilList(index) async {

    manzilList = await QuranAPI().getManzil(index);
      Utils.manzilLists = manzilList;
      update();

  }
    getAudio() async {
      audioList = await QuranAPI().getAudio();
        update();
    }

}
