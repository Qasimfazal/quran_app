class SiparahModel {
  final int juzNumber;
  final List<JuzAyahs> juzAyahs;

  SiparahModel({this.juzAyahs, this.juzNumber});

  factory SiparahModel.fromJSON(Map<String, dynamic> json) {
    Iterable juzAyahs = json['data']['ayahs'];
    List<JuzAyahs> juzAyahsList =
    juzAyahs.map((e) => JuzAyahs.fromJSON(e)).toList();

    return SiparahModel(juzAyahs: juzAyahsList, juzNumber: json['data']['number']);
  }
}

class JuzAyahs {
  final String ayahsText;
  final int ayahNumber;
  final String surahName;

  JuzAyahs({this.ayahsText, this.surahName, this.ayahNumber});

  factory JuzAyahs.fromJSON(Map<String, dynamic> json) {
    return JuzAyahs(
        ayahNumber: json['number'],
        ayahsText: json['text'],
        surahName: json['surah']['name']
    );
  }
}
