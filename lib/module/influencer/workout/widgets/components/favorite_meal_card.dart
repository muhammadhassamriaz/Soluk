import 'package:app/module/influencer/workout/model/fav_meal_modal.dart' as fav;
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FavoriteMealCard extends StatelessWidget {
  final fav.Data favItem;
  final VoidCallback callback;
  const FavoriteMealCard({
    Key? key,
    required this.favItem,
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
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: double.maxFinite,
            height: HEIGHT_5 * 1.7,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: WIDTH_5 * 3.5,
                      height: HEIGHT_5 * 1.7,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                        image: DecorationImage(
                          image: NetworkImage(favItem.imageUrl!),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.white,
                      ),
                      // child: Image(
                      //   image: AssetImage(
                      //     image,
                      //   ),
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          child: Text(
                            favItem.title ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: subTitleTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        SB_BY_4,
                        item(
                            context,
                            '${favItem.calories}',
                            AppLocalisation.getTranslated(
                                context, 'LKCalories')),
                        SB_BY_4,
                        Row(
                          children: [
                            item(
                                context,
                                '${favItem.fats}',
                                AppLocalisation.getTranslated(
                                    context, 'LKFats')),
                            SB_1W,
                            item(
                                context,
                                '${favItem.proteins}',
                                AppLocalisation.getTranslated(
                                    context, 'LKProtiens')),
                            SB_1W,
                            item(
                                context,
                                '${favItem.carbs}',
                                AppLocalisation.getTranslated(
                                    context, 'LKCarbs')),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.arrow_forward_ios_outlined,
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

  item(BuildContext context, String title, String subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: subTitleTextStyle(context)?.copyWith(
              color: Colors.black,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold),
        ),
        Text(
          subTitle,
          style: subTitleTextStyle(context)?.copyWith(
            color: Colors.grey,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}
