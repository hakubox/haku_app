
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// 骨架屏
class Skeleton extends StatelessWidget {

  /// 内容
  final Widget child;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 外边距
  final EdgeInsetsGeometry margin;
  /// 基础颜色
  final Color baseColor;
  /// 高亮颜色
  final Color highlightColor;

  const Skeleton({
    Key key,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.baseColor = const Color(0xFFE0E0E0), 
    this.highlightColor = const Color(0xFFF5F5F5), 
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        constraints: BoxConstraints(
          
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}