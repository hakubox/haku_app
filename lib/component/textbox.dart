import 'package:haku_app/component/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haku_app/theme/theme.dart';

/// 通用文本框
class TextBox extends StatefulWidget {

  /// 文本框宽度
  final double width;
  /// 标签文本
  final String labelText;
  /// 标签文本样式
  final TextStyle labelStyle;
  /// 标签宽度
  final double labelWidth;
  /// 背景色
  final Color backgroundColor;
  /// 是否为只读
  final bool readonly;
  /// 内容文本样式
  final TextStyle textStyle;
  /// 边框类型
  final TextBoxBorderType borderType;
  /// 点击事件
  final Function onTap;
  /// 值改变事件
  final ValueChanged<String> onChanged;
  /// 编辑完成事件
  final void Function(String text) onEditingComplete;
  /// 编辑提交事件
  final void Function(String text) onFieldSubmitted;
  /// 获取焦点事件
  final void Function(bool isFocus) onFocus;
  /// 是否隐藏输入
  final bool obscureText;
  /// 最大高度
  final double maxHeight;
  /// 文本框输入类型
  final TextInputType inputType;
  final Function(String) onSaved;
  final bool autocorrect;
  final FormFieldValidator<String> validator;
  final String errorText;
  final String initialValue;
  /// 文本编辑控制器
  final TextEditingController controller;
  /// 最大行数
  final int maxLines;
  final List<TextInputFormatter> inputFormatters;
  /// 提示文本
  final String hintText;
  /// 提示文本颜色
  final Color hintTextColor;
  /// 键盘右下角行为
  final TextInputAction inputAction;
  /// 前缀组件
  final Widget prefix;
  /// 后缀组件
  final List<Widget> suffix;
  /// 前缀图标
  final IconData prefixIcon;
  /// 前缀图标颜色
  final Color prefixIconColor;
  /// 前缀图标大小
  final double prefixIconSize;
  /// 允许清空
  final Function onClear;
  /// 边框
  final BoxBorder border;
  /// 边框样式
  final BorderSide borderSide;
  /// 边框圆角
  final BorderRadius borderRadius;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 外边距
  final EdgeInsetsGeometry margin;
  /// 文本框内容内边距
  final EdgeInsetsGeometry contentPadding;
  /// 自动获取焦点
  final bool autofocus;
  /// 最大长度
  final int maxLength;
  /// 允许清空
  final bool canClear;
  /// 焦点控制器
  final FocusNode focusNode;

  const TextBox({
    Key key,
    this.width,
    this.labelText,
    this.labelStyle = const TextStyle(),
    this.labelWidth = 80,
    this.backgroundColor = Colors.transparent,
    this.textStyle,
    this.readonly = false,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onFocus,
    this.inputType = TextInputType.text,
    this.onSaved,
    this.autocorrect = false,
    this.obscureText = false,
    this.maxHeight = double.infinity,
    this.validator,
    this.errorText,
    this.initialValue,
    this.controller,
    this.maxLines = 1,
    this.inputFormatters,
    this.hintText,
    this.hintTextColor,
    this.inputAction = TextInputAction.done,
    this.prefix,
    this.suffix = const [],
    this.prefixIcon,
    this.prefixIconColor = const Color(0xFF888888),
    this.prefixIconSize = 24.0,
    this.onClear,
    this.border,
    this.borderSide = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
    this.borderType = customTextBorderType,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.contentPadding = const EdgeInsets.only(bottom: 10),
    this.autofocus = false,
    this.maxLength,
    this.canClear = true,
    this.focusNode
  }) : super(key: key);
 
  @override
  TextBoxState createState() => TextBoxState();
}

class TextBoxState extends State<TextBox> with WidgetsBindingObserver {

  /// 文本框焦点
  FocusNode _focusNode;

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null && widget.initialValue == null) {
      _controller = TextEditingController();
    } else if (widget.initialValue == null) {
      _controller = widget.controller;
    } else {
    }
    _focusNode = FocusNode(
      onKey: (node, event) {
        if (!_focusNode.hasFocus) {
          FocusScope.of(Get.context).requestFocus(FocusNode());
        }
        return true;
      }
    );
    _focusNode.addListener(() {
      if (widget.onFocus != null) widget.onFocus(_focusNode.hasFocus);
      if (mounted) setState(() {});
    });
  }

  /// 获取边框
  BoxBorder getBorder() {
    switch(widget.borderType) {
      case TextBoxBorderType.custom: 
        return widget.border;
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
    return BorderSide(
      width: widget.borderSide == null ? 0.5 : widget.borderSide.style != BorderStyle.none ? widget.borderSide.width : 0,
      style: widget.borderSide != null && widget.borderSide.style == BorderStyle.none ? BorderStyle.none : BorderStyle.solid,
      color: getColor()
    );
  }

  Color getColor([Color defaultColor]) {
    Color _color = defaultColor ?? (widget.borderSide.style != BorderStyle.none ? widget.borderSide.color : currentTheme.borderColor);
    if (widget.readonly) {
      _color = Color(0xFFCCCCCC);
    } if (widget.errorText != null) {
      _color = Colors.red;
    } else if (_focusNode.hasFocus) {
      _color = currentTheme.primaryColor;
    }
    return _color;
  }

  /// 是否有错误
  get hasError => widget.errorText != null && widget.errorText.length > 0;

  @override
  Widget build(BuildContext context) {

    var _box = ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight,
      ),
      child: TextFormField(
        focusNode: _focusNode,
        readOnly: widget.readonly,
        autofocus: widget.autofocus,
        maxLengthEnforced: false,
        maxLength: widget.maxLength,
        textInputAction: widget.inputAction,
        // cursorHeight: 20,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.maxLines,
        controller: _controller,
        initialValue: widget.initialValue,
        onTap: widget.onTap,
        onChanged: (val) {
          widget.onChanged(val);
          if (mounted) setState(() {});
        },
        onFieldSubmitted: widget.onFieldSubmitted,
        onEditingComplete: () {
          if (widget.onEditingComplete != null) widget.onEditingComplete(_controller.text);
        },
        cursorColor: Get.theme.primaryColor,
        style: widget.textStyle ?? currentTheme.inputTextStyle,
        obscureText: widget.obscureText,
        keyboardType: widget.inputType,
        onSaved: widget.onSaved,
        autocorrect: widget.autocorrect,
        validator: widget.validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // prefix: widget.prefix,
          // errorStyle: TextStyle(
          //   textBaseline: TextBaseline.alphabetic
          // ),
          counterStyle: TextStyle(
            textBaseline: TextBaseline.alphabetic
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            textBaseline: TextBaseline.alphabetic,
            color: widget.hintTextColor ?? currentTheme.hintTextColor
          ),
          contentPadding: widget.contentPadding,
          fillColor: Colors.transparent,
          filled: true,
        ),
      ),
    );

    return Container(
      width: widget.width ?? Get.width,
      padding: widget.padding,
      margin: hasError ? widget.margin.add(EdgeInsets.only(bottom: 10)) : widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: (widget.borderType == TextBoxBorderType.outline || widget.borderType == TextBoxBorderType.custom && widget.border == null || widget.border != null && widget.border.isUniform) ? widget.borderRadius : null,
        border: getBorder()
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.prefixIcon != null ? Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 10, left: 16),
            child: Icon(widget.prefixIcon,
              size: widget.prefixIconSize,
              color: getColor(widget.prefixIconColor)
            )
          ) : SizedBox(),
          widget.labelText != null ? Expanded(
            flex: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              width: widget.labelWidth,
              height: 40,
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
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  _box,
                  Positioned(
                    left: 12,
                    top: 50,
                    child: hasError ? Text(
                      widget.errorText, 
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red
                      )
                    ) : SizedBox(),
                  ),
                ],
              ),
              decoration: BoxDecoration(
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              height: 40,
              child: Row(
                children: [
                  Visibility(
                    visible: _controller != null && widget.canClear && _controller.text.length > 0 && _focusNode.hasFocus,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                        child: Icon(Icons.cancel, color: Colors.grey, size: 18),
                        onTap: () {
                          if (mounted) setState(() {
                            _controller.clear();
                            widget.onChanged('');
                          });
                        },
                      ),
                    ),
                  ),
                  ...widget.suffix
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
