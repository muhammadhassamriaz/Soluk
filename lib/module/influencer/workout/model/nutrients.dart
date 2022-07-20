import 'package:json_annotation/json_annotation.dart';

part 'nutrients.g.dart';

@JsonSerializable()
class NutrientModel {
  String? image;
  String? title;
  List<String>? nutrientImages;
  NutrientModel({
    this.image,
    this.title,
    this.nutrientImages,
  });

  factory NutrientModel.fromJson(Map<String, dynamic> json) =>
      _$NutrientModelFromJson(json);

  Map<String, dynamic> toJson() => _$NutrientModelToJson(this);
}
