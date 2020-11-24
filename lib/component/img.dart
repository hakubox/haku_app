import 'package:flutter/material.dart';

/// 图片
class Img extends StatelessWidget {
  /// 本地路径或网络路径
  final String src;
  /// 无图片地址
  final String blankSrc;
  /// 点击事件
  final Function onClick;
  /// 填充方式
  final BoxFit fit;
  /// 宽度
  final double width;
  /// 高度
  final double height;
  /// 放大比例（默认为1.0）
  final double scale;
  /// 边框
  final BorderSide border;
  /// 背景色
  final Color backgroundColor;
  /// 圆角
  final BorderRadiusGeometry borderRadius;
  /// 外边距
  final EdgeInsetsGeometry margin;

  const Img(this.src, {
    Key key,
    this.blankSrc = 'assets/img/no-image.jpg',
    this.fit: BoxFit.none,
    this.width,
    this.height,
    this.onClick,
    this.scale = 1,
    this.border = BorderSide.none,
    this.backgroundColor,
    this.borderRadius = BorderRadius.zero,
    this.margin = EdgeInsets.zero
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image _img;
    if (src == null || src.isEmpty) {
      _img = Image.asset(
        blankSrc,
        width: width,
        height: height,
        scale: scale,
        fit: fit
      );
    } else if (src.startsWith('http')) {
      _img = Image.network(
        src,
        width: width,
        height: height,
        scale: scale,
        fit: fit
      );
    } else {
      _img = Image.asset(
        src,
        width: width,
        height: height,
        scale: scale,
        fit: fit
      );
    }

    return Card(
      child: _img,
      color: backgroundColor,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: border
      ),
      clipBehavior: Clip.antiAlias,
      margin: margin,
    );
  }
}
