import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haku_app/theme/theme.dart';

/// 文本框
class TextBox extends StatelessWidget {
  /// 标签文本
  final String labelText;
  /// 点击事件
  final Function onTap;
  /// 值改变事件
  final ValueChanged<String> onChanged;
  /// 编辑完成事件
  final Function onEditingComplete;
  final bool obscureText;
  final TextInputType textInputType;
  final Function(String) onSaved;
  final bool autocorrect;
  final FormFieldValidator<String> validator;
  final String errorText;
  final String initialValue;
  final TextEditingController controller;
  final int maxLines;
  final List<TextInputFormatter> inputFormatters;
  final bool autovalidate;
  final String hintText;
  final TextInputAction textInputAction;
  final Widget suffix;
  /// 前缀图标
  final Widget prefixIcon;
  /// 后缀图标
  final Widget suffixIcon;
  /// 允许清空
  final Function onClear;

  const TextBox({
    Key key,
    @required this.labelText,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.textInputType,
    this.onSaved,
    this.autocorrect = false,
    this.obscureText = false,
    this.validator,
    this.errorText,
    this.initialValue,
    this.controller,
    this.maxLines = 1,
    this.inputFormatters,
    this.autovalidate = false,
    this.hintText,
    this.textInputAction,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.onClear
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        textInputAction: textInputAction,
        autovalidate: autovalidate,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        controller: controller,
        initialValue: initialValue,
        onTap: onTap,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        cursorColor: Get.theme.primaryColor,
        style: currentTheme.inputTextStyle,
        obscureText: obscureText,
        keyboardType: textInputType,
        onSaved: onSaved,
        autocorrect: autocorrect,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          suffix: suffix,
          hintText: hintText,
          errorText: errorText,
          labelText: labelText,
          // hintStyle: inputFieldHintTextStyle,
          // focusedBorder: inputFieldFocusedBorderStyle,
          contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          // border: inputFieldDefaultBorderStyle,
        ),
      ),
    );
  }
}
