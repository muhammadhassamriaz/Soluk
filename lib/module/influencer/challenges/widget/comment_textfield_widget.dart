import 'package:app/module/influencer/challenges/cubit/comments_bloc/commentsbloc_cubit.dart';
import 'package:app/module/influencer/challenges/model/comments_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';
import 'dart:math' as math;

import '../../bloc/language_bloc.dart';

class CommentTextFieldWidget extends StatefulWidget {
    final String challengeId;
  const CommentTextFieldWidget({Key? key,required this.challengeId}) : super(key: key);

  @override
  State<CommentTextFieldWidget> createState() => _CommentTextFieldWidgetState();
}

class _CommentTextFieldWidgetState extends State<CommentTextFieldWidget> {
  TextEditingController commentEditingController = TextEditingController();
  String comment = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: commentEditingController,
              cursorColor: Colors.grey,
              onChanged: (val) {
                setState(() {});
              },
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffC4C4C4),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffC4C4C4),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffC4C4C4),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffC4C4C4),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  hintStyle: TextStyle(color: Color(0xffC4C4C4), fontSize: 13),
                  hintText:
                      AppLocalisation.getTranslated(context, LKWriteComment)),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: commentEditingController.text.length > 0
                ? () {
                  BlocProvider.of<CommentsblocCubit>(context).addComment('${widget.challengeId}',commentEditingController.text);
                    commentEditingController.clear();
                  }
                : null,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 14.5)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled))
                    return Color(0xff498AEE)
                        .withOpacity(0.5); // Use the component's default.
                  return Color(0xff498AEE);
                },
              ),
            ),
            child: Transform(
              alignment: Alignment.center,
              transform: LanguageBloc.getSelectedLanguage() == 'en' ||
                      LanguageBloc.getSelectedLanguage() == ''
                  ? Matrix4.rotationX(math.pi)
                  : Matrix4.rotationY(math.pi),
              child: SvgPicture.asset('assets/svgs/ic_arrow_send.svg'),
            ),
          )
        ],
      ),
    );
  }
}
