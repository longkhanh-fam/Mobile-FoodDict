import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class FoodRecognitionScreen extends StatefulWidget {
  final String imagePath;

  const FoodRecognitionScreen({super.key, required this.imagePath});

  @override
  _FoodRecognitionScreenState createState() => _FoodRecognitionScreenState();
}

class _FoodRecognitionScreenState extends State<FoodRecognitionScreen> {
  late Interpreter _interpreter;

  @override
  void initState() {
    super.initState();
    // Load mô hình TensorFlow Lite khi màn hình được khởi tạo
    loadModel();
  }

  void loadModel() async {
    try {
      // Đường dẫn đến tệp mô hình TensorFlow Lite
      String modelPath = 'assets/food_model.tflite';
      // Tải mô hình TensorFlow Lite
      _interpreter = await Interpreter.fromAsset(modelPath);
    } catch (e) {
      print('Error loading model: $e');
    }
    // print(_interpreter);
  }

  void predictImage() async {
    List<String> foodList = [
      'apple_pie',
      'baby_back_ribs',
      'baklava',
      'beef_carpaccio',
      'beef_tartare',
      'beet_salad',
      'beignets',
      'bibimbap',
      'bread_pudding',
      'breakfast_burrito',
      'bruschetta',
      'caesar_salad',
      'cannoli',
      'caprese_salad',
      'carrot_cake',
      'ceviche',
      'cheese_plate',
      'cheesecake',
      'chicken_curry',
      'chicken_quesadilla',
      'chicken_wings',
      'chocolate_cake',
      'chocolate_mousse',
      'churros',
      'clam_chowder',
      'club_sandwich',
      'crab_cakes',
      'creme_brulee',
      'croque_madame',
      'cup_cakes',
      'deviled_eggs',
      'donuts',
      'dumplings',
      'edamame',
      'eggs_benedict',
      'escargots',
      'falafel',
      'filet_mignon',
      'fish_and_chips',
      'foie_gras',
      'french_fries',
      'french_onion_soup',
      'french_toast',
      'fried_calamari',
      'fried_rice',
      'frozen_yogurt',
      'garlic_bread',
      'gnocchi',
      'greek_salad',
      'grilled_cheese_sandwich',
      'grilled_salmon',
      'guacamole',
      'gyoza',
      'hamburger',
      'hot_and_sour_soup',
      'hot_dog',
      'huevos_rancheros',
      'hummus',
      'ice_cream',
      'lasagna',
      'lobster_bisque',
      'lobster_roll_sandwich',
      'macaroni_and_cheese',
      'macarons',
      'miso_soup',
      'mussels',
      'nachos',
      'omelette',
      'onion_rings',
      'oysters',
      'pad_thai',
      'paella',
      'pancakes',
      'panna_cotta',
      'peking_duck',
      'pho',
      'pizza',
      'pork_chop',
      'poutine',
      'prime_rib',
      'pulled_pork_sandwich',
      'ramen',
      'ravioli',
      'red_velvet_cake',
      'risotto',
      'samosa',
      'sashimi',
      'scallops',
      'seaweed_salad',
      'shrimp_and_grits',
      'spaghetti_bolognese',
      'spaghetti_carbonara',
      'spring_rolls',
      'steak',
      'strawberry_shortcake',
      'sushi',
      'tacos',
      'takoyaki',
      'tiramisu',
      'tuna_tartare',
      'waffles'
    ];
// Đọc dữ liệu ảnh từ đường dẫn
    File imageFile = File(widget.imagePath);
    img.Image inputImage = img.decodeImage(imageFile.readAsBytesSync())!;

    // Chuyển đổi ảnh sang Uint8List
    Uint8List inputImageData = inputImage.getBytes();

    // Chuẩn bị đầu vào cho mô hình TensorFlow Lite
    var inputs = [inputImageData];

    // Chuẩn bị đầu ra
    var outputs = List.generate(1, (_) => List<double>.filled(101, 0.0));

    // Chạy mô hình
    _interpreter.run(inputImageData.buffer.asUint8List(), outputs);

    // Đóng interpreter sau khi sử dụng xon

    // Lấy chỉ số lớp có xác suất cao nhất
    int predictedClass = outputs[0].indexWhere(
        (score) => score == outputs[0].reduce((a, b) => a > b ? a : b));

    // Lấy tên của lớp dự đoán
    String predictedFood = foodList[predictedClass];
    print('The predicted food is: $predictedFood');

    // Hiển thị kết quả dự đoán
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Predicted Food'),
        content: Text('The predicted food is: $predictedFood'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi màn hình bị hủy
    _interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Recognition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(widget.imagePath)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: predictImage,
              child: const Text('Predict Image'),
            ),
          ],
        ),
      ),
    );
  }
}
