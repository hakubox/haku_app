import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

/// 菜单项
class MenuItem extends StatelessWidget {

  /// 标签
  final String label;
  /// 值
  final String value;
  /// 值组件
  final Widget valueWidget;
  /// 图标
  final IconData icon;
  /// 高度
  final double height;
  /// 显示右侧箭头
  final bool showAngle;
  /// 显示下方边框
  final bool showBorder;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 点击事件
  final Function onPressed;

  const MenuItem({
    Key key,
    this.label,
    this.value,
    this.valueWidget,
    this.height = 50,
    this.showAngle = true,
    this.showBorder = true,
    this.padding = const EdgeInsets.only(left: 15, right: 10),
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        constraints: BoxConstraints(
          minHeight: label != null ? height : 0,
        ),
        alignment: Alignment.centerLeft,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFDDDDDD),
              width: 0.5,
              style: showBorder ? BorderStyle.solid : BorderStyle.none
            )
          )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label != null || icon != null ? Expanded(
              flex: 0,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 6,
                children: [
                  icon != null ? Icon(icon, size: 24) : null,
                  Text(label, style: TextStyle(
                      fontSize: 16
                    ),
                  )
                ].where((item) => item != null).toList(),
              ),
            ) : null,
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(
                  left: label != null ? 10 : 0
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    valueWidget == null ? value != null ? Expanded(
                      flex: 0,
                      child: Text(value, style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Color(0xFF888888)
                      ),
                    )) : null : Expanded(
                      flex: 1,
                      child: Container(
                        alignment: label == null ? Alignment.centerLeft : Alignment.centerRight,
                        child: valueWidget,
                      )
                    ),
                    showAngle ? Expanded(
                      flex: 0,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 4
                        ),
                        child: Icon(
                          LineIcons.angle_right,
                          color: Color(0xFFBBBBBB),
                          size: 18,
                        ),
                      ),
                    ) : null
                  ].where((item) => item != null).toList(),
                ),
              ),
            ),
          ].where((item) => item != null).toList(),
        ),
      ),
      onTap: onPressed,
    );
  }
}
