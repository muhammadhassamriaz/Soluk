import 'package:app/res/color.dart';
import 'package:app/utils/default_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:app/res/globals.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:sizer/sizer.dart';

class WorkoutProgramTile extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback callback;
  const WorkoutProgramTile({
    Key? key,
    required this.image,
    required this.title,
    required this.callback,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DefaultSize defaultSize = DefaultSize();
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            callback();
          },
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: HEIGHT_5 * 1.5,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        color: PRIMARY_COLOR, value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Container(
                width: double.maxFinite,
                height: HEIGHT_5 * 1,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0)),
                  color: Colors.white,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: HORIZONTAL_PADDING,
                    vertical: HORIZONTAL_PADDING,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              style: hintTextStyle(context)?.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              description,
                              maxLines: 1,
                              style: hintTextStyle(context)?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SB_1H
      ],
    );
  }
}
