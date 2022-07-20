import 'package:app/module/user/community/view/friends/activities_view.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/res/color.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../influencer/challenges/challenge_const.dart/challenge_const.dart';

class FriendsDetailsActivityCard extends StatefulWidget {
  const FriendsDetailsActivityCard({
    Key? key,
  }) : super(key: key);

  @override
  State<FriendsDetailsActivityCard> createState() =>
      _FriendsDetailsActivityCardState();
}

class _FriendsDetailsActivityCardState
    extends State<FriendsDetailsActivityCard> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  'Activities',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: switchValue
                      ? Row(
                          children: [
                            TextView(
                              '7 days activity',
                              fontSize: 14,
                            ),
                            GestureDetector(
                              onTap: () {
                                NavRouter.push(context, ActivitiesView());
                              },
                              child: TextView(
                                ' View Activities',
                                fontSize: 14,
                                color: PRIMARY_COLOR,
                              ),
                            ),
                          ],
                        )
                      : TextView(
                          'No Activity done yet!',
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                        child: ActivitiesCounterCard(
                      count: '0',
                      text: 'Challenges',
                      countColor: PRIMARY_COLOR,
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: ActivitiesCounterCard(
                      count: '0',
                      text: 'Workout\nProgram',
                      countColor: Color(0xffFF9B70),
                    )),
                  ],
                ),
                SizedBox(height: 24),
                TextView(
                  'Badges',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: switchValue
                      ? FriendsDetailsUserBadges()
                      : TextView(
                          'No Badges win\'s yet!',
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: FittedBox(
                    child: CupertinoSwitch(
                        value: switchValue,
                        onChanged: (val) {
                          setState(() {
                            switchValue = val;
                          });
                        }),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FriendsDetailsUserBadges extends StatelessWidget {
  const FriendsDetailsUserBadges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActivityBadge(
          badgeIconPath: ChallengeConst.badges['4']!,
          badgeCount: '15',
          badgeName: ChallengeConst.title['4']!,
        ),
        ActivityBadge(
          badgeIconPath: ChallengeConst.badges['3']!,
          badgeCount: '10',
          badgeName: ChallengeConst.title['3']!,
        ),
        ActivityBadge(
          badgeIconPath: ChallengeConst.badges['2']!,
          badgeCount: '02',
          badgeName: ChallengeConst.title['2']!,
        ),
        ActivityBadge(
          badgeIconPath: ChallengeConst.badges['1']!,
          badgeCount: '10',
          badgeName: ChallengeConst.title['1']!,
        ),
      ],
    );
  }
}

class ActivityBadge extends StatelessWidget {
  const ActivityBadge({
    Key? key,
    required this.badgeIconPath,
    required this.badgeCount,
    required this.badgeName,
  }) : super(key: key);
  final String badgeIconPath;
  final String badgeCount;
  final String badgeName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          badgeIconPath,
          height: 50,
          width: 50,
        ),
        SizedBox(height: 10),
        TextView(
          badgeCount,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        TextView(
          badgeName,
          fontSize: 12,
        ),
      ],
    );
  }
}

class ActivitiesCounterCard extends StatelessWidget {
  const ActivitiesCounterCard({
    Key? key,
    required this.count,
    required this.text,
    required this.countColor,
  }) : super(key: key);

  final String count;
  final String text;
  final countColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14),
          TextView(
            count,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: countColor,
          ),
          SizedBox(height: 2),
          TextView(
            text,
            fontSize: 14,
            color: Colors.grey.withOpacity(0.8),
          ),
        ],
      ),
    );
  }
}
