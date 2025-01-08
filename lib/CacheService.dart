import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static final CacheService _instance = CacheService._internal();
  static CacheService get instance => _instance;

  CacheService._internal();

  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();

    // Preload frequently used data
    await _preloadData();
  }

  Future<void> _preloadData() async {
    // Example: Preload API data or configurations
    print("Preloading app resources...");
    // Fetch API data or load assets here and store in memory or cache
  }

  Future<void> setCache(String key, dynamic value) async {
    if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    }
  }

  dynamic getCache(String key) {
    return _prefs.get(key);
  }

  Future<void> clearCache(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clearAllCache() async {
    await _prefs.clear();
  }
}
