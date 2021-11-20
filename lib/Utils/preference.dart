import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences shared;

  bool get darkTheme => shared.getBool("darkTheme") ?? false;
  bool get audioList => shared.getBool("list") ?? false;
  int get index => shared.getInt("index") ?? 1;
  int get bookmark => shared.getInt("bookmark") ?? 0;
  String get audioduration => shared.getString("audioduration") ?? "";
  int get audioIndex => shared.getInt("audioindex") ?? -1;
  int get playerIndex => shared.getInt("playerIndex") ?? 0;

  Future setDuration(value) async {
    await shared.setString("audioduration", value);
  }
  Future setTheme(value) async {
    await shared.setBool("darkTheme", value);
  }
  Future setList(value) async {
    await shared.setBool("list", value);
  }

  Future setIndex(value) async {
    await shared.setInt("index", value);
  }
  Future setBookmark(value) async {
    await shared.setInt("bookmark", value);
  }
  Future setAudioIndex(value) async {
    await shared.setInt("audioindex", value);
  }
  Future setPlayerIndex(value) async {
    await shared.setInt("playerIndex", value);
  }

  static Future<Preferences> init() async{
    shared = await SharedPreferences.getInstance();
  }


}
