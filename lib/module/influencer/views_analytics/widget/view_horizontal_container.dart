import 'package:app/module/influencer/income_analytics/widget/total_income_sub_widget.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget viewHorizontalContainer(BuildContext context, {bool isExpansion = false, required String title, required String views}){
  return SizedBox(
    width: 70.w,
    child: Padding(
      padding: EdgeInsets.only(top: isExpansion ? 0.0 : 2.98.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isExpansion ? const SizedBox() : Text(title, style: headingTextStyle(context)!.copyWith(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20
          ),),
          Container(
            height: isExpansion ? 8.69.h : 14.53.h,
            width: isExpansion ? 8.69.h : 14.53.h,
            margin: EdgeInsets.only(top: isExpansion ? 0.0 : 1.49.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: totalIncomeSubWidget(context, value: views, title: AppLocalisation.getTranslated(context, LKTotalViews)),
          )
        ],
      ),
    ),
  );
}