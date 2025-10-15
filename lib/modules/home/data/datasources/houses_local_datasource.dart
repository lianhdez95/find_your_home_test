import 'dart:convert';

import 'package:find_your_home_test/modules/home/data/models/house_preview_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HousesLocalDataSource {
  Future<void> cacheHouses(List<HousePreviewModel> items);
  Future<List<HousePreviewModel>> getCachedHouses();
  Future<DateTime?> getLastUpdated();
}

class HousesLocalDataSourceImpl implements HousesLocalDataSource {
  static const _kCacheKey = 'houses_cache_v1';
  static const _kCacheTimeKey = 'houses_cache_time_v1';

  final SharedPreferences prefs;
  HousesLocalDataSourceImpl(this.prefs);

  @override
  Future<void> cacheHouses(List<HousePreviewModel> items) async {
    final jsonList = items.map((e) => e.toJson()).toList();
    await prefs.setString(_kCacheKey, jsonEncode(jsonList));
    await prefs.setString(_kCacheTimeKey, DateTime.now().toIso8601String());
  }

  @override
  Future<List<HousePreviewModel>> getCachedHouses() async {
    final raw = prefs.getString(_kCacheKey);
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .whereType<Map<String, dynamic>>()
            .map((e) => HousePreviewModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  @override
  Future<DateTime?> getLastUpdated() async {
    final t = prefs.getString(_kCacheTimeKey);
    if (t == null) return null;
    try {
      return DateTime.parse(t);
    } catch (_) {
      return null;
    }
  }
}
