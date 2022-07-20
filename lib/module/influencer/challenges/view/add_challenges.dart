import 'dart:developer';
import 'dart:io';

import 'package:app/module/influencer/challenges/cubit/challenges_bloc/challengesbloc_cubit.dart';
import 'package:app/module/influencer/challenges/model/badges_modal.dart';
import 'package:app/module/influencer/challenges/widget/badge_dropdown.dart';
import 'package:app/module/influencer/challenges/widget/soluk_date_time.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/res/globals.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';
import '../widget/choose_winner_dropdown.dart';

class AddChallenges extends StatefulWidget {
  static const String id = "/add_challenges";

  const AddChallenges({Key? key}) : super(key: key);

  @override
  State<AddChallenges> createState() => _AddChallengesState();
}

class _AddChallengesState extends State<AddChallenges> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();
  String date = "";
  String time = "";
  CompletionBadge? badge;
  String? winner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(alignment: Alignment.bottomCenter, children: [
        AppBody(
          title: AppLocalisation.getTranslated(context, LKAddChallenges),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: _createPostImageFiles.isNotEmpty
                      ? Container(
                          height: HEIGHT_5 * 2,
                          width: double.maxFinite,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              _createPostImageFiles[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : DottedContainer(
                          callback: () {
                            _pickImagesFromGallery();
                          },
                        ),
                ),
                SB_1H,
                SalukTextField(
                  textEditingController: _titleController,
                  hintText: "",
                  labelText:
                      AppLocalisation.getTranslated(context, LKAddChallenge),
                ),
                SB_1H,
                BadgeDropDown(onValueChange: (value) => badge = value),
                SB_1H,
                ChooseWinnerDropDown(onValueChange: (value) => winner = value),
                SB_1H,
                SolukDateTime(
                    onDateChange: (value) => date = value,
                    onTimeChange: (value) => time = value),
                SB_1H,
                SalukTextField(
                  textEditingController: _descriptionController,
                  hintText:
                      AppLocalisation.getTranslated(context, LKDescription),
                  labelText: "",
                  maxLines: 8,
                ),
                SB_5H,
                SB_5H,
              ],
            ),
          ),
          // ),
          // ],
          // ),

          // )
        )
      ]),
      bottomNavigationBar: BottomAppBar(
        child: SalukBottomButton(
          title: AppLocalisation.getTranslated(context, LKSubmit),
          isButtonDisabled: false,
          callback: () async {
            Map<String, String> temp = {
              "badge": "${badge!.badgeId}",
              "title": _titleController.text,
              "description": _descriptionController.text,
              "expiryDateTime": "$date $time",
              "assetType": "Image",
              'winnerBy': winner!
            };
            print(temp);
            bool res = await BlocProvider.of<ChallengesblocCubit>(context)
                .addChallenge(temp, ['imageVideoURL'], [_createPostImageFiles.first.path]);
            if (res) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
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
