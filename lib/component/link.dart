
import 'package:haku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'img.dart';

/// 链接
class Link extends StatelessWidget {

  /// 图标地址
  final String iconPath;
  /// 链接文字
  final String text;
  /// 链接文字（和点击事件冲突）
  final String url;
  /// 点击事件
  final Function onTap;

  const Link({
    Key key,
    this.onTap,
    this.iconPath,
    this.text,
    this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          iconPath != null ? Img(iconPath, width: 12, margin: EdgeInsets.only(right: 4)) : SizedBox(),
          Text(text, style: TextStyle(fontSize: 12, color: currentTheme.primaryColor))
        ],
      ),
      onTap: () {
        url == null ? onTap() : Get.toNamed(url);
      },
    );
  }
}
