import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MainWorkoutProgramTile extends StatelessWidget {
  final String image;
  final String mediaType;
  final String title;
  final String details;
  final String numberOfViews;
  final String ratting;
  final VoidCallback callback;
  const MainWorkoutProgramTile({
    Key? key,
    required this.image,
    required this.mediaType,
    required this.title,
    required this.details,
    required this.callback,
    required this.numberOfViews,
    required this.ratting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            callback();
          },
          child: Container(
            width: double.maxFinite,
            height: HEIGHT_5 * 1.5,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxis,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                        width: WIDTH_5 * 3,
                        height: HEIGHT_5 * 1.5,
                        imageUrl: image,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              color: PRIMARY_COLOR, value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: defaultSize.screenWidth * 0.42,
                            child: Text(
                              title,
                              maxLines: 2,
                              style: subTitleTextStyle(context)?.copyWith(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Text(
                            details,
                            maxLines: 1,
                            style: labelTextStyle(context)?.copyWith(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.remove_red_eye_rounded,
                                    color: PRIMARY_COLOR,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    numberOfViews,
                                    maxLines: 1,
                                    style: labelTextStyle(context)?.copyWith(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SB_2W,
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_outlined,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    ratting,
                                    maxLines: 1,
                                    style: labelTextStyle(context)?.copyWith(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SB_1H
      ],
    );
  }
}
