import 'dart:developer';
import 'dart:io';

import 'package:app/module/influencer/challenges/widget/badge_dropdown.dart';
import 'package:app/module/influencer/subscribers/widget/subscribers_name_profile.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/fab.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/bloc/workout_program_bloc.dart';
import 'package:app/module/influencer/workout_programs/model/add_workout_week_request_model.dart';
import 'package:app/module/influencer/workout_programs/model/add_workout_week_response.dart';
import 'package:app/module/influencer/workout_programs/view/media_screen.dart';
import 'package:app/module/influencer/workout_programs/widgets/competition_badge_dropdown.dart';
import 'package:app/module/influencer/workout_programs/widgets/difficulty_level_dropdown.dart';
import 'package:app/module/influencer/workout_programs/widgets/program_type_dropdown.dart';
import 'package:app/module/influencer/workout_programs/widgets/video_player_widget.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_program_tile.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/module/influencer/workout/widgets/workout_tile.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/default_size.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../model/get_workout_all_weeks_response.dart';

class AddWorkoutWeek extends StatefulWidget {
  static const id = 'AddWorkoutWeek';
  bool? isEditScreen = false;
  final int iD;

  final Data? data;
  AddWorkoutWeek({Key? key, this.isEditScreen, required this.iD, this.data})
      : super(key: key);

  @override
  State<AddWorkoutWeek> createState() => _AddWorkoutWeekState();
}

class _AddWorkoutWeekState extends State<AddWorkoutWeek> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();

  AddWorkoutWeekResponse? addWorkoutWeekResponse;
  AddWorkoutWeekRequestModel? addWorkoutWeekRequestModel;
  late String editMedia = '1';
  @override
  void initState() {
    super.initState();
    if (widget.isEditScreen == true) {
      _titleController.text = widget.data!.title;
      _descriptionController.text = widget.data!.description;
      editMedia = '2';
    }
  }

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
      } else if (state is AddWorkoutWeekState) {
        addWorkoutWeekResponse = state.addWorkoutWeekResponse;
        showSnackBar(
          context,
          'Workout week added successfully!',
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: AppBody(
            title: AppLocalisation.getTranslated(context, LKAddWorkoutWeek),
            body: ModalProgressHUD(
              inAsyncCall: state is LoadingState,
              child: SingleChildScrollView(
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
                                          _workoutProgramBloc
                                              .add(SetStateEvent());
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          child: SvgPicture.asset(
                                              'assets/svgs/cross_icon.svg',
                                              height: 25,
                                              width: 25),
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
                                          _workoutProgramBloc
                                              .add(SetStateEvent());
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          child: SvgPicture.asset(
                                              'assets/svgs/cross_icon.svg',
                                              height: 25,
                                              width: 25),
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
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                  color: PRIMARY_COLOR,
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                            errorWidget:
                                                (context, url, error) => Center(
                                                    child: Icon(Icons.error)),
                                          ),
                                          width: defaultSize.screenWidth,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: InkWell(
                                            onTap: () {
                                              //Navigator.pop(context);

                                              editMedia = '3';
                                              _workoutProgramBloc
                                                  .add(SetStateEvent());
                                            },
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              child: SvgPicture.asset(
                                                  'assets/svgs/cross_icon.svg',
                                                  height: 25,
                                                  width: 25),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey
                                                    .withOpacity(0.1),
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
                                              _workoutProgramBloc
                                                  .add(SetStateEvent());
                                            },
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              child: SvgPicture.asset(
                                                  'assets/svgs/cross_icon.svg',
                                                  height: 25,
                                                  width: 25),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey
                                                    .withOpacity(0.1),
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
                        labelText: "Workout Week Title"),
                    SB_1H,
                    SalukTextField(
                        textEditingController: _descriptionController,
                        maxLines: 6,
                        hintText: "",
                        labelText: "Description"),
                    SizedBox(
                      height: defaultSize.screenHeight * 0.2,
                    ),
                    SalukGradientButton(
                      title: AppLocalisation.getTranslated(context, LKSubmit),
                      onPressed: () async {
                        if (_createPostImageFiles.isNotEmpty) {
                          if (_titleController.text != '') {
                            if (_descriptionController.text != '') {
                              addWorkoutWeekRequestModel =
                                  AddWorkoutWeekRequestModel(
                                      media: _createPostImageFiles[0],
                                      assetType: _createPostImageFiles[0]
                                              .path
                                              .contains('mp4')
                                          ? 'video'
                                          : 'image',
                                      workoutTitle: _titleController.text,
                                      description: _descriptionController.text,
                                      workoutID: widget.iD);

                              _workoutProgramBloc.add(AddWorkoutWeekEvent(
                                  addWorkoutWeekRequestModel:
                                      addWorkoutWeekRequestModel!));
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
                      },
                      buttonHeight: HEIGHT_4,
                      dim: false,
                    ),
                    SB_1H,
                  ],
                ),
              ),
            )),
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
