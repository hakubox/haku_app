
import 'package:flutter/material.dart';

/// 图片上传
class FutureImg extends StatefulWidget {

  /// 异步函数
  final Future<Widget> future;
  /// 宽度
  final double width;
  /// 高度
  final double height;

  const FutureImg({
    Key key,
    this.future,
    this.width = 78,
    this.height = 78
  }) : super(key: key);

  @override
  _FutureImgState createState() => _FutureImgState();
}

class _FutureImgState extends State<FutureImg> {

  bool isSuccess = false;
  Widget _widget;

  @override
  void initState() {
    super.initState();
    widget.future.then((val) {
      setState(() {
        _widget = val;
        isSuccess = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      child: isSuccess ? _widget : Text('加载中...'),
    );
  }
}