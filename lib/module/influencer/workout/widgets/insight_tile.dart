import 'dart:developer';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InsightTile extends StatelessWidget {
  final String image;
  final String title;
  final Function callback;
  const InsightTile({
    Key? key,
    required this.image,
    required this.title,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(image);
    return GestureDetector(
      onTap: () {
        callback();
      },
      // child: Stack(
      //   children: [
      //     SvgPicture.asset(
      //       NUTRIENT_GUIDES,
      //       alignment: Alignment.center,
      //       width: MediaQuery.of(context).size.width,
      //     ),
      //    Text('Okay', style: headingTextStyle(context),)
      //   ],
      // ),
      child: Container(
        width: double.maxFinite,
        height: HEIGHT_5 * 1.5,
        decoration: BoxDecoration(
          borderRadius: BORDER_CIRCULAR_RADIUS,
          image: image.contains("jp")
              ? DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: HORIZONTAL_PADDING,
            vertical: HORIZONTAL_PADDING,
          ),
          child: Stack(
            children: [
              if (!image.contains("jp"))
                Container(
                  width: double.maxFinite,
                  height: HEIGHT_5 * 1.5,
                  decoration: BoxDecoration(
                    borderRadius: BORDER_CIRCULAR_RADIUS * 2,
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: SvgPicture.asset(image),
                ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: subTitleTextStyle(context)?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
