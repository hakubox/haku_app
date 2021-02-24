import 'package:haku_app/api/authorize_api.dart';
import 'package:haku_app/packages/log/log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 发送短信按钮
class SmsButton extends StatefulWidget {
  /// 点击事件
  final bool Function() onPressed;
  /// 手机号
  final String phone;
  /// 背景色
  final Color backgroundColor;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 按钮文本颜色
  final Color fontColor;
  /// 按钮文本样式
  final Color fontStyle;
  /// 高度
  final double height;
  /// 按钮z轴高度（控制阴影）
  final double elevation;
  /// 最小宽度
  final double minWidth;
  /// 外边距
  final EdgeInsetsGeometry margin;
  /// 圆角
  final BorderRadiusGeometry borderRadius;

  const SmsButton({
    Key key,
    this.elevation = 0,
    @required this.phone,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0),
    this.margin = EdgeInsets.zero,
    this.height = 46,
    this.fontColor = Colors.white,
    this.fontStyle,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.minWidth,
    this.onPressed,
  }) : super(key: key);

  @override
  SmsButtonState createState() => SmsButtonState();
}

class SmsButtonState extends State<SmsButton> with WidgetsBindingObserver {

  // 最大单次发送时间（秒）
  int maxTime = 60;
  // 下次发送剩余时间（秒）
  int nextTime = 0;
  // 是否允许发送短信
  bool canSend = true;

  @override
  void initState() {
    super.initState();
  }

  timer() {
    Future.delayed(Duration(seconds: 1), () {
      if (nextTime > 0) {
        nextTime--;
        timer();
      } else {
        canSend = true;
      }
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: widget.margin,
      shadowColor: Colors.transparent,
      child: SizedBox(
        height: widget.height,
        child: MaterialButton(
          padding: widget.padding,
          disabledTextColor: Colors.white,
          disabledColor: Get.theme.primaryColor.withAlpha(180),
          child: Text(canSend ? '获取验证码' : '剩余 ${nextTime.toString()} 秒', style: widget.fontStyle ?? TextStyle(
            color: widget.fontColor
          )),
          elevation: widget.elevation,
          textColor: Colors.white,
          color: widget.backgroundColor ?? Get.theme.primaryColor,
          minWidth: widget.minWidth,
          shape: RoundedRectangleBorder(
            borderRadius: widget.borderRadius,
          ),
          onPressed: canSend ? () {
            if (widget.onPressed != null) {
              var re = widget.onPressed();
              if (re == false) return;
            }

            if (widget.phone == null || widget.phone.length < 11) {
              Get.snackbar('错误', '手机号格式错误');
              return;
            }

            if (nextTime <= 0 && canSend) {
              if (mounted) setState(() {
                canSend = false;
                nextTime = maxTime;
                timer();
                /// 发送验证码
                // AuthorizeApi.sendSmsVerifyPhone(widget.phone).then((value) {
                // }).catchError((err) {
                //   canSend = true;
                //   nextTime = 0;
                //   Log.error(err);
                // });
              });
            }
          } : null,
        ),
      ),
    );
  }
}
