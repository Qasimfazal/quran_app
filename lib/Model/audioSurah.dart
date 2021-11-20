class AudioSurahsList {
  final List<Surahs> surahs;

  AudioSurahsList({this.surahs});

  factory AudioSurahsList.fromJSON(Map<String, dynamic> json) {
    Iterable Surahslist = json['data']['surahs'];
    List<Surahs> SurahsList = Surahslist.map((i) => Surahs.fromJSON(i)).toList();

    return AudioSurahsList(surahs: SurahsList);
  }
}

class Surahs {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<AudioAyat> ayahs;

  Surahs(
      {this.number,
        this.revelationType,
        this.name,
        this.ayahs,
        this.englishName,
        this.englishNameTranslation});

  factory Surahs.fromJSON(Map<String, dynamic> json) {
    Iterable ayahs = json['ayahs'];
    List<AudioAyat> ayahsList = ayahs.map((e) => AudioAyat.fromJSON((e))).toList();

    return Surahs(
        name: json['name'],
        number: json['number'],
        englishName: json['englishName'],
        revelationType: json['revelationType'],
        englishNameTranslation: json['englishNameTranslation'],
        ayahs: ayahsList,);
  }
}

class AudioAyat {
  final int id;
  final String text;
  final String audio;
  final int number;
   bool isPlay;

  AudioAyat({this.id,this.text, this.number,this.audio,this.isPlay});

  factory AudioAyat.fromJSON(Map<String, dynamic> json) {
    return AudioAyat(
       id: json['number'], text: json['text'], number: json['numberInSurah'],audio: json['audio'],isPlay: false);
  }
}
