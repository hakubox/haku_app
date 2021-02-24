import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  /// 子组件，会替代掉文本及图标
  final Widget child;
  /// 背景色
  final Color backgroundColor;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 按钮图标
  final Icon icon;
  /// 按钮文本
  final String text;
  /// 按钮文本样式
  final TextStyle textStyle;
  /// 按钮文本颜色
  final Color fontColor;
  /// 按钮文本样式
  final Color fontStyle;
  /// 高度
  final double height;
  /// 按钮z轴高度（控制阴影）
  final double elevation;
  /// 最小宽度
  final double minWidth;
  /// 外边距
  final EdgeInsetsGeometry margin;
  /// 圆角
  final BorderRadiusGeometry borderRadius;
  /// 是否禁用
  final bool disabled;

  const Button({
    Key key,
    this.icon,
    this.child,
    this.elevation = 0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0),
    this.margin = EdgeInsets.zero,
    this.text,
    this.textStyle,
    this.height = 46,
    this.fontColor = Colors.white,
    this.fontStyle,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.minWidth,
    this.onPressed,
    this.disabled = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      shadowColor: Colors.transparent,
      child: SizedBox(
        height: height,
        child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: padding,
          disabledTextColor: Colors.white,
          disabledColor: (backgroundColor ?? Get.theme.primaryColor).withAlpha(180),
          onPressed: disabled ? null : onPressed,
          child: child ?? Wrap(
            spacing: 4,
            children: [
              icon != null ? icon : null,
              Text(text, style: fontStyle ?? TextStyle(
                color: fontColor
              ))
            ].where((item) => item != null).toList()
          ),
          elevation: elevation,
          textColor: Colors.white,
          color: backgroundColor ?? Get.theme.primaryColor,
          minWidth: minWidth,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}
