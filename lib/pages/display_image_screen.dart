import 'package:flutter/material.dart';
import 'dart:io';

class DisplayImageScreen extends StatelessWidget {
  final File imageFile;

  const DisplayImageScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hiển Thị Ảnh'),
      ),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}
