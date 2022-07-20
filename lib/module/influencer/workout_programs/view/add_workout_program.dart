import 'dart:developer';
import 'dart:io';

import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/bloc/workout_program_bloc.dart';
import 'package:app/module/influencer/workout_programs/model/AddWorkoutPlanRequestModel.dart';
import 'package:app/module/influencer/workout_programs/model/add_workout_plan_response.dart';
import 'package:app/module/influencer/workout_programs/model/update_workout_program_response.dart';
import 'package:app/module/influencer/workout_programs/model/workout_prerequisites_response.dart';
import 'package:app/module/influencer/workout_programs/widgets/competition_badge_dropdown.dart';
import 'package:app/module/influencer/workout_programs/widgets/difficulty_level_dropdown.dart';
import 'package:app/module/influencer/workout_programs/widgets/program_type_dropdown.dart';
import 'package:app/module/influencer/workout_programs/widgets/video_player_widget.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/get_workout_plan_response.dart';

class AddWorkoutProgram extends StatefulWidget {
  static const id = 'AddWorkoutProgramScreen';
  bool? isEditScreen = false;

  final Data? data;
  AddWorkoutProgram({Key? key, this.isEditScreen, this.data}) : super(key: key);

  @override
  State<AddWorkoutProgram> createState() => _AddWorkoutProgramState();
}

class _AddWorkoutProgramState extends State<AddWorkoutProgram> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();

  late String selectedDifficultyLevelValue = 'Select Difficulty';
  late String selectedTypeValue = '';
  late String selectedCompletionBadgeValueID = '';
  late String selectedCompletionBadgeValue = '';
  late String editMedia = '1';

  WorkoutPrerequisitesListResponse? workoutPrerequisitesListResponse;

  AddWorkoutPlanRequestModel? addWorkoutPlanRequestModel;
  AddWorkoutPlanResponse? addWorkoutPlanResponse;

  UpdateWorkoutProgramResponse? updateWorkoutProgramResponse;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
    _workoutProgramBloc.add(WorkoutPrerequisitesLoadedEvent());
    return BlocConsumer<WorkoutProgramBloc, WorkoutProgramState>(listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is SetStateState) {
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
      } else if (state is WorkoutPrerequisitesLoadedState) {
        workoutPrerequisitesListResponse = state.workoutPrerequisitesListResponse;
        if (widget.isEditScreen == true) {
          _titleController.text = widget.data!.title;
          _descriptionController.text = widget.data!.description;
          selectedDifficultyLevelValue = widget.data!.difficultyLevel;
          print("selected difficult level : $selectedDifficultyLevelValue");
          selectedTypeValue = widget.data!.programType;
          editMedia = '2';
          for (int i = 0;
              i < workoutPrerequisitesListResponse!.responseDetails.completionBadge.length;
              i++) {
            if (widget.data!.completionBadge ==
                workoutPrerequisitesListResponse!.responseDetails.completionBadge[i].badgeId
                    .toString()) {
              selectedCompletionBadgeValue =
                  workoutPrerequisitesListResponse!.responseDetails.completionBadge[i].title;
              selectedCompletionBadgeValueID = widget.data!.completionBadge;
              print(selectedCompletionBadgeValue);
              break;
            }
          }
        }

        //workoutPrerequisitesListResponse!.responseDetails.completionBadge.add(value)
      } else if (state is AddWorkoutProgramState) {
        addWorkoutPlanResponse = state.addWorkoutPlanResponse;
        showSnackBar(
          context,
          addWorkoutPlanResponse!.responseDescription,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Navigator.pop(context);
      } else if (state is UpdateWorkoutProgramState) {
        updateWorkoutProgramResponse = state.updateWorkoutProgramResponse;
        showSnackBar(
          context,
          updateWorkoutProgramResponse!.responseDescription,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
            body: AppBody(
                title: AppLocalisation.getTranslated(context, LKAddWorkoutProgram),
                body: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DottedContainer(
                        callback: () {
                          _pickImagesFromGallery();
                        },
                        child: _createPostImageFiles.isNotEmpty
                            ? _createPostImageFiles[0].path.contains('mp4')
                                ? Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        child: VideoPlayerWidget(
                                          url: '',
                                          file: _createPostImageFiles[0],
                                          mediaTypeisLocalVideo: true,
                                        ),
                                        width: defaultSize.screenWidth,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: InkWell(
                                          onTap: () {
                                            //Navigator.pop(context);

                                            _createPostImageFiles.clear();
                                            _workoutProgramBloc.add(SetStateEvent());
                                          },
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            child: SvgPicture.asset('assets/svgs/cross_icon.svg',
                                                height: 25, width: 25),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.withOpacity(0.1),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        child: Image.file(
                                          _createPostImageFiles[0],
                                          fit: BoxFit.cover,
                                        ),
                                        width: defaultSize.screenWidth,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: InkWell(
                                          onTap: () {
                                            //Navigator.pop(context);

                                            _createPostImageFiles.clear();
                                            _workoutProgramBloc.add(SetStateEvent());
                                          },
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            child: SvgPicture.asset('assets/svgs/cross_icon.svg',
                                                height: 25, width: 25),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.withOpacity(0.1),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                            : editMedia == '2'
                                ? widget.data!.assetType == 'Image'
                                    ? Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            child: CachedNetworkImage(
                                              imageUrl: widget.data!.assetUrl,
                                              fit: BoxFit.fill,
                                              progressIndicatorBuilder:
                                                  (context, url, downloadProgress) => Center(
                                                child: CircularProgressIndicator(
                                                    color: PRIMARY_COLOR,
                                                    value: downloadProgress.progress),
                                              ),
                                              errorWidget: (context, url, error) =>
                                                  Center(child: Icon(Icons.error)),
                                            ),
                                            width: defaultSize.screenWidth,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: InkWell(
                                              onTap: () {
                                                //Navigator.pop(context);

                                                editMedia = '3';
                                                _workoutProgramBloc.add(SetStateEvent());
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                child: SvgPicture.asset(
                                                    'assets/svgs/cross_icon.svg',
                                                    height: 25,
                                                    width: 25),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            child: VideoPlayerWidget(
                                              url: widget.data!.assetUrl,
                                              mediaTypeisLocalVideo: false,
                                            ),
                                            width: defaultSize.screenWidth,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: InkWell(
                                              onTap: () {
                                                //Navigator.pop(context);

                                                editMedia = '3';
                                                _workoutProgramBloc.add(SetStateEvent());
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                child: SvgPicture.asset(
                                                    'assets/svgs/cross_icon.svg',
                                                    height: 25,
                                                    width: 25),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                : null,
                      ),
                      SB_1H,
                      SalukTextField(
                        textEditingController: _titleController,
                        hintText: "",
                        labelText: AppLocalisation.getTranslated(context, LKWorkoutTitle),
                      ),
                      SB_1H,
                      Row(
                        children: [
                          DifficultyLevelDropDown(
                            itemsList: [
                              'Select Difficulty',
                              'Easy',
                              'Medium',
                              'Intermediate',
                              'Hard',
                              'Expert'
                            ],
                            defaultValue: selectedDifficultyLevelValue != ''
                                ? selectedDifficultyLevelValue
                                : 'Select Difficulty',
                            dropdownHint: selectedDifficultyLevelValue != ''
                                ? selectedDifficultyLevelValue
                                : 'Select Difficulty',
                            onChanged: (value) {
                              selectedDifficultyLevelValue = value;
                            },
                          ),
                          const Spacer(),
                          ProgramTypeDropDown(
                            itemsList: const ["Select Type", "Free", "Paid"],
                            defaultValue:
                                selectedTypeValue != '' ? selectedTypeValue : 'Select Type',
                            dropdownHint:
                                selectedTypeValue != '' ? selectedTypeValue : 'Select Type',
                            onChanged: (value) {
                              selectedTypeValue = value;
                            },
                          ),
                        ],
                      ),
                      SB_1H,
                      workoutPrerequisitesListResponse != null
                          ? CompetitionBadgeDropDown(
                              itemsList:
                                  workoutPrerequisitesListResponse!.responseDetails.completionBadge,
                              defaultValue: selectedCompletionBadgeValueID != ''
                                  ? selectedCompletionBadgeValue
                                  : 'Select Completion Badge',
                              dropdownHint: selectedCompletionBadgeValueID != ''
                                  ? selectedCompletionBadgeValue
                                  : 'Select Completion Badge',
                              onChanged: (value) {
                                selectedCompletionBadgeValueID = value.badgeId.toString();
                                print(selectedCompletionBadgeValueID);
                              },
                            )
                          : SizedBox(),
                      SB_1H,
                      SalukTextField(
                        textEditingController: _descriptionController,
                        maxLines: 6,
                        hintText: "",
                        labelText: AppLocalisation.getTranslated(context, LKDescription),
                      ),
                      SB_1H,
                      SalukGradientButton(
                        title: AppLocalisation.getTranslated(context, LKSubmit),
                        onPressed: () async {
                          if (widget.isEditScreen == false) {
                            if (_createPostImageFiles.isNotEmpty) {
                              if (_titleController.text != '') {
                                if (selectedDifficultyLevelValue != '' &&
                                    selectedDifficultyLevelValue != 'Select Difficulty') {
                                  if (selectedTypeValue != '' &&
                                      selectedTypeValue != 'Select Type') {
                                    if (selectedCompletionBadgeValueID != '') {
                                      if (_descriptionController.text != '') {
                                        addWorkoutPlanRequestModel = AddWorkoutPlanRequestModel(
                                            media: _createPostImageFiles[0],
                                            assetType: _createPostImageFiles[0].path.contains('mp4')
                                                ? 'video'
                                                : 'image',
                                            workoutTitle: _titleController.text,
                                            difficultyLevel: selectedDifficultyLevelValue,
                                            programType: selectedTypeValue,
                                            completionBadgeId: selectedCompletionBadgeValueID,
                                            description: _descriptionController.text,
                                            isEditing: false);

                                        _workoutProgramBloc.add(AddWorkoutProgramEvent(
                                            addWorkoutPlanRequestModel:
                                                addWorkoutPlanRequestModel!));
                                      } else {
                                        showSnackBar(
                                          context,
                                          'Please enter workout plan description',
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                        );
                                      }
                                    } else {
                                      showSnackBar(
                                        context,
                                        'Please select completetion badge',
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                      );
                                    }
                                  } else {
                                    showSnackBar(
                                      context,
                                      'Please select workout type',
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                    );
                                  }
                                } else {
                                  showSnackBar(
                                    context,
                                    'Please select difficulty level',
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                }
                              } else {
                                showSnackBar(
                                  context,
                                  'Please enter a title of Program',
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                );
                              }
                            } else {
                              showSnackBar(
                                context,
                                'Please select a media file (Photo or Video)',
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              );
                            }
                          } else {
                            if (_titleController.text != '') {
                              if (selectedDifficultyLevelValue != '' &&
                                  selectedDifficultyLevelValue != 'Select Difficulty') {
                                if (selectedTypeValue != '' && selectedTypeValue != 'Select Type') {
                                  if (selectedCompletionBadgeValueID != '') {
                                    if (_descriptionController.text != '') {
                                      addWorkoutPlanRequestModel = AddWorkoutPlanRequestModel(
                                          media: _createPostImageFiles.isNotEmpty
                                              ? _createPostImageFiles[0]
                                              : null,
                                          assetType: _createPostImageFiles.isNotEmpty
                                              ? _createPostImageFiles[0].path.contains('mp4')
                                                  ? 'video'
                                                  : 'image'
                                              : null,
                                          workoutTitle: _titleController.text,
                                          difficultyLevel: selectedDifficultyLevelValue,
                                          programType: selectedTypeValue,
                                          completionBadgeId: selectedCompletionBadgeValueID,
                                          description: _descriptionController.text,
                                          isEditing: true,
                                          workoutProgramID: widget.data!.id);

                                      _workoutProgramBloc.add(AddWorkoutProgramEvent(
                                          addWorkoutPlanRequestModel: addWorkoutPlanRequestModel!));
                                    } else {
                                      showSnackBar(
                                        context,
                                        'Please enter workout plan description',
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                      );
                                    }
                                  } else {
                                    showSnackBar(
                                      context,
                                      'Please select completetion badge',
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                    );
                                  }
                                } else {
                                  showSnackBar(
                                    context,
                                    'Please select workout type',
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                }
                              } else {
                                showSnackBar(
                                  context,
                                  'Please select difficulty level',
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                );
                              }
                            } else {
                              showSnackBar(
                                context,
                                'Please enter a title of Program',
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              );
                            }
                          }
                        },
                        buttonHeight: HEIGHT_4,
                        dim: false,
                      ),
                      SB_1H,
                    ],
                  ),
                ))),
      );
    });
  }

  List<File> _createPostImageFiles = [];

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
}
