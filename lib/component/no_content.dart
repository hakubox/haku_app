import 'package:flutter/material.dart';
import 'package:haku_app/utils/extension.dart';
import 'img.dart';

/// 无内容
class NoContent extends StatelessWidget {

  /// 无数据文字
  final String text;
  /// 文字颜色
  final Color textColor;
  /// 无数据图片
  final String img;
  /// 背景色
  final Color backgroundColor;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 外边距
  final EdgeInsetsGeometry margin;

  const NoContent({
    Key key, 
    this.text = '暂无数据',
    this.textColor = const Color(0xFFCCCCCC),
    this.img = 'default-page/no-content.png',
    this.backgroundColor = Colors.transparent,
    this.padding = EdgeInsets.zero,
    this.margin = const EdgeInsets.symmetric( vertical: 30 )
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        color: backgroundColor,
        margin: margin,
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Img(img, 
              width: 260,
              margin: EdgeInsets.only(
                bottom: 30,
              )
            ).visible(img != null && img.isNotEmpty),
            Text(text, style: TextStyle(
              fontSize: 16,
              color: textColor
            ),),
          ],
        ),
      ),
    );
  }
}