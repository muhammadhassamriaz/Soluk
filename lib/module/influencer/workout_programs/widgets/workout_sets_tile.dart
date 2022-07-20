import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WorkoutSetsTile extends StatelessWidget {
  Color? titleColor;
  Color? titleDetailColor;
  String? title;
  String? titleDetail;
  var onEditPress;
  var onDeletePress;
  var onAddPress;
  bool showIcon;
  bool? showEditIcon = true;
  final double? horizontalPadding;
  WorkoutSetsTile(
      {Key? key,
      required this.titleColor,
      required this.titleDetailColor,
      required this.title,
      required this.titleDetail,
      this.onEditPress,
      this.onDeletePress,
      this.onAddPress,
      required this.showIcon,
      this.showEditIcon,
      this.horizontalPadding = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: horizontalPadding!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title!,
                style: labelTextStyle(context)?.copyWith(
                  color: titleColor ?? Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
              showIcon == false
                  ? Text(
                      titleDetail!,
                      style: labelTextStyle(context)?.copyWith(
                        color: titleDetailColor ?? Colors.grey,
                        fontSize: 12.sp,
                      ),
                    )
                  : InkWell(
                      onTap: onAddPress,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add_circle,
                            color: PRIMARY_COLOR,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "  " + AppLocalisation.getTranslated(context, LKAdd),
                            style: labelTextStyle(context)?.copyWith(
                              color: PRIMARY_COLOR,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
              showIcon == false
                  ? showEditIcon == true
                      ? InkWell(
                          onTap: onEditPress,
                          child: const Icon(
                            Icons.edit,
                            color: PRIMARY_COLOR,
                          ),
                        )
                      : SB_4W
                  : SB_4W,
              showIcon == false
                  ? showEditIcon == true
                      ? InkWell(
                          onTap: onDeletePress,
                          child: const Icon(
                            Icons.delete_outline_outlined,
                            color: RED_COLOR,
                          ),
                        )
                      : SB_4W
                  : SB_4W
            ],
          ),
        ),
      ],
    );
  }
}
