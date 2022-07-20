import 'dart:developer';
import 'dart:io';

import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/widgets/video_container.dart';
import 'package:app/module/influencer/workout_programs/model/AddExerciseSingleWTimeRequestModel.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_excerise_state.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_exersise_bloc.dart';
import 'package:app/module/influencer/workout_programs/widgets/superset_circuit_type_dialog.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/pickers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class CircuitWorkOutScreen extends StatefulWidget {
  final bool? isEditScreen;
  final String? title;
  final String? workoutID;
  final String? weekID;
  final String? dayID;
  final String? workoutType;
  final bool? circuitScreen;
  const CircuitWorkOutScreen(
      {Key? key,
      this.title,
      this.isEditScreen = false,
      this.weekID,
      this.workoutID,
      this.dayID,
      this.workoutType,
      this.circuitScreen = false})
      : super(key: key);

  @override
  State<CircuitWorkOutScreen> createState() => _CircuitWorkOutScreenState();
}

class _CircuitWorkOutScreenState extends State<CircuitWorkOutScreen> {
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
        title: widget.title!,
        body: BlocConsumer<CircuitWorkOutCubit, CircuitWorkOutState>(
            bloc: circuitWorkOutCubit,
            listener: (context, state) {
              if (state is ExerciseError) {
                showSnackBar(
                  context,
                  state.message!,
                  textColor: Colors.white,
                );
              } else if (state is ExerciseLoaded) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SupersetCircuitTypeDialog(
                        workoutID: widget.weekID,
                        weekID: widget.weekID,
                        dayID: widget.dayID,
                        isCircuit: widget.circuitScreen,
                        exerciseId: state.data!.id,
                      );
                    });
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
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
                          title: widget.workoutType!, isIncomeSelected: true, onSelected: (val) {}),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SalukTextField(
                      textEditingController: _titleController,
                      hintText: "",
                      labelText: "Title",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _createPostImageFiles.isEmpty
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
                        : _createPostImageFiles[0].path.contains("mp4")
                            ? VideoContainer(
                                closeButton: () {
                                  setState(() {
                                    _createPostImageFiles = [];
                                  });
                                },
                              )
                            : ImageContainer(
                                path: _createPostImageFiles[0].path,
                                onClose: () => setState(() => _createPostImageFiles = []),
                              ),
                    SizedBox(
                      height: 20,
                    ),
                    (viewType == 1)
                        ? SalukTransparentButton(
                            title: AppLocalisation.getTranslated(context, LKAdd),
                            buttonWidth: defaultSize.screenWidth,
                            borderColor: PRIMARY_COLOR,
                            buttonColor: PRIMARY_COLOR,
                            onPressed: () {
                              addSuperSetApiCall();
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
                        : const SizedBox(),
                  ],
                ),
              );
            }),
      ),
    );
  }

  addSuperSetApiCall() {
    if (_titleController.text != "") {
      if (_createPostImageFiles.isNotEmpty) {
        AddExerciseSingleWTimeRequestModel requestData = AddExerciseSingleWTimeRequestModel(
            media: _createPostImageFiles[0],
            assetType: _createPostImageFiles[0].path.contains('mp4') ? 'video' : 'image',
            workoutTitle: _titleController.text,
            restTime: '',
            workoutID: widget.workoutID!,
            weekID: widget.weekID!,
            dayID: widget.dayID!,
            description: '');

        circuitWorkOutCubit.addSupperSet(exerciseRequestModel: requestData);
      } else {
        showSnackBar(
          context,
          'Please add image or video',
          textColor: Colors.white,
        );
      }
    } else {
      showSnackBar(
        context,
        'Please enter a title of Superset',
        textColor: Colors.white,
      );
    }
  }
}
