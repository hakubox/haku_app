import 'package:cached_network_image/cached_network_image.dart';
import 'package:haku_app/packages/log/log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'img.dart';

/// 图片预览组件
class ImgPreview extends StatefulWidget {
  /// 图片路径
  final List<String> imgs;
  /// 当前图片索引
  final int index;
  /// 显示迷你图
  final bool showMiniMap;
  /// 允许下载
  final bool canDownload;
  /// 最大缩放倍数
  final double minScale;
  /// 最小缩放倍数
  final double maxScale;
  /// 背景色
  final Color backgroundColor;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// Hero动画TagId
  final String heroTag;

  ImgPreview(this.imgs, {
    this.index = 0,
    this.canDownload = true,
    this.showMiniMap = true,
    this.backgroundColor = Colors.black,
    this.padding = EdgeInsets.zero,
    this.minScale = 0.2,
    this.maxScale = 10.0,
    this.heroTag
  });

  @override
  _ImgPreviewState createState() => _ImgPreviewState();
}

class _ImgPreviewState extends State<ImgPreview> {

  /// 当前下标
  int pageIndex = 0;
  /// 页面控制器
  PageController pageController;
  // 缩略图滚动条控制器
  ScrollController scrollController;

  @override
  void initState() {
    pageIndex = widget.index;
    pageController = PageController();
    scrollController = ScrollController();
    // pageController.jumpTo(widget.index.toDouble());
    super.initState();
    // scrollController.addListener((){
    //   Log.log(scrollController.offset.toString());
    // });
  }

  @override
  void dispose() {
    scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.backgroundColor
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 80,
              right: 0,
              child: widget.imgs.length > 1 ? PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                enableRotation: true,
                itemCount: widget.imgs.length, 
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    heroAttributes: widget.heroTag.isBlank ? null : PhotoViewHeroAttributes(
                      transitionOnUserGestures: true,
                      createRectTween: (begin, end) {
                        return MaterialRectCenterArcTween(begin: begin, end: end);
                      },
                      tag: widget.heroTag,
                    ),
                    filterQuality: FilterQuality.high,
                    maxScale: widget.maxScale,
                    minScale: widget.minScale,
                    imageProvider: widget.imgs[index].toString().startsWith('http') ? CachedNetworkImageProvider(widget.imgs[index]) : AssetImage(widget.imgs[index].startsWith('assets') ? widget.imgs[index] : 'assets/img/${widget.imgs[index]}'),
                  );
                },
                loadFailedChild: Image.asset('assets/img/no-image.jpg'),
                pageController: pageController,
                backgroundDecoration: BoxDecoration(
                  color: widget.backgroundColor
                ),
                onPageChanged: (int index) {
                  double _offset = index * 72.0;
                  if (_offset < Get.width / 2) {
                    scrollController.jumpTo(0);
                  } else if (_offset > widget.imgs.length * 72 - Get.width / 2) {
                    scrollController.jumpTo(widget.imgs.length * 72 - Get.width);
                  } else {
                    scrollController.jumpTo(_offset - Get.width / 2 + 36);
                  }
                  if (mounted) setState(() {
                    pageIndex = index;
                  });
                }
              ) : PhotoView(
                enableRotation: true,
                filterQuality: FilterQuality.high,
                maxScale: widget.maxScale,
                minScale: widget.minScale,
                backgroundDecoration: BoxDecoration(
                  color: widget.backgroundColor
                ),
                heroAttributes: widget.heroTag.isBlank ? null : PhotoViewHeroAttributes(
                  transitionOnUserGestures: true,
                  createRectTween: (begin, end) {
                    return MaterialRectCenterArcTween(begin: begin, end: end);
                  },
                  tag: widget.heroTag,
                ),
                imageProvider: widget.imgs[0].toString().startsWith('http') ? CachedNetworkImageProvider(widget.imgs[0]) : AssetImage(widget.imgs[0].startsWith('assets') ? widget.imgs[0] : 'assets/img/${widget.imgs[0]}'),
              ),
            ),

            // 预览图
            Visibility(
              visible: widget.imgs.length > 1 && widget.showMiniMap,
              child: Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  child: Container(
                    height: 70,
                    color: Color(0x33FFFFFF),
                    alignment: Alignment.center,
                    child: ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: pageIndex == index ? Color(0x33000000) : Colors.transparent,
                            border: Border.fromBorderSide(pageIndex == index ? BorderSide(
                              style: BorderStyle.solid,
                              width: 1
                            ) : BorderSide(
                              color: Colors.transparent,
                              width: 1
                            )),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Img(widget.imgs[index], 
                            fit: BoxFit.contain,
                            width: 50,
                            height: 50,
                            onTap: () {
                              if (pageController.page != index.toDouble()) {
                                if (mounted) setState(() {
                                  pageController.jumpToPage(index);
                                });
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 110,
              left: 0,
              right: 0,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Icon(Icons.file_download, size: 30, color: Colors.white),
                        decoration: BoxDecoration(
                          color: Color(0x33FFFFFF),
                          borderRadius: BorderRadius.all(Radius.circular(6))
                        ),
                      ),
                      onTap: () {
                        Log.log('下载中');
                      },
                    ),
                    InkWell(
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Icon(Icons.share, size: 30, color: Colors.white),
                        decoration: BoxDecoration(
                          color: Color(0x33FFFFFF),
                          borderRadius: BorderRadius.all(Radius.circular(6))
                        ),
                      ),
                      onTap: () {
                        Log.log('下载中');
                      },
                    )
                  ],
                ),
              ),
            ),

            // 关闭按钮
            Positioned(
              right: 10,
              top: 30,
              child: IconButton(
                padding: EdgeInsets.all(15),
                icon: Icon(Icons.close, size: 30, color: Colors.white),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}