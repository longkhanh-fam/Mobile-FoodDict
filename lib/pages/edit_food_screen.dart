import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/services/food_service.dart';
import 'package:fooderapp/utils/upload_images.dart';
import 'package:image_picker/image_picker.dart';

class EditFoodScreen extends StatefulWidget {
  final int id;

  const EditFoodScreen({Key? key, required this.id}) : super(key: key);

  @override
  _EditFoodScreenState createState() => _EditFoodScreenState();
}

class _EditFoodScreenState extends State<EditFoodScreen> {
  final TextEditingController _nameController = TextEditingController();
  List<String> ingredients = [];
  List<String> recipe = [];
  NutritionFact? nutritionFact;
  String? selectedImagePath;
  bool hasSelectedImage = false;
  int currentCardIndex = 0;
  late Food food;

   final TextEditingController _descriptionController = TextEditingController();


  //nutrition fact
  late TextEditingController _sugarController = TextEditingController();
  late TextEditingController _sodiumController = TextEditingController();
  late TextEditingController _proteinController = TextEditingController();
  late TextEditingController _caloriesController = TextEditingController();
  late TextEditingController _totalFatController = TextEditingController();
  late TextEditingController _cholesterolController = TextEditingController();
  late TextEditingController _servingSizeController = TextEditingController();
  late TextEditingController _dietaryFiberController = TextEditingController();
  late TextEditingController _saturatedFatController = TextEditingController();
  late TextEditingController _totalCarbohydrateController = TextEditingController();



  late XFile uploadImage ;
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        XFile? xFile = XFile(pickedFile.path); 
        uploadImage = xFile;
        selectedImagePath = pickedFile.path;
        hasSelectedImage = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFoodDetails();
  }

  Future<void> fetchFoodDetails() async {
    food = await getFood(widget.id);
    setState(() {
      // Set the controllers and variables with fetched data
      _nameController.text = food.title;
      _descriptionController.text = food.body;

      nutritionFact = food.nutritionFact;
      // Set the initial values for nutrition fact controllers
      _sugarController.text = food.nutritionFact?.sugar ?? '';
      _sodiumController.text = food.nutritionFact?.sodium ?? '';
      _proteinController.text = nutritionFact?.protein ?? '';
      _caloriesController.text = nutritionFact?.calories ?? '';
      _totalFatController.text = nutritionFact?.totalFat ?? '';
      _cholesterolController.text = nutritionFact?.cholesterol ?? '';
      _servingSizeController.text = nutritionFact?.servingSize ?? '';
      _dietaryFiberController.text = nutritionFact?.dietaryFiber ?? '';
      _saturatedFatController.text = nutritionFact?.saturatedFat ?? '';
      _totalCarbohydrateController.text = nutritionFact?.totalCarbohydrate ?? '';


      // You may also set the initial values for ingredients and recipe if needed
      ingredients = food.ingredients ?? [];
      recipe = food.recipe ?? [];
    });
  }

  Future<void> saveFood() async {
    String? imageUrl;

  if (hasSelectedImage) {
    // If a new image is selected, upload it and get the URL
    final imageUrls = await uploadImages([uploadImage]);
    imageUrl = imageUrls?.isNotEmpty == true ? imageUrls![0] : null;
  } else {
    // If no new image is selected, use the existing image URL
    imageUrl = food.images?.isNotEmpty == true ? food.images![0] : null;
  }
    try {
      await updateFood({
      "title": _nameController.text,
      "body": _descriptionController.text,
      "images": [imageUrl ?? ""],
      "ingredients": ingredients,
      "recipe": recipe,
      "nutrition_fact": {
        "sugar": _sugarController.text,
        "sodium": _sodiumController.text,
        "protein": _proteinController.text,
        "calories": _caloriesController.text,
        "totalFat": _totalFatController.text,
        "cholesterol": _cholesterolController.text,
        "servingSize": _servingSizeController.text,
        "dietaryFiber": _dietaryFiberController.text,
        "saturatedFat": _saturatedFatController.text,
        "totalCarbohydrate": _totalCarbohydrateController.text,
      },
      //"authorId": 1,
      //"createdAt": "2024-01-24T11:40:49.799455",  // Replace with the actual value from DateTime.now()
      "isPublic": false
      }, widget.id
    );
    } catch (e) {
      print("Error posting food: $e");
    }
    // Show a SnackBar to notify the successful edit
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Food edited successfully'),
        ),
      );
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('EditFoodScreen: build()${food.nutritionFact?.sugar}');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Your Food',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ... các phần khác của màn hình

                  // InkWell containing an Icon for image selection
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      height: 300,
                      width: 200,
                      color: Colors.grey[300],
                      child: hasSelectedImage
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                // Display the selected image
                                Image.file(
                                  File(selectedImagePath!),
                                  height: 400,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                // Add a delete button in the top-right corner
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        selectedImagePath = null;
                                        hasSelectedImage = false;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : (food.images != null) // Check if food has an image URL
                              ? Image.network(
                                  food.images![0],
                                  height: 400,
                                  width: 200,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.add_a_photo, size: 48, color: Colors.black),
                    ),
                  ),

                ],
              ),

              // Text field for entering food name
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Food Name'),
              ),
              
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Food Description'),
                maxLines: 3, // Adjust the number of lines according to your design
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentCardIndex = 0;
                      });
                    },
                    child: const Text('Ingredients'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentCardIndex = 1;
                      });
                    },
                    child: const Text('Recipe'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentCardIndex = 2;
                      });
                    },
                    child: const Text('Nutrition Facts'),
                  ),
                ],
              ),

              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: (currentCardIndex == 0)
                      ? Column(
                          children: [
                            const Text(
                              'Ingredients',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            buildList(
                              ingredients,
                              'Add Ingredient',
                              (text) {
                                setState(() {
                                  ingredients.add(text);
                                });
                              },
                              (index) {
                                setState(() {
                                  ingredients.removeAt(index);
                                });
                              },
                              (index, text) {
                                setState(() {
                                  ingredients[index] = text;
                                });
                              },
                            ),
                          ],
                        )
                      : (currentCardIndex == 1)
                          ? Column(
                              children: [
                                const Text(
                                  'Recipe',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                buildList(
                                  recipe,
                                  'Add Recipe',
                                  (text) {
                                    setState(() {
                                      recipe.add(text);
                                    });
                                  },
                                  (index) {
                                    setState(() {
                                      recipe.removeAt(index);
                                    });
                                  },
                                  (index, text) {
                                    setState(() {
                                      recipe[index] = text;
                                    });
                                  },
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                const Text(
                                  'Nutrition Facts',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                buildNutritionFactsInput(),
                              ],
                            )),

              // Button to save the food
              ElevatedButton(
                onPressed: () {
                  // Call a function to save the food with entered data
                  saveFood();
                },
                child: const Text('Save Food'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(
      List<String> items,
      String addButtonLabel,
      Function(String) onAdd,
      Function(int) onDelete,
      Function(int, String) onEdit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Display existing items
        if (items.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: items
                .asMap()
                .entries
                .map(
                  (entry) => Dismissible(
                    key: Key(entry.key.toString()),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      onDelete(entry.key);
                    },
                    child: ListTile(
                      title: RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.circle,
                                    size: 6, color: Colors.deepPurple),
                              ),
                              alignment: PlaceholderAlignment.middle,
                              baseline: TextBaseline
                                  .alphabetic, // Adjust this for vertical alignment
                            ),
                            TextSpan(
                              text: entry.value,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Show a dialog to edit item
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  final TextEditingController textController =
                                      TextEditingController(text: entry.value);
                                  return AlertDialog(
                                    title: const Text('Edit Item'),
                                    content: TextField(
                                      controller: textController,
                                      decoration: const InputDecoration(
                                          labelText: 'Edit item'),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          onEdit(
                                              entry.key, textController.text);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              onDelete(entry.key);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),

        // Button to add new item
        TextButton(
          onPressed: () {
            // Show a dialog to enter new item
            showDialog(
              context: context,
              builder: (BuildContext context) {
                final TextEditingController textController =
                    TextEditingController();
                return AlertDialog(
                  title: const Text('Add New Item'),
                  content: TextField(
                    controller: textController,
                    decoration:
                        const InputDecoration(labelText: 'Enter new item'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        onAdd(textController.text);
                        Navigator.pop(context);
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
          child: Row(
            children: [
              const Icon(Icons.add),
              const SizedBox(
                  width: 8.0), // Khoảng cách giữa biểu tượng và văn bản
              Text(addButtonLabel),
            ],
          ),
        ),
      ],
    );
  }

   Widget buildNutritionFactsInput() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextFormField(
        controller: _sugarController,
        decoration: const InputDecoration(labelText: 'Sugar'),
      ),
      TextFormField(
        controller: _sodiumController,
        decoration: const InputDecoration(labelText: 'Sodium'),
      ),
      TextFormField(
        controller: _proteinController,
        decoration: const InputDecoration(labelText: 'Protein'),
      ),
      TextFormField(
        controller: _caloriesController,
        decoration: const InputDecoration(labelText: 'Calories'),
      ),
      TextFormField(
        controller: _totalFatController,
        decoration: const InputDecoration(labelText: 'TotalFat'),
      ),
      TextFormField(
        controller: _cholesterolController,
        decoration: const InputDecoration(labelText: 'Cholesterol'),
      ),
      TextFormField(
        controller: _servingSizeController,
        decoration: const InputDecoration(labelText: 'ServingSize'),
      ),
      TextFormField(
        controller: _dietaryFiberController,
        decoration: const InputDecoration(labelText: 'DietaryFiber'),
      ),
      TextFormField(
        controller: _saturatedFatController,
        decoration: const InputDecoration(labelText: 'SaturatedFat'),
      ),
      TextFormField(
        controller: _totalCarbohydrateController,
        decoration: const InputDecoration(labelText: 'TotalCarbohydrate'),
      ),
    ],
  );
}


  // 
}
