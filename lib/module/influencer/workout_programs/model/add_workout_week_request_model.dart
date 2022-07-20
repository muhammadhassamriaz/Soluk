import 'dart:io';

class AddWorkoutWeekRequestModel {
  late final File media;
  late final String assetType;
  late final String workoutTitle;
  late final String description;
  late final int workoutID;
  late final int? weekID;

  AddWorkoutWeekRequestModel(
      {required this.media,
      required this.assetType,
      required this.workoutTitle,
      required this.description,
      required this.workoutID,
      this.weekID});
}
