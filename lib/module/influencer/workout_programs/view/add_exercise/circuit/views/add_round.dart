import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/info_dialog_box.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/bloc/workout_program_bloc.dart';
import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:app/module/influencer/workout_programs/model/workout_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_excerise_state.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_exersise_bloc.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/model/round_exercise_request_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/model/rounds_response.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/views/add_superset_exercise_screen.dart';
import 'package:app/module/influencer/workout_programs/widgets/exercise_duration_dialog.dart';
import 'package:app/module/influencer/workout_programs/widgets/round_workout_title.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AddRound extends StatefulWidget {
  static const id = "AddRound";
  WorkOutModel data;
  final List<RoundsData>? roundsList;
  AddRound({Key? key, required this.data, this.roundsList}) : super(key: key);

  @override
  State<AddRound> createState() => _AddRoundState();
}

class _AddRoundState extends State<AddRound> {
  CircuitWorkOutCubit circuitWorkOutCubit = CircuitWorkOutCubit();
  String restDuration = '';
  String restDurationMin = '';
  RoundExerciseRequest? requestData;
  int roundExerciseList = 2;
  @override
  void initState() {
    super.initState();
    print("rounds :${widget.data.title}");
    getRoundExercise();
  }

  @override
  Widget build(BuildContext context) {
    print("round list : $roundExerciseList");
    return BlocConsumer<CircuitWorkOutCubit, CircuitWorkOutState>(
        bloc: circuitWorkOutCubit,
        listener: (context, state) {
          if (state is LoadingState) {
          } else if (state is ExerciseError) {
            showSnackBar(
              context,
              state.message!,
              textColor: Colors.white,
            );
          } else if (state is RoundExerciseLoaded) {
            if (state.data!.responseDetails!.data != null) {
              roundExerciseList = state.data!.responseDetails!.data![0].sets!.length;
              setState(() {});
            }
          } else if (state is RestTimeAddedState) {
            showSnackBar(
              context,
              "Round Rest time added successfully",
              textColor: Colors.white,
            );
          }
        },
        builder: (context, state) {
          print("rest time value : $roundExerciseList");
          return Scaffold(
            body: AppBody(
                title: "Round 1",
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        widget.data.workoutType == 'Circuit'
                            ? const SizedBox()
                            : Text(
                                AppLocalisation.getTranslated(context, LKYouCanAddMax2Exercise),
                                style: subTitleTextStyle(context)?.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                        roundExerciseList >= 2 ? SizedBox() : SB_1H,
                        roundExerciseList >= 2
                            ? Container()
                            : SalukTransparentButton(
                                title: AppLocalisation.getTranslated(context, LKAddExercises),
                                buttonWidth: defaultSize.screenWidth,
                                borderColor: PRIMARY_COLOR,
                                buttonColor: PRIMARY_COLOR,
                                onPressed: () async {
                                  bool exerciseAdded = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AddSuperSetExerciseScreen(
                                        data: widget.data,
                                      ),
                                    ),
                                  );
                                  if (exerciseAdded) {
                                    getRoundExercise();
                                  }
                                },
                                buttonHeight: HEIGHT_3,
                                style: buttonTextStyle(context)?.copyWith(
                                  fontSize: 14.sp,
                                  color: SCAFFOLD_BACKGROUND_COLOR,
                                ),
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: SCAFFOLD_BACKGROUND_COLOR,
                                ),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                        SB_1H,
                        BlocBuilder<CircuitWorkOutCubit, CircuitWorkOutState>(
                          bloc: circuitWorkOutCubit,
                          builder: (context, state) {
                            if (state is ExerciseLoading) {
                              return Center(
                                child: LinearProgressIndicator(),
                              );
                            } else if (state is RoundExerciseLoaded) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.data!.responseDetails!.data![0].sets!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Sets data = state.data!.responseDetails!.data![0].sets![index];
                                  return RoundWorkoutTile(
                                    image: data.assetUrl,
                                    callback: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (_) => WorkoutWeek(),
                                      //   ),
                                      // );
                                    },
                                    description: data.instructions,
                                    exerciseType: data.type!,
                                    exerciseValue: "",
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        Container(
                          width: defaultSize.screenWidth,
                          height: 1,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        SB_1H,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Round Rest Time",
                            style: subTitleTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        restDuration == ''
                            ? SalukTransparentButton(
                                title: AppLocalisation.getTranslated(context, LKExerciseRestTime),
                                buttonWidth: defaultSize.screenWidth,
                                borderColor: PRIMARY_COLOR,
                                textColor: PRIMARY_COLOR,
                                onPressed: () {
                                  showRoundRestTimeDialog();
                                },
                                buttonHeight: HEIGHT_3,
                                style: labelTextStyle(context)?.copyWith(
                                  fontSize: 14.sp,
                                  color: PRIMARY_COLOR,
                                ),
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: PRIMARY_COLOR,
                                ),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              )
                            : Row(
                                children: [
                                  Text(
                                    restDuration + ' ' + restDurationMin,
                                    style: labelTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SB_1W,
                                  InkWell(
                                    onTap: () {
                                      showRoundRestTimeDialog();

                                      //getRoundExercise();
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: PRIMARY_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ],
                )),
            bottomNavigationBar: BottomAppBar(
              child: SalukBottomButton(
                  title: AppLocalisation.getTranslated(context, LKSubmit),
                  callback: () async {
                    addRoundRestTime();
                  },
                  isButtonDisabled: restDuration.isEmpty ? true : false),
            ),
          );
        });
  }

  getRoundExercise() {
    circuitWorkOutCubit.getRoundExercises(id: widget.data.exerciseId.toString());
  }

  addRoundRestTime() async {
    if (restDuration != '') {
      bool apiResult = await circuitWorkOutCubit.putRoundRestTime(
          time: "00:$restDuration",
          exerciseId: widget.data.exerciseId,
          exerciseSubType: widget.data.roundId);

      if (apiResult) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return InfoDialogBox(
                icon: 'assets/images/tick_ss.png',
                title: AppLocalisation.getTranslated(context, LKCongratulations),
                description:
                    AppLocalisation.getTranslated(context, LKYourWorkoutUploadedSuccessfully),
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              );
            });
      }
    } else {
      showSnackBar(context, "Add rest time to continue");
    }
  }

  showRoundRestTimeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ExerciseDurationDialog(
            heading: AppLocalisation.getTranslated(context, LKAddRestTime),
            onPressed: () {
              print("hello");
            },
            onChanged: (String value) {
              restDuration = value;
              setState(() {});
            },
            onChanged2: (String value) {
              restDurationMin = value;
              setState(() {});
            },
          );
        });
  }
}
