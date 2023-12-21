import 'package:flutter/material.dart';

class DigtalGalleryApp extends StatefulWidget {
  const DigtalGalleryApp({super.key});

  @override
  State<DigtalGalleryApp> createState() => _DigtalGalleryAppState();
}

class _DigtalGalleryAppState extends State<DigtalGalleryApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전자액자'),
      ),
    );
  }
}
