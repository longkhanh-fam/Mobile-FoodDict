import 'package:fooderapp/models/base_model.dart';

class User implements BaseModel {
  int? id;
  String name;
  String? bio;
  String? imageUrl;

  User({
    this.id,
    required this.name,
    this.bio,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        bio: json["bio"],
        imageUrl: json["imageUrl"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bio": bio,
        "imageUrl": imageUrl,
      };
}
