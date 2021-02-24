import 'dart:io';

import 'package:haku_app/component/index.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'img.dart';

/// 图片上传
class FileUploader extends StatefulWidget {

  /// 文件列表
  List<PlatformFile> files;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 图片改变事件
  void Function(List<PlatformFile>) onChange;

  FileUploader({
    Key key,
    this.files,
    this.padding = const EdgeInsets.only(top: 10),
    this.onChange
  }) : super(key: key);

  @override
  _FileUploaderState createState() => _FileUploaderState();
}

class _FileUploaderState extends State<FileUploader> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 从系统中选择文件
  Future<List<PlatformFile>> selectFiles() async {
    List<PlatformFile> resultList = List<PlatformFile>();
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true
    );
    if(result != null) {
      resultList = result.files;
    } else {
      resultList = [];
    }
    return resultList;
  }

  Widget getThumbnail(PlatformFile file, {
    String baseUrl = 'assets/img/material/file/',
    String url,
    double width = 78,
    double height = 78
  }) {
    final String suffix = file.extension;
    Widget previewImg;
    String iconPath = '';
    String previewUrl = '';

    switch(suffix) {
      case 'ai':
        iconPath = 'ai.png';
        break;
      case 'psd':
        iconPath = 'psd.png';
        break;
      case 'txt':
      case 'md':
        iconPath = 'txt.png';
        break;
      case 'html':
      case 'htm':
      case 'json':
      case 'xml':
      case 'js':
      case 'ts':
      case 'dart':
      case 'css':
        iconPath = 'html.png';
        break;
      case 'jpg':
      case 'jpeg':
      case 'bmp':
      case 'png':
        previewImg = Image.asset(file.path,
          width: width,
          height: height,
          fit: BoxFit.cover
        );
        break;
      case 'gif':
        iconPath = 'gif.png';
        break;
      case 'pdf':
      case 'fdf':
      case 'ppdf':
        iconPath = 'ppt.png';
        break;
      case 'mp3':
      case 'midi':
      case 'wav':
      case 'wma':
        iconPath = 'mp.png';
        break;
      case 'ppt':
      case 'pptx':
        iconPath = 'ppt.png';
        break;
      case 'doc':
      case 'docx':
        iconPath = 'word.png';
        break;
      case 'xls':
      case 'xlsx':
        iconPath = 'excel.png';
        break;
      case 'zip':
      case 'rar':
      case '7z':
      case 'iso':
        iconPath = 'zip.png';
        break;
      case 'mp4':
      case 'avi':
      case 'mkv':
      case 'wmv':
        previewImg = FutureImg(
          future: Future(() async {
            final uint8list = await VideoThumbnail.thumbnailData(
              video: file.path,
              imageFormat: ImageFormat.JPEG,
              quality: 25,
            );
            return Image.memory(uint8list,
              width: width,
              height: height,
              fit: BoxFit.cover,
            );
          }),
        );
        // iconPath = 'video.png';
        break;
      default:
        iconPath = 'white.png';
    }
    return previewImg ?? Img(previewUrl ?? baseUrl + iconPath, 
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: Wrap(
        children: [
          ...widget.files.asMap().map((index, img) => MapEntry(index, InkWell(
            child: Container(
              margin: EdgeInsets.only(
                right: 4,
                bottom: 4
              ),
              child: getThumbnail(widget.files[index])
            ),
            onTap: () {
              setState(() {
                widget.files.removeAt(index);
                if (widget.onChange != null) widget.onChange(widget.files);
              });
            },
          ))).values.toList(),
          InkWell(
            child: Container(
              width: 78,
              height: 78,
              margin: EdgeInsets.only(
                right: 4,
                bottom: 4
              ),
              decoration: BoxDecoration(
                color: Color(0xFFE5E5E5)
              ),
              child: Icon(LineIcons.plus, size: 32,),
            ),
            onTap: () {
              selectFiles().then((filesList) async {
                if (filesList.length > 0) {
                  setState(() {
                    widget.files.addAll(filesList);
                    if (widget.onChange != null) widget.onChange(widget.files);
                  });
                  // ByteData _bytes = await imgList[0].getByteData();
                  // Uint8List imageData = _bytes.buffer.asUint8List();
                  // File file = File.fromRawPath(imageData);
                  // // 保存到照片
                  // final Map result = await ImageGallerySaver.saveFile(file.path);
                  // if (result != null && result['isSuccess']) {
                  //   Log.warn(Uri.decodeComponent(result));
                  // }
                }
              });
            }
          )
        ],
      ),
    );
  }
}