class WorkOutModel {
  bool? isEditScreen;
  final bool? isCircuit;
  String? title;
  String? workoutType;
  int? numberOfRounds;
  final String? workoutID;
  final String? weekID;
  final String? dayID;
  final int? exerciseId;
  String? timeDuration;
  int? roundId;

  WorkOutModel(
      {this.isEditScreen = false,
      this.isCircuit,
      this.title,
      this.workoutType,
      this.numberOfRounds,
      this.workoutID,
      this.weekID,
      this.dayID,
      this.exerciseId,
      this.roundId,
      this.timeDuration});
}
