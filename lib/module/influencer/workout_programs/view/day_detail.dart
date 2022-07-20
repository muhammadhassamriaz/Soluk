import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/bloc/workout_program_bloc.dart';
import 'package:app/module/influencer/workout_programs/view/add_workout_day.dart';
import 'package:app/module/influencer/workout_programs/view/media_screen.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../model/get_week_all_days_workouts_response.dart';

class DayDetail extends StatefulWidget {
  static const id = 'DayDetail';
  final String title;
  final Data data;
  final String workoutId;
  final String weekId;
  const DayDetail(
      {Key? key,
      required this.title,
      required this.data,
      required this.workoutId,
      required this.weekId})
      : super(key: key);

  @override
  State<DayDetail> createState() => _DayDetailState();
}

class _DayDetailState extends State<DayDetail> {
  @override
  Widget build(BuildContext context) {
    final _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
    _workoutProgramBloc.add(WorkoutPrerequisitesLoadingEvent());
    return BlocConsumer<WorkoutProgramBloc, WorkoutProgramState>(
        listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is ErrorState) {
        showSnackBar(
          context,
          state.error,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      } else if (state is InternetErrorState) {
        showSnackBar(
          context,
          state.error,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
            body: Column(
          children: [
            SB_1H,
            SB_1H,
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MediaScreen(
                                videoUrl: widget.data.assetUrl,
                                title: widget.data.title,
                                mediaTypeisVideo:
                                    widget.data.assetType == 'Image'
                                        ? false
                                        : true,
                              )),
                    );
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: HEIGHT_5 * 3.5,
                    decoration: const BoxDecoration(
                        // image: DecorationImage(
                        //   image: AssetImage(WORKOUT_COVER2),
                        //   fit: BoxFit.cover,
                        // ),
                        ),
                    child: CachedNetworkImage(
                      imageUrl: widget.data.assetUrl,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            color: PRIMARY_COLOR,
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SolukBackButton(
                            callback: () {},
                          ),
                          Text(
                            widget.data.title,
                            style: subTitleTextStyle(context)?.copyWith(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: defaultSize.screenWidth * .09,
                              width: defaultSize.screenWidth * .09,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.red,
                                  size: defaultSize.screenWidth * .05,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      height: HEIGHT_5 * 1.5,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: defaultSize.screenHeight * 0.7,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 35, left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Day title',
                                      maxLines: 1,
                                      style: hintTextStyle(context)?.copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.data.title,
                                      maxLines: 1,
                                      style: hintTextStyle(context)?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AddWorkoutDay(
                                                isEditScreen: true,
                                                workoutId: widget.workoutId,
                                                weekId: widget.workoutId,
                                                data: widget.data,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    height: defaultSize.screenWidth * .09,
                                    width: defaultSize.screenWidth * .09,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(30.0),
                                        topLeft: Radius.circular(30.0),
                                        bottomLeft: Radius.circular(30.0),
                                        bottomRight: Radius.circular(30.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                        size: defaultSize.screenWidth * .05,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SB_1H,
                            Text(
                              AppLocalisation.getTranslated(
                                  context, LKDescription),
                              maxLines: 1,
                              style: hintTextStyle(context)?.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.data.description,
                              style: hintTextStyle(context)?.copyWith(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        )),
      );
    });
  }
}
