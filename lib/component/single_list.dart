
import 'package:haku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 简单单行列表项
class SingleItem extends StatelessWidget {

  /// 标题
  final String title;
  /// 链接地址
  final String url;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 外边距
  final EdgeInsetsGeometry margin;
  /// 点击事件
  final Function onTap;

  const SingleItem({
    Key key,
    @required this.title,
    this.url = '',
    this.padding = const EdgeInsets.only(
      bottom: 8
    ),
    this.margin = const EdgeInsets.only(
      bottom: 8
    ),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: currentTheme.borderColor,
              width: 0.5
            )
          )
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: currentTheme.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(6))
              ),
            ),
            Text(title),
          ],
        )
      ),
      onTap: () {
        url == null ? onTap() : Get.toNamed(url);
      },
    );
  }
}
