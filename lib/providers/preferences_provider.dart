import 'package:shared_preferences/shared_preferences.dart';

class PreferenceProvider {
  PreferenceProvider() {
    _init();
  }

  PreferenceProvider._internal();

  late SharedPreferencesWithCache _prefs;

  var hasLoadedProfile = false;

  Future<void> _init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
  }

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  bool hasData(String key) => _prefs.containsKey(key);

  static Future<PreferenceProvider> create() async {
    var provider = PreferenceProvider._internal();

    await provider._init();

    return provider;
  }
}
