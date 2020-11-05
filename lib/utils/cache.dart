import 'package:shared_preferences/shared_preferences.dart';   

SharedPreferences _preferences;

/// 缓存库
class Cache {

  /// 初始化
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// 获取缓存
  static String get(String key) {
    return _preferences?.get(key) ?? '';
  }

  /// 新增缓存
  static Future<bool> add(String key, String value) {
    return _preferences?.setString(key, value);
  }

  /// 删除指定键
  static Future<bool> remove(String key) {
    return _preferences?.remove(key);
  }

  /// 清空缓存
  static Future<bool> clear(String key) {
    return _preferences.clear();
  }
}