import 'package:haku_app/component/index.dart';
import 'package:flutter/material.dart';
import 'package:haku_app/theme/theme.dart';

/// 单选框项
class RadioItem {
  /// 标签
  final String label;
  /// 值
  final dynamic value;
  /// 是否禁用
  final bool disabled;
  /// 是否显示
  final bool visible;

  const RadioItem({
    this.label,
    @required this.value,
    this.disabled = false,
    this.visible = true
  });
}

/// 单选框
class RadioBox extends StatefulWidget {

  /// 组名
  final String group;
  /// 值
  final dynamic value;
  /// 绑定数据
  final List<RadioItem> data;
  /// 值改变事件
  final ValueChanged<dynamic> onChanged;
  /// 标签文本
  final String labelText;
  /// 标签样式
  final TextStyle labelStyle;
  /// 标签宽度
  final double labelWidth;
  /// 单行高度
  final double lineHeight;
  /// 内边距
  final EdgeInsetsGeometry itemPadding;
  /// 间隙宽度
  final double spacing;
  /// 背景色
  final Color backgroundColor;
  /// 是否为只读
  final bool readonly;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 外边距
  final EdgeInsetsGeometry margin;
  /// 边框类型
  final TextBoxBorderType borderType;
  /// 边框
  final BoxBorder border;
  /// 边框样式
  final BorderSide borderSide;
  /// 边框圆角
  final BorderRadius borderRadius;

  const RadioBox({
    Key key,
    this.group,
    @required this.value,
    this.labelText,
    this.labelStyle,
    this.lineHeight = 40,
    this.labelWidth = 80,
    this.spacing = 0,
    this.itemPadding = const EdgeInsets.only( right: 10 ),
    @required this.data,
    @required this.onChanged, 
    this.backgroundColor = Colors.transparent,
    this.readonly = false, 
    this.borderType = customTextBorderType, 
    this.border, 
    this.borderSide, 
    this.borderRadius, 
    this.padding = EdgeInsets.zero, 
    this.margin = EdgeInsets.zero
  }) : super(key: key);
 
  @override
  RadioBoxState createState() => RadioBoxState();
}

class RadioBoxState extends State<RadioBox> with WidgetsBindingObserver {

  /// 文本框焦点
  List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    if (widget.data.length > 0) {
      _focusNodes = widget.data.map((item) => FocusNode(
        onKey: (node, event) {
          return !item.disabled;
        }
      )).toList();
      _focusNodes.forEach((item) {
        item.addListener(() {
        });
      });
    }
  }

  TextStyle getTextStyle(RadioItem item, int index) {
    Color _color = widget.labelStyle != null ? widget.labelStyle.color : currentTheme.inputTextStyle.color;
    if (item.disabled) {
      _color = Color(0xFFCCCCCC);
    } else if (_focusNodes[index].hasFocus) {
      _color = currentTheme.primaryColor;
    }
    return widget.labelStyle != null ? widget.labelStyle.copyWith(
      color: _color
    ) : currentTheme.inputTextStyle.copyWith(
      color: _color
    );
  }

  /// 获取边框
  BoxBorder getBorder() {
    switch(widget.borderType) {
      case TextBoxBorderType.custom: 
        return widget.border ?? Border.all(
          width: 0,
          style: BorderStyle.none
        );
      case TextBoxBorderType.outline:
        return Border.fromBorderSide(getBorderSide());
      case TextBoxBorderType.underline:
        return Border(
          bottom: getBorderSide()
        );
      default:
        return Border();
    }
  }

  /// 获取边框样式
  BorderSide getBorderSide() {
    Color _color = widget.borderSide != null && widget.borderSide.style != BorderStyle.none ? widget.borderSide.color : currentTheme.borderColor;
    if (widget.readonly) {
      _color = Color(0xFFCCCCCC);
    } else if (_focusNodes.indexWhere((item) => item.hasFocus) >= 0) {
      _color = currentTheme.primaryColor;
    }
    return BorderSide(
      width: widget.borderSide != null && widget.borderSide.style != BorderStyle.none ? widget.borderSide.width : 0.5,
      style: BorderStyle.solid,
      color: _color
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: widget.margin,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: (widget.borderType == TextBoxBorderType.outline || widget.borderType == TextBoxBorderType.custom && widget.border == null || widget.border != null && widget.border.isUniform) ? widget.borderRadius : null,
        border: getBorder()
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          widget.labelText != null ? Expanded(
            flex: 0,
            child: Container(
              width: widget.labelWidth,
              alignment: Alignment.centerLeft,
              height: widget.lineHeight,
              margin: EdgeInsets.only(right: 10),
              child: Text(widget.labelText, style: widget.labelStyle),
            ),
          ) : Expanded(
            flex: 0,
            child: SizedBox(),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(
              ),
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: widget.spacing,
                children: widget.data.where((item) => item.visible).toList().asMap().map((index, item) => MapEntry(index, InkWell(
                  child: Container(
                    padding: widget.itemPadding,
                    height: widget.lineHeight,
                    child: Theme(
                      data: ThemeData(
                        disabledColor: item.value == widget.value ? currentTheme.primaryColor : currentTheme.baseTheme.unselectedWidgetColor,
                        unselectedWidgetColor: item.disabled ? currentTheme.disabledTextColor : currentTheme.baseTheme.unselectedWidgetColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                              activeColor: currentTheme.primaryColor,
                              focusColor: currentTheme.primaryColor,
                              hoverColor: currentTheme.primaryColor,
                              autofocus: false,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              focusNode: _focusNodes[index],
                              value: item.value,
                              groupValue: widget.value,
                              // onChanged: () {

                              // },
                            ),
                            Text(item.label ?? item.value, 
                              style: getTextStyle(item, index).copyWith(
                                height: 1.4
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      if (item.disabled == false) {
                        if (widget.onChanged != null) widget.onChanged(item.value);
                      }
                    }
                  )
                )).values.toList(),
              )
            ),
          ),
        ],
      ),
    );
  }
}
