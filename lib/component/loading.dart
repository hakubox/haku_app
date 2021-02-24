
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 加载框
class Loading {

  /// 标题
  final String title;
  /// 等待时间
  final Duration duration;

  const Loading({
    this.title = 'loading...',
    this.duration,
  });

  static loading({
    Duration duration,
    String title
  }) {
    return Loading(
      duration: duration,
      title: title
    );
  }

  hide() {
    Get.back();
  }

  show() {
    if (duration != null) {
      Future.delayed(duration).then((value) {
        Get.back();
      });
    }
    Get.to(Center(
      child: Material(
        ///背景透明
      color: Colors.transparent,
        ///保证控件居中效果
        child: Center(
          ///弹框大小
          child: SizedBox(
            width: 120.0,
            height: 120.0,
            child: Container(
              ///弹框背景和圆角
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Text(
                      "加载中...",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    ;
  }
  
}