import 'package:app/res/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RoundWorkoutTile extends StatelessWidget {
  final String image;
  final String description;
  final VoidCallback callback;
  final String exerciseType;
  final String exerciseValue;
  const RoundWorkoutTile({
    Key? key,
    required this.image,
    required this.description,
    required this.exerciseType,
    required this.exerciseValue,
    required this.callback,
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
            height: HEIGHT_5 * 1.3,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0)),
              color: Colors.grey.withOpacity(0.2),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxis,
              children: [
                Row(
                  children: [
                    Container(
                      width: WIDTH_5 * 3,
                      height: HEIGHT_5 * 1.3,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                        color: Colors.white,
                      ),
                      child: Image(
                        image: NetworkImage(
                          image,
                        ),
                        fit: BoxFit.fill,
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
                            width: defaultSize.screenWidth * 0.4,
                            child: Text(
                              description,
                              maxLines: 2,
                              style: subTitleTextStyle(context)?.copyWith(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                exerciseType,
                                style: labelTextStyle(context)?.copyWith(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                exerciseValue,
                                style: labelTextStyle(context)?.copyWith(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                ),
                              )
                            ],
                          ),
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
