import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DigtalGalleryApp extends StatefulWidget {
  const DigtalGalleryApp({super.key});

  @override
  State<DigtalGalleryApp> createState() => _DigtalGalleryAppState();
}

class _DigtalGalleryAppState extends State<DigtalGalleryApp> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images;

  int currentPage = 0;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();

    loadImages();
  }

  Future<void> loadImages() async {
    // List 로 이미지 가져오기
    images = await _picker.pickMultiImage();

    if (images != null) {
      Timer.periodic(Duration(seconds: 5), (timer) {
        currentPage++;

        if (currentPage > images!.length - 1) {
          currentPage = 0;
        }

        pageController.animateToPage(
            currentPage, duration: Duration(milliseconds: 350),
            curve: Curves.easeIn);
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전자액자'),
      ),
      body: images == null
          ? Center(
        child: Text('no data'),
      )
          : PageView(
        controller: pageController,
        children: images!.map((e) {
          return FutureBuilder<Uint8List>(
              future: e.readAsBytes(),
              builder: (context, snapshot) {
                final data = snapshot.data;

                if (data == null ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Image.memory(
                  data,
                  width: double.infinity,
                );
              }
          );
        }).toList(),
      ),
    );
  }
}
