import 'package:dio/dio.dart';
import 'package:quran_app/Model/audioSurah.dart';
import 'package:quran_app/Model/englishTranslation.dart';
import 'package:quran_app/Model/manzil.dart';
import 'package:quran_app/Model/quran.dart';
import 'package:quran_app/Model/sajda.dart';
import 'package:quran_app/Model/siparah.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quran_app/Model/surat.dart';
import 'package:quran_app/Model/urduTranslation.dart';

class QuranAPI {
  Future<SurahsList> getSurahList() async {
      String url = "https://api.alquran.cloud/v1/quran/quran-uthmani";
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        return SurahsList.fromJSON(response.data);
      } else {
        print("Failed to load");
        throw Exception("Failed  to Load Post");
      }

  }
  Future<SurahsListUrduTranslation> getTranslationUrdu() async {
      String url = "http://api.alquran.cloud/v1/quran/ur.maududi";
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        return SurahsListUrduTranslation.fromJSON(response.data);
      } else {
        print("Failed to load");
        throw Exception("Failed  to Load Post");
      }

  }
  Future<SurahsListEnglishTranslation> getTranslationEnglish() async {
      String url = "http://api.alquran.cloud/v1/quran/en.asad";
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        return SurahsListEnglishTranslation.fromJSON(response.data);
      } else {
        print("Failed to load");
        throw Exception("Failed  to Load Post");
      }

  }

  Future<AudioSurahsList> getAudioSurahList() async {
      String url = "https://api.alquran.cloud/v1/quran/ar.alafasy";
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        return AudioSurahsList.fromJSON(response.data);
      } else {
        print("Failed to load");
        throw Exception("Failed  to Load Post");
      }

  }


  Future<SajdaList> getSajda() async {
    String url = "https://api.alquran.cloud/v1/sajda/quran-uthmani";
    final response = await Dio().get(url);

    if (response.statusCode == 200) {
      return SajdaList.fromJSON(response.data);
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  Future<SiparahModel>  getJuzz(int index) async {
    String url = "https://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await Dio().get(url);

    if (response.statusCode == 200) {
      return SiparahModel.fromJSON(response.data);
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }
  Future<ManzilModel>  getManzil(int index) async {
    String url = "https://api.alquran.cloud/v1/manzil/$index/quran-uthmani";
    final response = await Dio().get(url);

    if (response.statusCode == 200) {
      return ManzilModel.fromJSON(response.data);
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }
  getAudio() async {
    final response = await http.post(
        Uri.parse('https://gad25.xyz/Quran/QuranShared.php/?reader_id=1'),
        body: {'reader_id': '1'});
    if (response.statusCode == 200) {
      return Quran.fromJson(jsonDecode(response.body));
    }
  }

  Future getNamaz(var lat,lng)async{
    String url = "https://api.aladhan.com/v1/timings?latitude=$lat&longitude=$lng";
    final response = await Dio().get(url);
    if (response.statusCode == 200) {
      return response;
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
    return response;
  }
}
