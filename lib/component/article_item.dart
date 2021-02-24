
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'img.dart';

/// 列表的文章项
class ArticleItem extends StatelessWidget {

  /// 标题
  final String title;
  /// 副标题
  final String subTitle;
  /// 副标题最大行数
  final int subTitleMaxLines;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 前缀组件
  final Widget prefix;
  /// 前缀图片
  final String prefixImg;
  /// 前缀图片宽度
  final double prefixImgWidth;
  /// 后缀组件
  final Widget suffix;
  /// 后缀图片
  final String suffixImg;
  /// 后缀图片宽度
  final double suffixImgWidth;
  /// 链接文字（和点击事件冲突）
  final String url;
  /// 点击事件
  final Function onTap;
  /// 动作组件列表
  final List<Widget> actions;

  const ArticleItem({
    Key key,
    @required this.title,
    this.onTap,
    this.subTitle,
    this.padding = EdgeInsets.zero,
    this.subTitleMaxLines = 1,
    this.url,
    this.prefix,
    this.prefixImg,
    this.prefixImgWidth = 40,
    this.suffix,
    this.suffixImg,
    this.suffixImgWidth = 80,
    this.actions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              child: Expanded(
                flex: 0,
                child: Img(prefixImg, width: prefixImgWidth, margin: EdgeInsets.only(right: 10),),
              ),
              visible: prefixImg != null,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(title, 
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12, 
                        height: 1.3
                      )
                    ),
                  ),
                  subTitle != null ? Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(bottom: 6),
                    child: Text(subTitle,
                      maxLines: subTitleMaxLines,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11, 
                        height: 1.6, 
                        color: Color(0xFF8E8E8E)
                      )
                    ),
                  ) : SizedBox(),
                  actions != null ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: actions,
                  ) : SizedBox()
                ],
              ),
            ),
            Visibility(
              child: Expanded(
                flex: 0,
                child: Img(suffixImg, width: suffixImgWidth, height: 55, fit: BoxFit.cover, margin: EdgeInsets.only(left: 10),),
              ),
              visible: suffixImg != null,
            ),
          ],
        ),
      ),
      onTap: () {
        url == null ? onTap() : Get.toNamed(url);
      },
    );
  }
}
