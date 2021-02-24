import 'package:flutter/material.dart';

import 'index.dart';

/// 消息菜单项
class MessageMenuItem extends StatelessWidget {

  /// 标题
  final String title;
  /// 副标题
  final String subTitle;
  /// 尾部文本
  final String trailing;
  /// 是否显示小红点
  final bool redPoint;
  /// 图片路径
  final Widget leading;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 点击事件
  final Function onTap;

  const MessageMenuItem({
    Key key,
    @required this.title,
    this.subTitle,
    this.redPoint = false,
    this.leading,
    this.trailing,
    this.padding = const EdgeInsets.symmetric(
      vertical: 2,
      horizontal: 16
    ),
    this.onTap, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      leading: Stack(
        overflow: Overflow.visible,
        children: [
          leading ?? SizedBox(),
          Positioned(
            right: 2,
            top: 2,
            child: redPoint ? Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle
              ),
            ) : SizedBox(),
          )
        ],
      ),
      contentPadding: padding,
      title: Text(title, style: TextStyle(
        fontSize: 18,
        height: 1.4
      ),),
      subtitle: subTitle != null ? Text(subTitle, style: TextStyle(
        color: Color(0xFF999999),
        fontSize: 14
      ),) : SizedBox(),
      trailing: Container(
        width: 80,
        height: 40,
        alignment: Alignment.topRight,
        child: trailing != null ? Text(trailing, style: TextStyle(
          color: Color(0xFF888888),
          fontSize: 14
        ),) : SizedBox(),
      ),
      onTap: onTap,
    );
  }
}
