import 'package:haku_app/utils/tool.dart';

import 'en_us.dart';
import 'zh_cn.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = Locales.langs;
}

class Locales {
  static Map<String, Map<String, String>> langs = {
    'zh_CN': initLang(zh_CN),
    'en_US': initLang(en_US)
  };

  static Map<String, String> initLang(Map<String, dynamic> lang) {
    Map<String, String> _map = {};
    recursiveMap(lang, '', (key, data, code) {
      if (data[key].runtimeType.toString() == 'String') {
        _map[code] = data[key];
      }
    });
    return _map;
  }
}