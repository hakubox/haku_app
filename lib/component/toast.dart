import 'package:haku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oktoast/oktoast.dart';

import 'img.dart';

/// 简易弹出框
class Toast {

  /// 成功浮动层
  static ToastFuture success(String text, {
    IconData icon = LineIcons.check,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    EdgeInsetsGeometry margin = const EdgeInsets.all(50.0),
    Duration duration = const Duration(seconds: 2),
    void Function() onClose
  }) {
    return show(
      text: text,
      icon: icon,
      padding: padding,
      margin: margin,
      duration: duration,
      onClose: onClose
    );
  }

  /// 信息浮动层
  static ToastFuture info(String text, {
    IconData icon = LineIcons.exclamation_circle,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    EdgeInsetsGeometry margin = const EdgeInsets.all(50.0),
    Duration duration = const Duration(seconds: 2),
    void Function() onClose
  }) {
    return show(
      text: text,
      icon: icon,
      padding: padding,
      margin: margin,
      duration: duration,
      onClose: onClose
    );
  }

  /// 错误浮动层
  static ToastFuture error(String text, {
    IconData icon = LineIcons.times,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    EdgeInsetsGeometry margin = const EdgeInsets.all(50.0),
    Duration duration = const Duration(seconds: 2),
    void Function() onClose
  }) {
    return show(
      text: text,
      icon: icon,
      padding: padding,
      margin: margin,
      duration: duration,
      onClose: onClose
    );
  }

  /// 文本浮动层
  static ToastFuture show({
    String text,
    IconData icon,
    double iconSize = 40,
    String imgUrl,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    EdgeInsetsGeometry margin = const EdgeInsets.all(50.0),
    Duration duration,
    void Function() onClose
  }) {
    return showToastWidget(
      Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: Color(0xAA000000),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: ClipRect(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon != null ? Icon(icon,
                size: iconSize,
                color: Colors.white,
              ) : null,
              imgUrl != null ? Img(imgUrl,
                width: 32,
                height: 32,
              ) : null,
              text != null ? Container(
                margin: EdgeInsets.only(
                  top: 4
                ),
                child: Text(text, style: TextStyle(
                  color: Colors.white
                ),),
              ) : null,
            ].where((item) => item != null).toList(),
          )
        )
      ),
      dismissOtherToast: true,
      duration: duration,
      onDismiss: onClose
    );
  }

  /// loading浮动层
  static ToastFuture progress({
    double width = 100,
    double height = 100,
    String text = '加载中',
    double value = 0,
    double maxValue = 100,
    Duration duration,
    void Function() onClose,
    void Function(double newValue) onValueChange
  }) {
    var toast = showToastWidget(
      Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        padding: EdgeInsets.only(
          top: 4
        ),
        decoration: BoxDecoration(
          color: Color(0xAA000000),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFFDDDDDD),
                valueColor: AlwaysStoppedAnimation<Color>(currentTheme.primaryColor),
                strokeWidth: 3.0,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 8
              ),
              child: Text(text + '(${value}/${maxValue})', style: TextStyle(
                color: Colors.white
              ),),
            )
          ],
        )
      ),
      dismissOtherToast: true,
      duration: duration,
      onDismiss: onClose
    );
    return toast;
  }

  /// loading浮动层
  static ToastFuture loading({
    double width = 100,
    double height = 100,
    String text = '加载中...',
    Duration duration,
    void Function() onClose
  }) {
    return showToastWidget(
      Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        padding: EdgeInsets.only(
          top: 4
        ),
        decoration: BoxDecoration(
          color: Color(0xAA000000),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFFDDDDDD),
                valueColor: AlwaysStoppedAnimation<Color>(currentTheme.primaryColor),
                strokeWidth: 3.0,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 8
              ),
              child: Text(text, style: TextStyle(
                color: Colors.white
              ),),
            )
          ],
        )
      ),
      dismissOtherToast: true,
      duration: duration,
      onDismiss: onClose
    );
  }

  /// 隐藏单个浮动层
  static void hide(ToastFuture toast) {
    toast.dismiss();
  }

  /// 隐藏所有浮动层
  static void hideAll() {
    dismissAllToast();
  }
}