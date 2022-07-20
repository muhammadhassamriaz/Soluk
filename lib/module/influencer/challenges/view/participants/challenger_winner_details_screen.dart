import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../services/localisation.dart';
import '../../widget/challenger_widgets/reward_widget.dart';

class ParticipantsByCommunityDetailsScreen extends StatelessWidget {
  static const String id = "/challenger_detail";
  final bool hasWonTheReward;

  const ParticipantsByCommunityDetailsScreen({Key? key, this.hasWonTheReward = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF3F3F3),
        body: AppBody(
          title: "",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: CircleProfileAvatar()),
              const SizedBox(height: 2),
              Center(
                child: Text(
                  'Alex Deo',
                  style: subTitleTextStyle(context)
                      ?.copyWith(fontSize: defaultSize.screenWidth * .046),
                ),
              ),
              SB_1H,
              Text(
                '100 Pushups',
                style: subTitleTextStyle(context)
                    ?.copyWith(fontSize: defaultSize.screenWidth * .042),
              ),
              const SizedBox(height: 10),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Elementum pellentesque nunc, habitasse semper elementum dolor leo sit ipsum.',
                style: labelTextStyle(context)?.copyWith(
                  fontSize: defaultSize.screenWidth * .035,
                ),
              ),
              SB_1H,
              Container(
                height: HEIGHT_5 * 1.7,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BORDER_CIRCULAR_RADIUS,
                  image: const DecorationImage(
                    image: AssetImage(
                      WORKOUT_COVER2,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Icon(
                  Icons.play_circle,
                  color: Colors.white,
                  size: defaultSize.screenWidth * .1,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                  AppLocalisation.getTranslated(context, LKSubmittedOn),
                        style: subTitleTextStyle(context)?.copyWith(
                            fontSize: defaultSize.screenWidth * .034),
                      ),
                      Text(
                        '21 Feb, 11: 30 am',
                        style: hintTextStyle(context)?.copyWith(
                            fontSize: defaultSize.screenWidth * .034),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: 3.5,
                            itemBuilder: (context, index) => Icon(
                              Icons.star_rounded,
                              color: Color(0xff498AEE),
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(width: 6),
                          Text(
                            '3.5',
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                          AppLocalisation.getTranslated(context, LKRating),

                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (hasWonTheReward) const RewardWidget()
            ],
          ),
        ));
  }
}
