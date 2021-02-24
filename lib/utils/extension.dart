import 'package:flutter/material.dart';

/// 小部件扩展方法
extension WidgetExtension on Widget {
  /// 是否显示
  visible(dynamic visible) {
    if (visible is bool) {
      return visible ? this : SizedBox();
    } else {
      return visible != null ? this : SizedBox();
    }
  }
}

/// 字符串扩展方法
extension StringExtension on String{
  get firstLetterToUpperCase {
    if (this != null)
      return this[0].toUpperCase() + this.substring(1);
    else
      return null;
  }
}