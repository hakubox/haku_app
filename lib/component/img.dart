import 'package:cached_network_image/cached_network_image.dart';
import 'package:haku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:haku_app/packages/log/log.dart';
import 'package:get/get.dart';

/// 缩略图配置
class ThumbnailSize {
  /// 缩略图宽度
  final int width;
  /// 缩略图高度
  final int height;
  /// 缩略图填充方式
  final BoxFit fit;
  /// 缩略图宽
  const ThumbnailSize({this.width = 0, this.height = 0, this.fit = BoxFit.none});

  @override
  String toString() {
    List<String> str = [];
    if (width != 0) {
      str.add('width=' + width.toString());
    }
    if (height != 0) str.add('height=' + height.toString());
    if (fit == BoxFit.none) str.add('type=' + fit.toString().substring(fit.toString().lastIndexOf('.') + 1));
    return str.join('&');
  }

  static const ThumbnailSize none = ThumbnailSize();
}

/// 图片
class Img extends StatefulWidget {
  /// 本地路径或网络路径
  final String src;
  /// 无图片地址
  final String blankSrc;
  /// 透明度
  final double opacity;
  /// 填充方式
  final BoxFit fit;
  /// 宽度
  final double width;
  /// 高度
  final double height;
  /// 边框
  final BorderSide border;
  /// 背景色
  final Color backgroundColor;
  /// 圆角
  final BorderRadiusGeometry borderRadius;
  /// Hero动画标签
  final String heroTag;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 外边距
  final EdgeInsetsGeometry margin;
  /// 图片平铺方式
  final ImageRepeat repeat;
  /// OSS图片压缩指定宽度
  final int ossWidth;
  /// 后端压缩配置
  final ThumbnailSize thumbnailSize;
  /// 点击事件
  final void Function() onTap;

  const Img(this.src, {
    Key key,
    this.blankSrc = 'assets/img/no-image.jpg',
    this.fit: BoxFit.fill,
    this.opacity = 1,
    this.width,
    this.height,
    this.onTap,
    this.border = BorderSide.none,
    this.backgroundColor = Colors.transparent,
    this.borderRadius = BorderRadius.zero,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.repeat = ImageRepeat.noRepeat,
    this.thumbnailSize = ThumbnailSize.none,
    this.ossWidth = 0,
    this.heroTag
  }) : super(key: key);

  @override
  ImgState createState() => ImgState();


}

class ImgState extends State<Img> with AutomaticKeepAliveClientMixin {

  /// 文本框焦点
  Widget _imgBox = SizedBox();

  @override
  bool get wantKeepAlive => true;

  /// 构建图片
  buildImg() {
    Widget _img;
    if (widget.src == null || widget.src.isEmpty) {
      _img = Image.asset(
        widget.blankSrc,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        repeat: widget.repeat,
      );
    } else if (widget.src.startsWith('http')) {
      String _src = '';
      if (widget.thumbnailSize != ThumbnailSize.none) {
        _src = widget.src + '?' + widget.thumbnailSize.toString();
      } else if (widget.ossWidth != 0) {
        _src = widget.src + '?x-oss-process=image/resize,w_' + widget.ossWidth.toString();
      } else {
        _src = widget.src;
      }
      
      _img = Image(
        image: CachedNetworkImageProvider(_src),
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        repeat: widget.repeat,
        loadingBuilder: (BuildContext context, Widget defaultWidget, ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return defaultWidget;
          return Container(
            width: widget.width,
            height: widget.height,
            color: widget.backgroundColor,
            child: Center(
              child: SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(currentTheme.primaryColor),
                  backgroundColor: Color(0xFFDDDDDD),
                  value: loadingProgress.expectedTotalBytes != null ? 
                    loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null,
                ),
              ),
            ),
          );
        },
        errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
          Log.error('加载${widget.src}图片失败');
          return Image.asset(
            widget.blankSrc,
            width: widget.width,
            height: widget.height,
            fit: widget.fit
          );
        },
      );
    } else {
      _img = Image.asset(
        widget.src.startsWith('assets') ? widget.src : 'assets/img/' + widget.src,
        width: widget.width ?? Get.width,
        height: widget.height,
        fit: widget.fit,
        repeat: widget.repeat,
        gaplessPlayback: true,
      );
    }
    // imglib.Image image = imglib.decodeImage(File(src.startsWith('assets') ? src : 'assets/img/' + src).readAsBytesSync());
    // image = imglib.copyResize(image, 
    //   width: (width ?? Get.width).round(),
    //   height: height.round(),
    //   interpolation: imglib.Interpolation.cubic,
    // );
    // _img = Image.memory(imglib.encodeJpg(image));

    Widget _card = Container(
      child: Center(
        child: Opacity(
          opacity: widget.opacity,
          child: _img,
        )
      ),
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        border: Border.fromBorderSide(widget.border)
      ),
      clipBehavior: Clip.antiAlias,
      padding: widget.padding,
      margin: widget.margin,
    );

    if (widget.heroTag != null) {
      _card = Hero(
        // transitionOnUserGestures: true,
        // createRectTween: (begin, end) {
        //   return MaterialRectCenterArcTween(begin: begin, end: end);
        // },
        tag: widget.heroTag,
        child: _card,
      );
    }

    _imgBox = widget.onTap != null ? InkWell(
      child: _card,
      onTap: () {
        widget.onTap();
      },
    ) : _card;
  }

  @override
  void initState() {
    super.initState();
    buildImg();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _imgBox;
  }
}
