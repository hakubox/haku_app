
import 'package:flutter/material.dart';
import 'package:haku_app/theme/theme.dart';

/// 明亮主题
class LightTheme implements TemplateTheme {

  /// 主题名称
  @override
  String name = 'light';

  /// 主色调
  @override
  Color primaryColor = Color(0xFFFF6600);

  /// 边框主色调
  @override
  Color borderColor = Color(0xFF000000);

  /// 反色文字色
  @override
  Color fontColorInverse = Color(0xFFFFFFFF);

  /// 基础主题
  @override
  ThemeData baseTheme = ThemeData.light();

  /// 文本框文本样式
  @override
  TextStyle inputTextStyle = TextStyle(
    // fontFamily: 'Poppins',
    fontWeight: FontWeight.w400
  );

  @override
  ThemeData getTheme() {

    // 配套文字主题
    TextTheme _textTheme = baseTheme.textTheme.copyWith();
    TextTheme _primaryTextTheme = baseTheme.textTheme.copyWith();
    TextTheme _accentTextTheme = baseTheme.accentTextTheme.copyWith();
    
    ThemeData _theme = ThemeData(
      // 亮度
      brightness: Brightness.light,
      // 主色调
      primarySwatch: TemplateTheme.createMaterialColor(primaryColor),
      // 按钮颜色
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      // 小部件的前景色（旋钮，文本，过度滚动边缘效果等）。
      accentColor: const Color(0xFF13B9FD),
      // 画布颜色
      canvasColor: const Color(0xFFEEEEEE),
      // Scaffold背景色
      scaffoldBackgroundColor: const Color(0xFFEEEEEE),
      // 背景色
      backgroundColor: const Color(0xFFEEEEEE),
      // 错误色
      errorColor: const Color(0xFFB00020),
      // AppBar主题
      appBarTheme: AppBarTheme(
        color: const Color(0xFFFF6600),
        iconTheme: IconThemeData(color: Colors.red),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            color: Colors.red,
            fontSize: 20.0,
          ),
        ),
      ),
      // 图标主题
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
      // 用于自定义对话框形状的主题。
      dialogTheme: DialogTheme(
        backgroundColor: Colors.red,
        titleTextStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.black87,
        ),
      ),
      // 按钮主题
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        textTheme: ButtonTextTheme.normal,
        buttonColor: primaryColor,
      ),
      // 文字主题
      textTheme: _textTheme,
      // 关键文本主题
      primaryTextTheme: _primaryTextTheme,
      // 重音文本主题？
      accentTextTheme: _accentTextTheme,
      // 视觉密度
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return _theme;
  }
}
