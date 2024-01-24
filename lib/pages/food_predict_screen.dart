
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/pages/detail_dish_screen.dart';
import 'package:fooderapp/services/food_service.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/src/bindings/tensorflow_lite_bindings_generated.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

class PredictionScreen extends StatefulWidget {
  final String imagePath;

  const PredictionScreen({super.key, required this.imagePath});

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  late tfl.Interpreter interpreter;
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
  late Float32List imageBytes;
  late String predictedClass;
  late List<Food> _foodList;

  @override
  void initState() {
    super.initState();
    predictedClass = 'Unknown';
    // imageBytes = Uint8List(0);
    _foodList = getFoods() as List<Food>;
    loadImage();
    loadModel();
  }

  // Hàm đọc và xử lý hình ảnh từ đường dẫn imagePath
  Float32List processImage(
      String imagePath, int targetWidth, int targetHeight) {
    // Đọc hình ảnh từ đường dẫn
    File imageFile = File(imagePath);
    img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;

    // Resize hình ảnh nếu cần
    if (image.width != targetWidth || image.height != targetHeight) {
      image = img.copyResize(image, width: targetWidth, height: targetHeight);
    }

    // Chuẩn bị dữ liệu đầu vào cho mô hình
    var inputData = Float32List(3 * targetWidth * targetHeight);
    for (var y = 0; y < targetHeight; y++) {
      for (var x = 0; x < targetWidth; x++) {
        var pixel = image.getPixel(x, y);
        inputData[y * targetWidth * 3 + x * 3] = (img.getRed(pixel) / 255.0);
        inputData[y * targetWidth * 3 + x * 3 + 1] =
            (img.getGreen(pixel) / 255.0);
        inputData[y * targetWidth * 3 + x * 3 + 2] =
            (img.getBlue(pixel) / 255.0);
      }
    }

    return inputData;
  }

  void loadImage() async {
    imageBytes = processImage(widget.imagePath, 299, 299);
  }

  void loadModel() async {
    interpreter = await tfl.Interpreter.fromAsset('assets/food_model.tflite');
  }

  void predictImage() {
    var input = imageBytes.reshape([1, 299, 299, 3]);
    var output = List.filled(1 * 101, 0).reshape([1, 101]);

    // Thực hiện dự đoán bằng cách truyền dữ liệu vào mô hình
    interpreter.run(input, output);

    var maxResult = output[0]
        .reduce((double max, double current) => max > current ? max : current);

    var maxIndex = output[0].indexOf(maxResult);
    predictedClass = foodList[maxIndex];
  }

  void findDish() {
    predictImage();
    print('Predicted Class $predictedClass');
    List<Food> filteredFoods = _foodList
        .where((food) => food.title.toLowerCase().contains(predictedClass.toLowerCase()))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>  DetailsDishScreen(filteredFoods[0].id!)),
    );

    // Hiển thị tên của lớp được dự đoán
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('Kết quả dự đoán'),
    //     content: Text('Ảnh được dự đoán thuộc lớp: $predictedClass'),
    //     actions: [
    //       TextButton(
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //         child: const Text('Đóng'),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Hiển thị ảnh

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 500,
                width: 300,
                child: Image.file(File(widget.imagePath)),
              ),
            ],
          ),

          // Nút Dự đoán
          ElevatedButton(
            onPressed: findDish,
            child: const Text('Find dish'),
          ),
        ],
      ),
    );
  }
}