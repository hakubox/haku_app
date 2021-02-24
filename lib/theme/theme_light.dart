
import 'package:flutter/material.dart';
import 'theme.dart';

/// 明亮主题
class LightTheme implements TemplateTheme {

  /// 主题名称
  @override
  String name = 'light';

  /// 主色调
  @override
  Color primaryColor = Color(0xFF4577BE);

  /// 成功色调
  @override
  Color successColor = Color(0xFF07C160);

  /// 警告色调
  @override
  Color dangerColor = Color(0xFFFF4D4F);

  /// 边框主色调
  @override
  Color borderColor = Color(0xFFEBEBEB);

  /// 文字色
  @override
  Color fontColor = Color(0xFF303030);

  /// 反色文字色
  @override
  Color fontColorInverse = Color(0xFFFFFFFF);

  /// 提示文字色
  @override
  Color hintTextColor = Color(0xFFACACAC);

  /// 禁用文字色
  @override
  Color disabledTextColor = Color(0xFFCCCCCC);

  /// 基础主题
  @override
  ThemeData baseTheme = ThemeData.light();
  
  /// 标题文本样式
  @override
  TextStyle headTextStyle = TextStyle(
    fontSize: 16
  );
  
  /// 普通文本样式
  @override
  TextStyle normalTextStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF303030),
    fontWeight: FontWeight.normal
  );
  
  /// 次要文本样式
  @override
  TextStyle secondaryTextStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFFB0B1B6),
    fontWeight: FontWeight.normal
  );

  /// 文本框标签样式
  @override
  TextStyle inputLabelStyle = TextStyle(
    // fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    color: Color(0xFF333333),
    fontSize: 14
  );

  /// 文本框文本样式
  @override
  TextStyle inputTextStyle = TextStyle(
    // fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    color: Color(0xFF888888),
    fontSize: 14,
    height: 1.5
  );
    
  // 下划虚线
  // decoration: TextDecoration.underline,
  // decorationStyle: TextDecorationStyle.dashed,
  // decorationThickness: 1

  @override
  ThemeData getTheme() {

    // 配套文字主题
    TextTheme _textTheme = baseTheme.textTheme.copyWith();
    TextTheme _primaryTextTheme = baseTheme.textTheme.copyWith();
    TextTheme _accentTextTheme = baseTheme.accentTextTheme.copyWith();
    
    ThemeData _theme = ThemeData(
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.white,
        actionTextColor: primaryColor,
        disabledActionTextColor: disabledTextColor
      ),
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 10
      ),
      // 亮度
      brightness: Brightness.light,
      // 主色调
      primarySwatch: TemplateTheme.createMaterialColor(primaryColor),
      // 按钮颜色
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      // 小部件的前景色（旋钮，文本，过度滚动边缘效果等）。
      accentColor: primaryColor,
      // 画布颜色
      canvasColor: const Color(0xFFEEEEEE),
      // Scaffold背景色
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      // 背景色
      backgroundColor: const Color(0xFFFFFFFF),
      // 错误色
      errorColor: const Color(0xFFB00020),

      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: hintTextColor
        ),
        prefixStyle: TextStyle(
          fontSize: 20
        )
      ),
      // AppBar主题
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        // 背景色
        color: primaryColor,
        // 悬浮距离
        elevation: 0.0,
        // 图标主题
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        // 动作图标主题
        actionsIconTheme: IconThemeData(

        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 0.15
          ),
          subtitle1: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      // tabbar 颜色
      bottomAppBarColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 4
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: Colors.white,
        elevation: 0
      ),
      // 图标主题
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
      // 用于自定义对话框形状的主题。
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      // 按钮主题
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        textTheme: ButtonTextTheme.primary,
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
