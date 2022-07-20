import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/fab.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/module/influencer/workout_programs/model/get_week_all_days_workouts_response.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/long_video/view/long_video_excersise.dart';
import 'package:app/module/influencer/workout_programs/view/day_detail.dart';
import 'package:app/module/influencer/workout_programs/view/widgets/exercise_tile.dart';
import 'package:app/module/influencer/workout_programs/view/workout_day/bloc/workout_day_cubit.dart';
import 'package:app/module/influencer/workout_programs/view/workout_day/bloc/workout_day_state.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_program_tile.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_type_custom_dialog.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_type_dropdown.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class WorkOutDaysScreen extends StatefulWidget {
  static const id = 'WorkoutDays';
  final String title;
  final Data data;
  final String workoutID;
  final String weekID;
  WorkOutDaysScreen(
      {Key? key,
      required this.title,
      required this.data,
      required this.workoutID,
      required this.weekID})
      : super(key: key);

  @override
  State<WorkOutDaysScreen> createState() => _WorkOutDaysScreenState();
}

class _WorkOutDaysScreenState extends State<WorkOutDaysScreen> {
  WorkOutDayCubit workOutCubit = WorkOutDayCubit();
  @override
  void initState() {
    workOutCubit.getAllExercises(id: widget.data.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: AppBody(
        title: widget.data.title,
        bgColor: backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: WorkoutProgramTile(
                image: widget.data.assetUrl,
                title: "Day Title",
                description: widget.data.title,
                callback: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DayDetail(
                        title: 'Day Title',
                        data: widget.data,
                        workoutId: widget.workoutID,
                        weekId: widget.weekID,
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(
              AppLocalisation.getTranslated(context, LKWorkoutExercises),
              style: subTitleTextStyle(context)?.copyWith(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            SB_1H,
            BlocBuilder<WorkOutDayCubit, WorkOutDayState>(
                bloc: workOutCubit,
                builder: (_, state) {
                  print("state $state");
                  if (state is WorkOutDayLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    );
                  } else if (state is WorkOutDayEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext dcontext) {
                                    return WorkoutTypeCustomDialog(
                                      contentWidget: WorkoutTypeDropDown(),
                                      workoutID: widget.workoutID,
                                      weekID: widget.weekID,
                                      dayID: widget.data.id.toString(),
                                    );
                                  });
                            },
                            child: SvgPicture.asset(PLUS_ICON)),
                        const SizedBox(height: 14),
                        Text(
                          AppLocalisation.getTranslated(context, LKCreateExercise),
                          style: subTitleTextStyle(context)
                              ?.copyWith(fontSize: defaultSize.screenWidth * .050),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sollicitudin porttitor turpis non at nec facilisis lacus.",
                            textAlign: TextAlign.center,
                            style: hintTextStyle(context),
                          ),
                        ),
                      ],
                    );
                  } else if (state is WorkOutDayLoaded) {
                    return Expanded(
                      child: RefreshWidget(
                        refreshController: workOutCubit.refreshController,
                        onLoadMore: () => workOutCubit.onLoadMore(),
                        onRefresh: () => workOutCubit.onRefresh(),
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.exerciseResponse!.responseDetails!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = state.exerciseResponse!.responseDetails!.data![index];
                            String duration;
                            if (data.exerciseTime != null) {
                              if (data.workoutType != "Supersets") {
                                duration = data.exerciseTime.split(":")[1];
                              } else {
                                duration = "";
                              }
                            } else {
                              duration = "0 mints";
                            }

                            return ExerciseTile(
                              title: data.title,
                              image: data.assetUrl,
                              duration: duration,
                              type: data.workoutType,
                              callback: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LongVideoExerciseScreen(
                                      data: data,
                                      title: data.title,
                                      workoutID: data.workoutId.toString(),
                                      weekID: data.workoutWeekId.toString(),
                                      dayID: data.workoutDayId.toString(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                        child: Text("Error state"),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FAB(
        callback: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return WorkoutTypeCustomDialog(
                  contentWidget: WorkoutTypeDropDown(),
                  workoutID: widget.workoutID,
                  weekID: widget.weekID,
                  dayID: widget.data.id.toString(),
                );
              });
        },
      ),
    );
  }
}
