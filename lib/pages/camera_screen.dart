import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fooderapp/pages/food_predict_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture = Completer<void>().future;
  File? _imageFile;

  @override
  void initState() {
    super.initState();

    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      // Lấy danh sách camera có sẵn
      List<CameraDescription> cameras = await availableCameras();

      // Chọn camera sau cùng (hoặc chọn camera theo nhu cầu của bạn)
      _controller = CameraController(
          cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.back),
          ResolutionPreset.medium);

      // Khởi tạo controller và đợi cho đến khi camera sẵn sàng
      _initializeControllerFuture = _controller.initialize();
      await _initializeControllerFuture;
      _initializeControllerFuture.whenComplete(() {
        if (!mounted) return; // Tránh lỗi nếu màn hình đã bị dispose
        setState(() {});
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    // Giải phóng tài nguyên của camera khi thoát màn hình
    _controller.dispose();
    super.dispose();
  }

  void goToPredictionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PredictionScreen(imagePath: _imageFile!.path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Take a photo of your dish',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Nếu camera đã sẵn sàng, hiển thị khung camera
            return CameraPreview(_controller);
          } else {
            // Nếu chưa sẵn sàng, hiển thị loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () async {
                // Chụp ảnh và lưu vào _imageFile
                final image = await _controller.takePicture();
                setState(() {
                  _imageFile = File(image.path);
                });
                goToPredictionScreen();
              },
              icon: const Icon(Icons.camera),
            ),
            IconButton(
              onPressed: () async {
                // Chọn ảnh từ thư viện và lưu vào _imageFile
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                setState(() {
                  _imageFile = File(image!.path);
                });
                goToPredictionScreen();
              },
              icon: const Icon(Icons.image),
            ),
          ],
        ),
      ),
    );
  }
}