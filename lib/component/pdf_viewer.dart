import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

/// PDF查看器
class PDFViewer extends StatelessWidget {

  /// 标题
  final String title;
  /// PDF地址
  final String path;
  /// 
  // final Completer<PDFViewController> _pdfViewController = Completer<PDFViewController>();
  // final StreamController<String> _pageCountController = StreamController<String>();

  PDFViewer({
    Key key,
    this.title = 'PDF查看器',
    @required this.path
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        // actions: <Widget>[
        //   StreamBuilder<String>(
        //       stream: _pageCountController.stream,
        //       builder: (_, AsyncSnapshot<String> snapshot) {
        //         if (snapshot.hasData) {
        //           return Container(
        //             alignment: Alignment.center,
        //             padding: EdgeInsets.only(right: 10),
        //             child: Text(snapshot.data, style: TextStyle(
        //               color: Colors.white
        //             ),),
        //           );
        //         }
        //         return const SizedBox();
        //       }),
        // ],
      ),
      body: PDF.file(
        File(path),
        height: Get.height,
        width: Get.width,
      ),

      // body: PDF(
      //   enableSwipe: true,
      //   swipeHorizontal: false,
      //   autoSpacing: false,
      //   pageFling: true,
      //   onPageChanged: (int current, int total) =>
      //       _pageCountController.add('${current + 1} / $total页'),
      //   onViewCreated: (PDFViewController pdfViewController) async {
      //     _pdfViewController.complete(pdfViewController);
      //     final int currentPage = await pdfViewController.getCurrentPage();
      //     final int pageCount = await pdfViewController.getPageCount();
      //     _pageCountController.add('${currentPage + 1} / $pageCount页');
      //   },
      // ).fromAsset(
      //   pdfAssetPath,
      //   errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      // ),
      // floatingActionButton: FutureBuilder<PDFViewController>(
      //   future: _pdfViewController.future,
      //   builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
      //     if (snapshot.hasData && snapshot.data != null) {
      //       return Stack(
      //         children: [
      //           Positioned(
      //             bottom: 80,
      //             right: 0,
      //             child: InkWell(
      //               child: Container(
      //                 width: 50,
      //                 height: 50,
      //                 decoration: BoxDecoration(
      //                   color: currentTheme.primaryColor,
      //                   shape: BoxShape.circle
      //                 ),
      //                 child: Icon(LineIcons.angle_up, color: Colors.white, size: 20),
      //               ),
      //               onTap: () async {
      //                 final PDFViewController pdfController = snapshot.data;
      //                 final int currentPage =
      //                     await pdfController.getCurrentPage() - 1;
      //                 if (currentPage >= 0) {
      //                   await pdfController.setPage(currentPage);
      //                 }
      //               },
      //             ),
      //           ),
      //           Positioned(
      //             bottom: 10,
      //             right: 0,
      //             child: InkWell(
      //               child: Container(
      //                 width: 50,
      //                 height: 50,
      //                 decoration: BoxDecoration(
      //                   color: currentTheme.primaryColor,
      //                   shape: BoxShape.circle
      //                 ),
      //                 child: Icon(LineIcons.angle_down, color: Colors.white, size: 20),
      //               ),
      //               onTap: () async {
      //                 final PDFViewController pdfController = snapshot.data;
      //                 final int currentPage =
      //                     await pdfController.getCurrentPage() + 1;
      //                 if (currentPage >= 0) {
      //                   await pdfController.setPage(currentPage);
      //                 }
      //               },
      //             ),
      //           )
      //         ],
      //       );
      //       // return Row(
      //       //   mainAxisSize: MainAxisSize.max,
      //       //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       //   children: <Widget>[
      //       //     FloatingActionButton(
      //       //       heroTag: '-',
      //       //       child: const Text('-'),
      //       //       onPressed: () async {
      //       //         final PDFViewController pdfController = snapshot.data;
      //       //         final int currentPage =
      //       //             await pdfController.getCurrentPage() - 1;
      //       //         if (currentPage >= 0) {
      //       //           await pdfController.setPage(currentPage);
      //       //         }
      //       //       },
      //       //     ),
      //       //     FloatingActionButton(
      //       //       heroTag: '+',
      //       //       child: const Text('+'),
      //       //       onPressed: () async {
      //       //         final PDFViewController pdfController = snapshot.data;
      //       //         final int currentPage =
      //       //             await pdfController.getCurrentPage() + 1;
      //       //         final int numberOfPages =
      //       //             await pdfController.getPageCount();
      //       //         if (numberOfPages > currentPage) {
      //       //           await pdfController.setPage(currentPage);
      //       //         }
      //       //       },
      //       //     ),
      //       //   ],
      //       // );
      //     }
      //     return const SizedBox();
      //   },
      // ),
    );
  }
}