import 'package:json_annotation/json_annotation.dart';

part 'blog.g.dart';

@JsonSerializable()
class BlogModel {
  String? image;
  String? blogTitle;
  String? blogDescription;
  BlogModel({
    this.image,
    this.blogTitle,
    this.blogDescription,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlogModelToJson(this);
}
