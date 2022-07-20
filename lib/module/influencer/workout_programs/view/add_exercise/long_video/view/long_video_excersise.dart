import 'dart:developer';
import 'dart:io';

import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/widgets/video_container.dart';
import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/long_video/bloc/exersise_bloc.dart';
import 'package:app/module/influencer/workout_programs/widgets/exercise_duration_dialog.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/pickers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class LongVideoExerciseScreen extends StatefulWidget {
  static const id = "AddExercise";
  final String? title;
  final String? workoutType;
  final String? description;
  final String? workoutID;
  final String? weekID;
  final String? dayID;
  Data? data;

  LongVideoExerciseScreen(
      {Key? key,
      this.title,
      this.description,
      this.workoutType,
      this.workoutID,
      this.weekID,
      this.dayID,
      this.data})
      : super(key: key);

  @override
  State<LongVideoExerciseScreen> createState() => _LongVideoExerciseScreenState();
}

class _LongVideoExerciseScreenState extends State<LongVideoExerciseScreen> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();
  String longVideoExerciseDuration = "";
  String longVideoExerciseDurationMin = "";
  String? path;
  String? netImage;
  ExerciseCubit exerciseCubit = ExerciseCubit();
  List<File> _createPostImageFiles = [];
  String? assetType;
  @override
  void initState() {
    if (widget.data != null) {
      _titleController.text = widget.data!.title;
      _descriptionController.text = widget.data!.instructions;
      netImage = widget.data!.assetUrl;
      assetType = widget.data!.assetType;
      longVideoExerciseDuration = widget.data!.exerciseTime;
    }
    super.initState();
  }

  _pickImage(ImageSource source) async {
    path = await Pickers.instance.pickImage(source: source);
    print("image path :$path");
    if (path != null) {
      setState(() {});
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
        if (_createPostImageFiles.isNotEmpty) {
          path = _createPostImageFiles[0].path;
        }
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
          title: widget.title!,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalisation.getTranslated(context, LKWorkoutType),
                  style: subTitleTextStyle(context)?.copyWith(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: choiceChipWidget(context,
                      title: "Long Video", isIncomeSelected: true, onSelected: (val) {}),
                ),
                SizedBox(
                  height: 20,
                ),
                SalukTextField(
                  textEditingController: _titleController,
                  hintText: "",
                  labelText: AppLocalisation.getTranslated(context, LKExerciseName),
                ),
                SizedBox(
                  height: 20,
                ),
                netImage != null
                    ? assetType!.contains("Image")
                        ? ImageContainer(
                            path: netImage!,
                            onClose: () => setState(() => path = null),
                          )
                        : VideoContainer(
                            closeButton: () {
                              Fluttertoast.showToast(msg: "msg");
                              setState(() {
                                netImage = null;
                              });
                            },
                          )
                    : path == null
                        ? GestureDetector(
                            onTap: () {
                              popUpAlertDialog(
                                context,
                                'Pick Image',
                                LKImageDialogDetail,
                                isProfile: true,
                                onCameraTap: () {
                                  _pickImage(ImageSource.camera);
                                },
                                onGalleryTap: () {
                                  _pickImagesFromGallery();
                                },
                              );
                            },
                            child: const DottedContainer())
                        : path!.contains("mp4")
                            ? VideoContainer(
                                closeButton: () {
                                  setState(() {
                                    path = null;
                                  });
                                },
                              )
                            : ImageContainer(
                                path: path!,
                                onClose: () => setState(() => path = null),
                              ),
                SizedBox(
                  height: 20,
                ),
                SalukTextField(
                    textEditingController: _descriptionController,
                    maxLines: 6,
                    hintText: "",
                    labelText: AppLocalisation.getTranslated(context, LKTypeInstructions)),
                SizedBox(
                  height: 20,
                ),
                longVideoExerciseDuration == ''
                    ? SalukTransparentButton(
                        title: AppLocalisation.getTranslated(context, LKAddDuration),
                        buttonWidth: defaultSize.screenWidth,
                        borderColor: PRIMARY_COLOR,
                        textColor: PRIMARY_COLOR,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ExerciseDurationDialog(
                                  heading: AppLocalisation.getTranslated(context, LKExerciseTime),
                                  onChanged: (String value) {
                                    setState(() {
                                      longVideoExerciseDuration = value;
                                    });
                                  },
                                  onChanged2: (String value) {
                                    setState(() {
                                      longVideoExerciseDurationMin = value;
                                    });
                                  },
                                );
                              });
                        },
                        buttonHeight: HEIGHT_4,
                        style: labelTextStyle(context)?.copyWith(
                          fontSize: 14.sp,
                          color: PRIMARY_COLOR,
                        ),
                        icon: Icon(
                          Icons.add_circle,
                          color: PRIMARY_COLOR,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      )
                    : Row(
                        children: [
                          const Icon(
                            Icons.access_time_sharp,
                            color: Colors.grey,
                          ),
                          SB_1W,
                          Text(
                            longVideoExerciseDuration + ' ' + longVideoExerciseDurationMin,
                            style: labelTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          SB_1W,
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ExerciseDurationDialog(
                                      heading:
                                          AppLocalisation.getTranslated(context, LKExerciseTime),
                                      onChanged: (String value) {
                                        longVideoExerciseDuration = value;
                                        setState(() {});
                                      },
                                      onChanged2: (String value) {
                                        longVideoExerciseDurationMin = value;
                                        setState(() {});
                                      },
                                    );
                                  });
                            },
                            child: const Icon(
                              Icons.edit,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
      bottomNavigationBar: BottomAppBar(
        child: SalukBottomButton(
            title: AppLocalisation.getTranslated(context, LKSubmit),
            callback: () async {
              addLongVideoExercise();
            },
            isButtonDisabled: false),
      ),
    );
  }

  addLongVideoExercise() async {
    if (_titleController.text.isEmpty) {
      showSnackBar(
        context,
        'Please enter exercise title',
        textColor: Colors.white,
      );
    } else if (_descriptionController.text.isEmpty) {
      showSnackBar(
        context,
        'Please Add exercise instructions',
        textColor: Colors.white,
      );
    } else if (longVideoExerciseDuration.isEmpty) {
      showSnackBar(
        context,
        'Please Add exercise instructions',
        textColor: Colors.white,
      );
    } else {
      Map<String, String> data = {
        "assetType": path != null
            ? path!.contains('mp4')
                ? 'video'
                : 'Image'
            : "",
        "title": _titleController.text,
        "instructions": _descriptionController.text,
      };
      List<String> fields = [];
      List<String> paths = [];
      if (path != null) {
        fields.add('imageVideoURL');
        paths.add(path!);
      }
      print("body data :$data");
      bool? res;
      if (widget.data != null) {
        print("id : ${widget.data!.id}");
        print("duration : ${longVideoExerciseDuration}");
        data.addAll({"exerciseTime": longVideoExerciseDuration});
        res = await exerciseCubit.updateExercise(data, fields, paths, id: widget.data!.id);
      } else {
        if (paths.isNotEmpty) {
          print("path : ${path}");
          data.addAll({"exerciseTime": "00" + longVideoExerciseDuration});
          res = await exerciseCubit.addLongVideoExercise(data, fields, paths,
              workOutID: widget.workoutID, weekID: widget.weekID, dayID: widget.dayID);
        } else {
          showSnackBar(
            context,
            'Please Add image to continue',
            textColor: Colors.white,
          );
        }
      }

      if (res!) {
        Fluttertoast.showToast(msg: "Long video added successfully");
        Navigator.pop(context);
      } else {
        showSnackBar(
          context,
          'Something went wrong please try again',
          textColor: Colors.white,
        );
      }
    }
  }
}
