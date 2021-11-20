class SurahsListUrduTranslation {
  final List<SurahUrdu> surahs;

  SurahsListUrduTranslation({this.surahs});

  factory SurahsListUrduTranslation.fromJSON(Map<String, dynamic> json) {
    Iterable surahlist = json['data']['surahs'];
    List<SurahUrdu> surahsList = surahlist.map((i) => SurahUrdu.fromJSON(i)).toList();

    return SurahsListUrduTranslation(surahs: surahsList);
  }
}

class SurahUrdu {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<Ayats> ayahs;

  SurahUrdu(
      {this.number,
        this.revelationType,
        this.name,
        this.ayahs,
        this.englishName,
        this.englishNameTranslation});

  factory SurahUrdu.fromJSON(Map<String, dynamic> json) {
    Iterable ayahs = json['ayahs'];
    List<Ayats> ayahsList = ayahs.map((e) => Ayats.fromJSON((e))).toList();

    return SurahUrdu(
        name: json['name'],
        number: json['number'],
        englishName: json['englishName'],
        revelationType: json['revelationType'],
        englishNameTranslation: json['englishNameTranslation'],
        ayahs: ayahsList);
  }
}

class Ayats {
  final String text;
  final int number;
  Ayats({this.text, this.number});

  factory Ayats.fromJSON(Map<String, dynamic> json) {
    return Ayats(
        text: json['text'], number: json['numberInSurah']);
  }
}
