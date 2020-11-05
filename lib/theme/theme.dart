
// 提供五套可选主题色
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/theme/theme_dark.dart';
import 'package:haku_app/theme/theme_light.dart';

/// 模板主题
abstract class TemplateTheme {
  /// 主题名称
  String name;
  /// 基础色调
  Color primaryColor;
  /// 边框色调
  Color borderColor;
  /// 基础主题
  ThemeData baseTheme;
  /// 获取主题
  ThemeData getTheme();

  /// Color转换为MaterialColor
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}

/// App主题配置
class AppTheme {

  /// 明亮主题
  static final TemplateTheme light = LightTheme();
  /// 暗黑主题
  static final TemplateTheme dark = DarkTheme();

  /// 当前主题名称
  static String _currentThemeName = 'light';

  /// 当前主题
  static TemplateTheme get currentTheme => light; //Get.isDarkMode ? dark : light

  /// 定义所有可用主题
  static final Map<String, TemplateTheme> themes = [
    light, 
    dark
  ].asMap().map((key, value) => MapEntry<String, TemplateTheme>(value.name, value));

  /// 切换主题
  changeTheme(TemplateTheme theme) {
    _currentThemeName = theme.name;
    Get.changeTheme(theme.getTheme());
  }
}

/// 当前主题
TemplateTheme get currentTheme => AppTheme.currentTheme;