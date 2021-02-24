import 'package:flutter/material.dart';

enum EditerMenuItemType {
  /// （默认）单行模式
  single,
  /// 多行模式
  multiline
}

/// 编辑菜单项
class EditerMenuItem extends StatelessWidget {

  /// 标签
  final String label;
  /// 标签宽度
  final double labelWidth;
  /// 内容组件
  final Widget child;
  /// 工具组件
  final Widget toolWidget;
  /// 类型
  final EditerMenuItemType type;
  /// 图标
  final IconData icon;
  /// 高度
  final double height;
  /// 边框
  final Border border;
  /// 显示下方边框
  final bool showBorder;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 点击事件
  final Function onPressed;

  const EditerMenuItem({
    Key key,
    this.label,
    this.labelWidth = 68,
    this.child,
    this.toolWidget,
    this.height = 50,
    this.border,
    this.showBorder = true,
    this.type = EditerMenuItemType.single,
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
          border: border ?? Border(
            bottom: BorderSide(
              color: Color(0xFFDDDDDD),
              width: 0.5,
              style: showBorder ? BorderStyle.solid : BorderStyle.none
            )
          )
        ),
        child: type == EditerMenuItemType.single ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label != null || icon != null ? Expanded(
              flex: 0,
              child: Container(
                width: labelWidth,
                alignment: Alignment.centerLeft,
                height: height,
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
              ),
            ) : null,
            Expanded(
              flex: 1,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: height,
                ),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  left: label != null ? 20 : 0
                ),
                child: child,
              ),
            ),
            toolWidget != null ? Expanded(
              flex: 0,
              child: Container(
                width: height,
                height: height,
                alignment: Alignment.center,
                child: toolWidget,
              ),
            ) : null
          ].where((item) => item != null).toList(),
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                label != null || icon != null ? Expanded(
                  flex: 0,
                  child: Container(
                    width: labelWidth,
                    alignment: Alignment.centerLeft,
                    height: height,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      children: [
                        icon != null ? Icon(icon, size: 24) : null,
                        Text(label, style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                      ].where((item) => item != null).toList(),
                    ),
                  ),
                ) : null,
                toolWidget != null ? Expanded(
                  flex: 0,
                  child: Container(
                    width: height,
                    height: height,
                    alignment: Alignment.center,
                    child: toolWidget,
                  ),
                ) : null
              ].where((item) => item != null).toList(),
            ),
            Expanded(
              flex: 0,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: height,
                ),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  bottom: showBorder ? 15 : 0
                ),
                child: child,
              ),
            )
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}
