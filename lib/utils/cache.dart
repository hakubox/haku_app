import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

/// 唯一缓存插件实例
SharedPreferences _preferences;

/// 缓存库
class Cache {

  /// 初始化
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// 获取缓存
  static Set<String> get keys => _preferences?.getKeys();

  /// 判断是否存在
  static bool contains(String key) {
    return _preferences?.containsKey(key);
  }

  /// 获取字符串缓存项
  static String get(String key) {
    return _preferences?.getString(key);
  }

  /// 根据类型获取缓存项
  /// 
  /// 可选类型为 `String` / `bool` / `List<String>` / `int` / `double`
  static T getOfType<T>(String key) {
    if (T == String) {
      return _preferences?.getString(key) as T;
    } else if (T == bool) {
      return _preferences?.getBool(key) as T;
    } else if (T == List) {
      return _preferences?.getStringList(key) as T;
    } else if (T == int) {
      return _preferences?.getInt(key) as T;
    } else if (T == double) {
      return _preferences?.getDouble(key) as T;
    } else {
      return _preferences?.getString(key) as T;
    }
  }

  /// 新增缓存项，默认值类型为 `String`
  /// 
  /// 可选类型为 `String` / `bool` / `List<String>` / `int` / `double`
  static Future<bool> add<T>(String key, T value) {
    if (T == String) {
      return _preferences?.setString(key, value as String);
    } else if (T == bool) {
      return _preferences?.setBool(key, value as bool);
    } else if (T == List) {
      return _preferences?.setStringList(key, (value as List).map((e) {
        if (e is String) {
          return e;
        } else {
          return e.toString();
        }
      }).toList());
    } else if (T == int) {
      return _preferences?.setInt(key, value as int);
    } else if (T == double) {
      return _preferences?.setDouble(key, value as double);
    } else {
      return _preferences?.setString(key, convert.jsonEncode(value));
    }
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