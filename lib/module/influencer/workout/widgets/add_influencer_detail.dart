import 'dart:convert';
import 'dart:io';

import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout/bloc/about_me_bloc/aboutmebloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/tags/tags_bloc.dart';
import 'package:app/module/influencer/workout/bloc/tags_bloc/tagsbloc_cubit.dart';
import 'package:app/module/influencer/workout/hive/classes/about.dart';
import 'package:app/module/influencer/workout/hive/local/my_hive.dart';
import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/module/influencer/workout/model/tags.dart';
import 'package:app/module/influencer/workout/view/video_play_screen.dart';
import 'package:app/module/influencer/workout/widgets/add_tags_dialog.dart';
import 'package:app/module/influencer/workout/widgets/add_tags_transparent_button.dart';
import 'package:app/module/influencer/workout/widgets/tag.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:better_player/better_player.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:video_compress/video_compress.dart';
// import 'package:video_player/video_player.dart';

class AddInfluencerDetail extends StatefulWidget {
  final GetInfluencerModel? influencerInfo;

  const AddInfluencerDetail({Key? key, this.influencerInfo}) : super(key: key);

  @override
  State<AddInfluencerDetail> createState() => _AddInfluencerDetailState();
}

class _AddInfluencerDetailState extends State<AddInfluencerDetail> {
  final TextEditingController _titleController = TextEditingController(),
      _introController = TextEditingController(),
      _goalsController = TextEditingController(),
      _credentialsController = TextEditingController(),
      _requirementController = TextEditingController();
  int index = 100;
  XFile? _imageFile;
  String? _imagePath;
  // VideoPlayerController? _videoController;
  XFile? _video;
  String? _videoPath;
  // final AboutMeInfo? _hiveInfo = MyHive.getAboutInfo();
  MediaInfo? _mediaInfo;
  bool _isLoading = false;
  // XFile? pickedFile;
  List<Tags> tags = [];
  selectedTags(List<Data> list, List<int> selectedIdsList) {
    tags.clear();
    List<Data> selectedList =
        list.where((element) => selectedIdsList.contains(element.id)).toList();
    for (var item in selectedList) {
      tags.add(Tags(id: item.id, name: item.name));
    }
    print(tags.length);
    setState(() {});
  }

  _setProfilePicture({required ImageSource source}) async {
    final ImagePicker _picker = ImagePicker();
    try {
      _imageFile = await _picker.pickImage(source: source);
      if (_imageFile != null) {
        setState(() {
          // _imageFile = pickedFile!;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _selectIntroVideo({required ImageSource source}) async {
    final ImagePicker _picker = ImagePicker();
    _video = await _picker.pickVideo(source: source);
    // _videoController = VideoPlayerController.file(File(_video!.path))..initialize().then((_) {
    //   setState(() {
    //     _videoController!.play();
    //   });
    // });
    if (_video != null) {
      setState(() {
        _isLoading = true;
      });
      _mediaInfo = await VideoCompress.compressVideo(
        _video!.path,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false, // It's false by default
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    if (widget.influencerInfo != null) {
      _titleController.text =
          widget.influencerInfo?.responseDetails?.workTitle ?? '';
      _introController.text =
          widget.influencerInfo?.responseDetails?.intro ?? '';
      _goalsController.text =
          widget.influencerInfo?.responseDetails?.goals ?? '';
      _credentialsController.text =
          widget.influencerInfo?.responseDetails?.credentials ?? '';
      _requirementController.text =
          widget.influencerInfo?.responseDetails?.requirements ?? '';
      tags = widget.influencerInfo?.responseDetails?.tags ?? [];
      _imagePath = widget.influencerInfo?.responseDetails?.imageUrl ?? null;
      print(_imagePath);
      print('////////////////rrrrrrrrrrrrrrrrrr');
      _videoPath = widget.influencerInfo?.responseDetails?.introUrl ?? null;
      // _imagePath = '';
      // _video = XFile('Video');
      // _video = XFile('MyHive(Video)');
      // _videoController = VideoPlayerController.file(File(_hiveInfo!.introVideo!))..initialize().then((_) {
      //   setState(() {
      //     _videoController!.play();
      //   });
      // });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _tagsBloc = BlocProvider.of<TagsblocCubit>(context);
    // _tagsBloc.add(LoadingEvent());
    // print(_tagsBloc.state.tagsModel?.responseDetails?.data ?? []);
    // print('?????????????????????4444444444');
    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, 'LKAboutMe'),
        body: BlocBuilder<AboutmeblocCubit, AboutmeblocState>(
          builder: (context, state) {
            if (state is AboutmeblocInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }

            if (state is InfluencerDataLoaded) {
              //         _titleController.text =
              //     state.influencerModel?.responseDetails?.workTitle ?? '';
              // _introController.text =
              //      state.influencerModel?.responseDetails?.intro ?? '';
              // _goalsController.text =
              //     state.influencerModel?.responseDetails?.goals ?? '';
              // _credentialsController.text =
              //     state.influencerModel?.responseDetails?.credentials ?? '';
              // _requirementController.text =
              //     state.influencerModel?.responseDetails?.requirements ?? '';
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            height: HEIGHT_5 + defaultSize.screenHeight * .02,
                            width: HEIGHT_5,
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    popUpAlertDialog(
                                      context,
                                      AppLocalisation.getTranslated(
                                          context, 'LKProfileImage'),
                                      LKProfileDetail,
                                      isProfile: true,
                                      onCameraTap: () {
                                        _setProfilePicture(
                                            source: ImageSource.camera);
                                      },
                                      onGalleryTap: () {
                                        _setProfilePicture(
                                            source: ImageSource.gallery);
                                      },
                                    );
                                  },
                                  child: Container(
                                      height: HEIGHT_5,
                                      width: HEIGHT_5,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[300],
                                      ),
                                      child: _imageFile != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image(
                                                  fit: BoxFit.cover,
                                                  image: FileImage(
                                                      File(_imageFile!.path))),
                                            )
                                          : (_imagePath == null)
                                              ? Icon(
                                                  Icons.person,
                                                  size: HEIGHT_3,
                                                  color: Colors.grey[400],
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          _imagePath ?? '')),
                                                )),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: HEIGHT_2 -
                                        defaultSize.screenHeight * .01,
                                    width: HEIGHT_2 -
                                        defaultSize.screenHeight * .01,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: PRIMARY_COLOR,
                                    ),
                                    child: Icon(
                                      Icons.camera_enhance,
                                      size: WIDTH_1 +
                                          defaultSize.screenWidth * .01,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SB_2H,
                        InkWell(
                          onTap: () {
                            popUpAlertDialog(
                              context,
                              AppLocalisation.getTranslated(
                                  context, 'LKUploadPreviewVd'),
                              LKProfileDetail,
                              onCameraTap: () {
                                _selectIntroVideo(source: ImageSource.camera);
                              },
                              onGalleryTap: () {
                                _selectIntroVideo(source: ImageSource.gallery);
                              },
                            );
                          },
                          child: Container(
                            height: HEIGHT_5 + HEIGHT_5,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.blue[100]?.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(WIDTH_3),
                            ),
                            child: _isLoading
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator(
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text('Compressing Video ...')
                                    ],
                                  )
                                : (_videoPath != null ||
                                        (_mediaInfo?.path ?? null) != null)
                                    ? Padding(
                                        padding: EdgeInsets.only(bottom: 2.h),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _videoPath = null;
                                                  _mediaInfo = null;
                                                });
                                              },
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 1.h, right: 2.w),
                                                  child: CircleAvatar(
                                                      radius: 12,
                                                      backgroundColor:
                                                          const Color(
                                                              0xFFe7e7e7),
                                                      child: Image(
                                                        height: 2.h,
                                                        image: const AssetImage(
                                                            CLOSE),
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Click to watch Intro Video',
                                                    style: subTitleTextStyle(
                                                            context)!
                                                        .copyWith(
                                                            fontSize: defaultSize
                                                                    .screenWidth *
                                                                .05),
                                                  ),
                                                  SizedBox(
                                                    height: 1.5.h,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VideoPlayScreen(
                                                                    videoPath: _mediaInfo
                                                                            ?.path ??
                                                                        _videoPath!,
                                                                  )));
                                                    },
                                                    child: Icon(
                                                      Icons.play_circle_fill,
                                                      color: Colors.grey,
                                                      size: 5.h,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : DottedBorder(
                                        radius: Radius.circular(WIDTH_3),
                                        dashPattern: const [5, 5],
                                        color: PRIMARY_COLOR,
                                        borderType: BorderType.RRect,
                                        child: Container(
                                          height: HEIGHT_5 + HEIGHT_5,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            color: Colors.blue[100]
                                                ?.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(WIDTH_3),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.image,
                                                size: WIDTH_5 + WIDTH_1,
                                                color: PRIMARY_COLOR,
                                              ),
                                              Text(
                                                "Upload\nPreview Video",
                                                textAlign: TextAlign.center,
                                                style: labelTextStyle(context)
                                                    ?.copyWith(
                                                        fontSize: defaultSize
                                                                .screenWidth *
                                                            .03),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                          ),
                        ),
                        SB_1H,
                        SalukTextField(
                          textEditingController: _titleController,
                          hintText: "",
                          labelText: "Add your workout title",
                        ),
                        SB_1H,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Tags",
                              style: subTitleTextStyle(context)!.copyWith(
                                fontSize: defaultSize.screenWidth * .05,
                              ),
                            ),
                            Container(
                              width: defaultSize.screenWidth * .08,
                              height: defaultSize.screenWidth * .08,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                onTap: () {
                                  addTagsDialog(
                                      context, _tagsBloc.state.tagsModel,
                                      selectedTags: (val) {
                                    print(val);

                                    selectedTags(
                                        _tagsBloc.state.tagsModel
                                                ?.responseDetails?.data ??
                                            [],
                                        val);
                                    // setState(() {
                                    //   _selectedTags = val;
                                    // });
                                  });
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.edit,
                                    size: 2.2.h,
                                    color: PRIMARY_COLOR,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: WIDTH_1,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                          style: labelTextStyle(context)!
                              .copyWith(color: const Color(0xFFa4a2aa)),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: List.generate(
                            tags.length,
                            (index) {
                              return Tag(
                                  text: tags[index].name ?? '',
                                  callback: () {
                                    addTagsDialog(
                                        context, _tagsBloc.state.tagsModel,
                                        selectedTags: (val) {
                                      print(val);
                                      selectedTags(
                                          _tagsBloc.state.tagsModel
                                                  ?.responseDetails?.data ??
                                              [],
                                          val);
                                    });
                                  });
                            },
                          ),
                        ),
                        SB_Half,
                        SizedBox(
                          height: defaultSize.screenHeight * .015,
                        ),
                        SalukTextField(
                          textEditingController: _introController,
                          hintText: "A Brief Intro",
                          labelText: "A Brief Intro",
                          maxLines: 6,
                        ),
                        SB_Half,
                        SizedBox(
                          height: defaultSize.screenHeight * .015,
                        ),
                        SalukTextField(
                          textEditingController: _goalsController,
                          hintText: "Add your goals",
                          labelText: "Add your goals",
                          maxLines: 6,
                        ),
                        SB_Half,
                        SizedBox(
                          height: defaultSize.screenHeight * .015,
                        ),
                        SalukTextField(
                          textEditingController: _credentialsController,
                          hintText: "Add credentials",
                          labelText: "Add credentials",
                          maxLines: 6,
                        ),
                        SB_Half,
                        SizedBox(
                          height: defaultSize.screenHeight * .015,
                        ),
                        SalukTextField(
                          textEditingController: _requirementController,
                          hintText: "Add requirements",
                          labelText: "Add requirements",
                          maxLines: 6,
                        ),
                        SB_3H,
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: StreamBuilder<ProgressFile>(
                              stream: BlocProvider.of<AboutmeblocCubit>(context)
                                  .progressStream,
                              builder: (context, snapshot) {
                                return SalukGradientButton(
                                  title: (snapshot.data?.done ?? 0) != 0
                                      ? '${(((snapshot.data?.done ?? 1) / (snapshot.data?.total ?? 1)) * 100).toInt()} % '
                                      : widget.influencerInfo == null
                                          ? 'Save'
                                          : 'Update',
                                  onPressed: () async {
                                    Map<String, String> body = {
                                      'workTitle': _titleController.text,
                                      'intro': _introController.text,
                                      'goals': _goalsController.text,
                                      'credentials':
                                          _credentialsController.text,
                                      'requirements':
                                          _requirementController.text,
                                      'assetType': 'video'
                                    };

                                    for (var i = 0; i < tags.length; i++) {
                                      body['tag_Ids[$i][tag_id]'] =
                                          "${tags[i].id}";
                                    }
                                    print(body);
                                    List<String> paths = [];
                                    List<String> fields = [];
                                    if (_imageFile != null) {
                                      fields.add('imageURL');
                                      paths.add(_imageFile!.path);
                                    }
                                    if (_mediaInfo != null) {
                                      fields.add('introUrl');
                                      paths.add(_mediaInfo!.path!);
                                    }
                                    bool res =
                                        await BlocProvider.of<AboutmeblocCubit>(
                                                context)
                                            .addInfluencerData(
                                                context, body, fields, paths);
                                    if (res) Navigator.pop(context, 1);
                                  },
                                  // dim: ((_imageFile == null  && _imagePath == null) || _titleController.text.isEmpty || _introController.text.isEmpty || _goalsController.text.isEmpty || _credentialsController.text.isEmpty || _requirementController.text.isEmpty ) ? true :  false,
                                  dim: false,
                                  buttonHeight: 6.5.h,
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  // Future addInfluencer(
  //     String endPoint,
  //     Map<String, dynamic> body,
  //     BuildContext context,
  //     String fileKeyword,
  //     ) async {
  //   ApiResponse apiResponse = await sl.get<WebServiceImp>().addVideoPicture(
  //     endPoint: endPoint,
  //     body: body,
  //     files: body[fileKeyword],
  //     fileKeyword: fileKeyword,
  //   );
  //   var response = jsonDecode(apiResponse.data);
  //
  //   if (response != null && response["responseCode"] == SUCCESS) {
  //     try {
  //       showSnackBar(context, "Successfully Added!",
  //           backgroundColor: Colors.black);
  //       Navigator.pop(context);
  //     } catch (e) {
  //       rethrow;
  //     }
  //   } else {
  //     showSnackBar(context, "Failed to upload.");
  //   }
  // }
}
