import 'dart:developer';
import 'dart:io';

import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:app/module/influencer/workout_programs/model/workout_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_excerise_state.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_exersise_bloc.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/views/add_superset_exercise_screen.dart';
import 'package:app/module/influencer/workout_programs/widgets/round_workout_title.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/pickers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddTimeBasedExercise extends StatefulWidget {
  final WorkOutModel? data;
  const AddTimeBasedExercise({Key? key, this.data}) : super(key: key);

  @override
  State<AddTimeBasedExercise> createState() => _AddTimeBasedExerciseState();
}

class _AddTimeBasedExerciseState extends State<AddTimeBasedExercise> {
  int viewType = 1;
  final TextEditingController _titleController = TextEditingController();
  List<File> _createPostImageFiles = [];
  String? path;
  CircuitWorkOutCubit circuitWorkOutCubit = CircuitWorkOutCubit();
  @override
  void initState() {
    super.initState();
  }

  _pickImage(ImageSource source) async {
    path = await Pickers.instance.pickImage(source: source);
    print("image path :$path");
    if (path != null) {
      setState(() {
        _createPostImageFiles.add(File(path!));
      });
    }
  }

  _pickImagesFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.media,
      allowCompression: true,
    );
    if (result != null) {
      log(result.toString());
      setState(() {
        _createPostImageFiles = result.paths.map((e) => File(e!)).toList();
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        title: "Time Based",
        body: BlocConsumer<CircuitWorkOutCubit, CircuitWorkOutState>(
            bloc: circuitWorkOutCubit,
            listener: (context, state) {
              if (state is ExerciseError) {
                showSnackBar(
                  context,
                  state.message!,
                  textColor: Colors.white,
                );
              } else if (state is ExerciseLoaded) {}
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Time Duration",
                      style: subTitleTextStyle(context)?.copyWith(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/svgs/cross_icon.svg', height: 25, width: 25),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "30 mints",
                          style: labelTextStyle(context)?.copyWith(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // SalukTextField(
                    //   textEditingController: _titleController,
                    //   hintText: "",
                    //   labelText: "Superset Title",
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // _createPostImageFiles.isEmpty
                    //     ? GestureDetector(
                    //         onTap: () {
                    //           popUpAlertDialog(
                    //             context,
                    //             'Pick Image',
                    //             LKImageDialogDetail,
                    //             isProfile: true,
                    //             onCameraTap: () {
                    //               _pickImage(ImageSource.camera);
                    //             },
                    //             onGalleryTap: () {
                    //               _pickImagesFromGallery();
                    //             },
                    //           );
                    //         },
                    //         child: const DottedContainer())
                    //     : _createPostImageFiles[0].path.contains("mp4")
                    //         ? VideoContainer(
                    //             closeButton: () {
                    //               setState(() {
                    //                 _createPostImageFiles = [];
                    //               });
                    //             },
                    //           )
                    //         : ImageContainer(
                    //             path: _createPostImageFiles[0].path,
                    //             onClose: () => setState(() => _createPostImageFiles = []),
                    //           ),
                    SizedBox(
                      height: 20,
                    ),
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
                              return Column(
                                children: [
                                  RoundWorkoutTile(
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
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "30 Rest Time",
                                    style: labelTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    SalukTransparentButton(
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
                      style: labelTextStyle(context)?.copyWith(
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
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  getRoundExercise() {
    circuitWorkOutCubit.getRoundExercises(id: widget.data!.exerciseId.toString());
  }
}
