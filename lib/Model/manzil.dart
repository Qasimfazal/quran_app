  class ManzilModel {
  final int juzNumber;
  final List<ManzilAyahs> manzilAyahs;

  ManzilModel({this.manzilAyahs, this.juzNumber});

  factory ManzilModel.fromJSON(Map<String, dynamic> json) {
    Iterable manzilAyahs = json['data']['ayahs']; 
    List<ManzilAyahs> manzilAyahsList =
    manzilAyahs.map((e) => ManzilAyahs.fromJSON(e)).toList();

    return ManzilModel(manzilAyahs: manzilAyahsList, juzNumber: json['data']['number']);
  }
}

class ManzilAyahs {
  final String ayahsText;
  final int ayahNumber;
  final String surahName;

  ManzilAyahs({this.ayahsText, this.surahName, this.ayahNumber});

  factory ManzilAyahs.fromJSON(Map<String, dynamic> json) {
    return ManzilAyahs(
        ayahNumber: json['number'],
        ayahsText: json['text'],
        surahName: json['surah']['name']
    );
  }
}
