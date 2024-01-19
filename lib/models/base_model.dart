abstract class BaseModel {
  Map<String, dynamic> toJson();
  factory BaseModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
