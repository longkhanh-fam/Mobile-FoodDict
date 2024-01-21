import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// import 'package:fooderapp/pages/display_image_screen.dart';
// import 'package:fooderapp/pages/food_recognition_screen.dart';
import 'package:fooderapp/pages/food_predict_screen.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    print("pick img");
    final selectedImage = await ImagePicker().pickImage(source: source);

    if (selectedImage != null) {
      setState(() {
        _imageFile = File(selectedImage.path);
      });

      // Chuyển đến màn hình hiển thị ảnh
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PredictionScreen(imagePath: _imageFile!.path)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chụp và Hiển Thị Ảnh'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile == null
                ? const Text('Chưa có ảnh được chọn')
                : Image.file(_imageFile!),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: const Text('Chụp Ảnh'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: const Text('Chọn Ảnh từ Thư Viện'),
            ),
          ],
        ),
      ),
    );
  }
}
