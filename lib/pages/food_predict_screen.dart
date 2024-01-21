import 'dart:typed_data';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;
import 'package:tflite_flutter/tflite_flutter.dart';

class PredictionScreen extends StatefulWidget {
  final String imagePath;

  const PredictionScreen({super.key, required this.imagePath});

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  late Interpreter interpreter;
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
  late Uint8List imageBytes;
  late String predictedClass;

  @override
  void initState() {
    super.initState();
    predictedClass = 'Unknown';
    // imageBytes = Uint8List(0);
    loadImage();
    loadModel();
  }

  Future<Uint8List> preprocessImage(
      File imageFile, int targetWidth, int targetHeight) async {
    final rawBytes = await imageFile.readAsBytes();
    final Uint8List imageBytes = Uint8List.fromList(rawBytes);

    // Decode image using image package
    imglib.Image image = imglib.decodeImage(imageBytes) as imglib.Image;

    // Resize image to the target dimensions
    image = imglib.copyResize(image, width: targetWidth, height: targetHeight);

    return Uint8List.fromList(imglib.encodeJpg(image));
  }

  void loadImage() async {
    imageBytes = await preprocessImage(File(widget.imagePath), 299, 299);
    // imageBytes = Uint8List.fromList(await File(widget.imagePath).readAsBytes());
    // File imageFile = File(widget.imagePath);
    // List<int> imageBytes = imageFile.readAsBytesSync();

    // // Decode ảnh
    // img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;

    // // Resize ảnh
    // img.Image resizedImage = img.copyResize(image, width: 299, height: 299);

    // // Convert ảnh sang mảng bytes và chuẩn hóa
    // imageBytes = Uint8List.fromList(img.encodePng(resizedImage));

    // return normalizedImage;
  }

  void loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/food_model.tflite');
  }

  String predictImage() {
    print(imageBytes);
    var inputShape = interpreter.getInputTensor(0).shape;

// Kiểm tra kích thước đầu vào yêu cầu bởi mô hình
    print('Model Input Shape: $inputShape');
    // var input = imageBytes.buffer.asUint8List();
    // var output = List.generate(1, (index) => List.filled(foodList.length, 0.0));

    //   // Example: Chuẩn bị dữ liệu đầu vào
    // var inputShape = interpreter!.getInputTensor(0).shape;
    var inputType = interpreter.getInputTensor(0).type;
    print('Model Input Type: $inputType');
    var inputData =
        Float32List.fromList(imageBytes.map((e) => e / 255.0).toList());
    // TensorBuffer inputTensorBuffer = TensorBufferFloat32.fromList(inputShape, inputData);
    var outputTensorBuffer = Float32List(101);
    print(inputData);
    print(outputTensorBuffer);

    // Thực hiện dự đoán bằng cách truyền dữ liệu vào mô hình
    interpreter.run(inputData, interpreter.getOutputTensor(0).data);
    Float32List outputData = interpreter.getOutputTensor(0).data as Float32List;
    int predictedClassIndex = outputData
        .indexOf(outputData.reduce((curr, next) => curr > next ? curr : next));

    print(predictedClassIndex);

    // interpreter.run(input, output);

    // final index = output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b));

    // Get the predicted food item
    // final predValue = foodList[index];

    // print('Predicted food item: $predValue');
    return "";
  }

  void onPredictPressed() {
    predictImage();
    // Hiển thị tên của lớp được dự đoán
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kết quả dự đoán'),
        content: Text('Ảnh được dự đoán thuộc lớp: $predictedClass'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dự đoán Thực Phẩm'),
      ),
      body: Column(
        children: [
          // Hiển thị ảnh
          Image.file(File(widget.imagePath), height: 200, width: 200),

          // Nút Dự đoán
          ElevatedButton(
            onPressed: onPredictPressed,
            child: const Text('Dự đoán'),
          ),
        ],
      ),
    );
  }
}
