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

  static Map<String, String> initLang(Map<String, Map<String, String>> lang) {
    Map<String, String> _map = {};
    lang.keys.toList().forEach((e) {
      lang[e].keys.toList().forEach((key) {
        _map[e + '_' + key] = lang[e][key];
      });
    });
    return _map;
  }
}