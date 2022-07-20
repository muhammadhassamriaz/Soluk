import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget infoWidget(BuildContext context, {bool isPublished = false, required String type, required String value}){
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(value, style: headingTextStyle(context)!.copyWith(
        fontSize: 15.6.sp
      ),),
      SizedBox(height: 1.4.h,),
      Text(type, style: labelTextStyle(context)!.copyWith(
        color: const Color(0xFFa4a2aa),
        fontSize: 9.3.sp
      ),),
      SizedBox(height: 2.h,),
      Container(
        height: 2.23.h,
        width: 2.23.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [
              0.1,
              0.9,
            ],
            colors: [
              isPublished ? const Color(0xFFce9ffc) : const Color(0xFFffe985),
              isPublished ? const Color(0xFF7367f0) : const Color(0xFFfa742b),
            ],
          )
        ),
      )
    ],
  );
}