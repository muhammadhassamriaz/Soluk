import 'package:json_annotation/json_annotation.dart';

part 'rounds_response.g.dart';

@JsonSerializable()
class RoundsResponseModel {
  List<RoundsData> data;
  RoundsResponseModel(this.data);

  factory RoundsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RoundsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoundsResponseModelToJson(this);
}

@JsonSerializable()
class RoundsData {
  final int? workoutDayExerciseId;
  final String? subType;
  final String? exerciseTime;
  final int? id;

  RoundsData({
    this.workoutDayExerciseId,
    this.subType,
    this.exerciseTime,
    this.id,
  });

  factory RoundsData.fromJson(Map<String, dynamic> json) => _$RoundsDataFromJson(json);

  Map<String, dynamic> toJson() => _$RoundsDataToJson(this);
}
