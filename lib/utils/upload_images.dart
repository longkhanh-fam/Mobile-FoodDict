import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:image_picker/image_picker.dart';

Future<List<String>> uploadImages(List<dynamic> files) async {
  List<String> res = [];
  for (var file in files) {
    if (file is String) {
      res.add(file);
    } else {
      FormData formData = FormData.fromMap({
        'key': imBBKey,
        'image': base64Encode(await (file as XFile).readAsBytes()),
      });
      Response response = await Dio().post(
        baseUrlImageUpload,
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );
      res.add(response.data["data"]["display_url"]);
    }
  }
  return res;
}
