import 'package:app/module/influencer/subscribers/view/subscribers_screen.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';


Widget roundedWidget({required BuildContext context, bool isRating = false, required String value}){
  return Expanded(
    child: GestureDetector(
      onTap: !isRating
          ? (){ navigatorKey.currentState?.pushNamed(SubscribersScreen.id); }
          : null,
      child: Stack(
        children: [
          SvgPicture.asset(
            isRating ? RATING : SUBSCRIBERS,
          ),
          Positioned(
            bottom: 2.h,
            left: 6.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // textWidget(text: value, fontWeight: FontWeight.bold, fontSize: 15.sp),
                Text(value, style: subTitleTextStyle(context)!.copyWith(
                  color: Colors.white,
                  fontSize: defaultSize.screenWidth * .048,
                ),),
                SizedBox(height: 0.3.h),
                // textWidget(text: isRating ? 'Ratings' : 'Subscribers',  fontSize: 10.sp, fontWeight: FontWeight.normal),
                Text(isRating ? AppLocalisation.getTranslated(context, LKRatings) : AppLocalisation.getTranslated(context, LKSubscribers) , style: labelTextStyle(context)!.copyWith(
                  color: Colors.white,
                  fontSize: defaultSize.screenWidth * .035,
                ),)
              ],
            ),
          )
        ],
      ),
    ),
  );
}
