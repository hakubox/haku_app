import 'package:haku_app/component/index.dart';
import 'package:haku_app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:get/get.dart';
import 'package:haku_app/theme/theme.dart';

/// 城市选择器
class CityPicker extends StatefulWidget {

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
  final void Function(Picker, int, List<int>) onChanged;
  /// 编辑完成事件
  final Function onEditingComplete;
  /// 是否隐藏输入
  final bool obscureText;
  /// 最大高度
  final double height;
  /// 文本框输入类型
  final TextInputType inputType;
  /// 确认地址事件
  final void Function(List<int>) onConfirm;
  final bool autocorrect;
  final FormFieldValidator<String> validator;
  final String errorText;
  final String initialValue;
  final String hintText;
  /// 前缀组件
  final Widget prefix;
  /// 后缀组件
  final List<Widget> suffix;
  /// 前缀图标
  final Widget prefixIcon;
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
  /// 自动获取焦点
  final bool autofocus;

  const CityPicker({
    Key key,
    this.labelText,
    this.labelStyle = const TextStyle(),
    this.labelWidth = 80,
    this.backgroundColor = Colors.transparent,
    this.textStyle,
    this.readonly = false,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.inputType = TextInputType.text,
    this.onConfirm,
    this.autocorrect = false,
    this.obscureText = false,
    this.height = 250,
    this.validator,
    this.errorText,
    this.initialValue,
    this.hintText,
    this.prefix,
    this.suffix = const [],
    this.prefixIcon,
    this.border,
    this.borderSide = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
    this.borderType = customTextBorderType,
    this.padding = const EdgeInsets.fromLTRB(0, 8, 2, 8),
    this.margin = EdgeInsets.zero,
    this.autofocus = true
  }) : super(key: key);
 
  @override
  CityPickerState createState() => CityPickerState();
}

class CityPickerState extends State<CityPicker> with WidgetsBindingObserver {

  /// 文本框焦点
  FocusNode _focusNode;

  TextEditingController _controller;

  /// 显示文本
  String text = '';

  Picker picker;

  @override
  void initState() {
    super.initState();
    picker = Picker(
      height: widget.height,
      adapter: PickerDataAdapter<String>(
        pickerdata: Global.addressMap
      ),
      cancelText: '取消',
      confirmText: '确认',
      textStyle: currentTheme.inputTextStyle,
      cancelTextStyle: TextStyle(
        fontSize: 16,
        color: Color(0xFFBBBBBB),
      ),
      confirmTextStyle: TextStyle(
        fontSize: 16,
        color: currentTheme.primaryColor,
      ),
      changeToFirst: true,
      textAlign: TextAlign.left,
      selectedTextStyle: currentTheme.inputTextStyle.copyWith(
        color: currentTheme.primaryColor
      ),
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (picker, value) {
        List<String> names = picker.adapter.text.substring(1, picker.adapter.text.length - 1).split(', ');
        if (widget.onConfirm != null) widget.onConfirm([
          Global.addressIds[names[0]],
          Global.addressIds[names[1]],
          Global.addressIds[names[2]],
        ]);
        _controller.text = '${names[0]} / ${names[1]} / ${names[2]}';
      },
      onSelect: (picker, index, value) {
        if (widget.onChanged != null) widget.onChanged(picker, index, value);
      }
    );
    _controller = TextEditingController();
    _focusNode = FocusNode(
      onKey: (node, event) {
        if (!_focusNode.hasFocus) {
          FocusScope.of(Get.context).requestFocus(FocusNode());
        }
        return true;
      }
    );
    _focusNode.addListener(() {
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
    Color _color = widget.borderSide.style != BorderStyle.none ? widget.borderSide.color : currentTheme.borderColor;
    if (widget.readonly) {
      _color = Color(0xFFCCCCCC);
    } if (widget.errorText != null) {
      _color = Colors.red;
    } else if (_focusNode.hasFocus) {
      _color = currentTheme.primaryColor;
    }
    return BorderSide(
      width: widget.borderSide.style != BorderStyle.none ? widget.borderSide.width : 0.5,
      style: BorderStyle.solid,
      color: _color
    );
  }

  /// 是否有错误
  get hasError => widget.errorText != null && widget.errorText.length > 0;

  @override
  Widget build(BuildContext context) {

    var _box = ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: double.infinity,
      ),
      child: TextFormField(
        focusNode: _focusNode,
        readOnly: true,
        autofocus: widget.autofocus,
        maxLengthEnforced: false,
        // cursorHeight: 20,
        controller: _controller,
        onEditingComplete: widget.onEditingComplete,
        onTap: () {
          picker.showModal(Get.context);
        },
        cursorColor: Get.theme.primaryColor,
        style: widget.textStyle ?? currentTheme.inputTextStyle,
        obscureText: widget.obscureText,
        keyboardType: widget.inputType,
        autocorrect: widget.autocorrect,
        validator: widget.validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: widget.prefixIcon,
          prefixIconConstraints: BoxConstraints(
            minWidth: 50,
          ),
          prefix: widget.prefix,
          // errorStyle: TextStyle(
          //   textBaseline: TextBaseline.alphabetic
          // ),
          counterStyle: TextStyle(
            textBaseline: TextBaseline.alphabetic
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            textBaseline: TextBaseline.alphabetic,
            color: currentTheme.disabledTextColor
          ),
          // contentPadding: padding,
          fillColor: Colors.transparent,
          filled: true,
        ),
      ),
    );

    return Container(
      margin: hasError ? widget.margin.add(EdgeInsets.only(bottom: 10)) : widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: (widget.borderType == TextBoxBorderType.outline || widget.borderType == TextBoxBorderType.custom && widget.border == null || widget.border != null && widget.border.isUniform) ? widget.borderRadius : null,
        border: getBorder()
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.labelText != null ? Expanded(
            flex: 0,
            child: Container(
              width: widget.labelWidth,
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
            child: Row(
              children: [
                ...widget.suffix
              ],
            ),
          ),
        ],
      ),
    );
  }
}
