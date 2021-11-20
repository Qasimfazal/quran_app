class SurahsListEnglishTranslation {
  final List<SurahEnglish> surahs;

  SurahsListEnglishTranslation({this.surahs});

  factory SurahsListEnglishTranslation.fromJSON(Map<String, dynamic> json) {
    Iterable surahlist = json['data']['surahs'];
    List<SurahEnglish> surahsList = surahlist.map((i) => SurahEnglish.fromJSON(i)).toList();

    return SurahsListEnglishTranslation(surahs: surahsList);
  }
}

class SurahEnglish {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<AyatEnglish> ayahs;

  SurahEnglish(
      {this.number,
        this.revelationType,
        this.name,
        this.ayahs,
        this.englishName,
        this.englishNameTranslation});

  factory SurahEnglish.fromJSON(Map<String, dynamic> json) {
    Iterable ayahs = json['ayahs'];
    List<AyatEnglish> ayahsList = ayahs.map((e) => AyatEnglish.fromJSON((e))).toList();

    return SurahEnglish(
        name: json['name'],
        number: json['number'],
        englishName: json['englishName'],
        revelationType: json['revelationType'],
        englishNameTranslation: json['englishNameTranslation'],
        ayahs: ayahsList);
  }
}

class AyatEnglish {
  final String text;
  final int number;
  AyatEnglish({this.text, this.number});

  factory AyatEnglish.fromJSON(Map<String, dynamic> json) {
    return AyatEnglish(
        text: json['text'], number: json['numberInSurah']);
  }
}
