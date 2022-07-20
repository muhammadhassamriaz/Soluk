import 'package:app/module/influencer/challenges/challenge_const.dart/challenge_const.dart';
import 'package:app/module/influencer/challenges/model/challenges_details_modals.dart';
import 'package:app/module/influencer/challenges/view/participants/participants_by_influencer_screen.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../res/constants.dart';
import '../../../../res/globals.dart';
import '../../../../services/localisation.dart';
import '../view/participants/participants_by_community_screen.dart';

class ParticipantsAndRewardWidget extends StatelessWidget {
  final Data detail;
  const ParticipantsAndRewardWidget({Key? key, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalisation.getTranslated(context, LKParticipants8Submitted),
              style: subTitleTextStyle(context)
                  ?.copyWith(fontSize: defaultSize.screenWidth * .040),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                NavRouter.push(context, const ParticipantsByInfluencerScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 16),
                child: Text(
                  AppLocalisation.getTranslated(context, LKViewParticipants),
                  style: labelTextStyle(context)?.copyWith(
                      fontSize: defaultSize.screenWidth * .040,
                      color: const Color(0xff498AEE)),
                ),
              ),
            ),
            Text(
              AppLocalisation.getTranslated(context, LKChallengerWinnerBy),
              style: subTitleTextStyle(context)
                  ?.copyWith(fontSize: defaultSize.screenWidth * .040),
            ),
            GestureDetector(
              onTap: () {
                NavRouter.push(context, const ParticipantsByCommunityScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 16),
                child: Text(
                  '${detail.winnerBy}',
                  // 'Community',
                  style: hintTextStyle(context)?.copyWith(
                    fontSize: defaultSize.screenWidth * .040,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            SvgPicture.asset('${ChallengeConst.badges["${detail.badge}"]}',
                height: 30, width: 30),
            const SizedBox(height: 3),
            Text(
              '${ChallengeConst.title["${detail.badge}"]}',
              // AppLocalisation.getTranslated(context, LKGold),
              style: labelTextStyle(context)?.copyWith(
                fontSize: defaultSize.screenWidth * .038,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              AppLocalisation.getTranslated(context, LKCompleteBadge),
              style: hintTextStyle(context)?.copyWith(
                  fontSize: defaultSize.screenWidth * .038,
                  fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }
}
