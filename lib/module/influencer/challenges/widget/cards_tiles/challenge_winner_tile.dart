import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';

import '../../../../../services/localisation.dart';
import '../../view/participants/challenger_winner_details_screen.dart';

class ChallengeWinnerTile extends StatelessWidget {
  final bool hasWonTheReward;

  ChallengeWinnerTile({Key? key,  this.hasWonTheReward = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: HEIGHT_3,
              height: HEIGHT_3,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    GYMINSTRUCTOR_AVATAR,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SB_1W,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Alex Miller",
                  style: labelTextStyle(context)?.copyWith(
                    fontSize: defaultSize.screenWidth * .035,
                  ),
                ),
                SizedBox(
                  height: defaultSize.screenHeight * .01,
                ),
                Text(
                  "Done on: 20 July 2021",
                  style: hintTextStyle(context)?.copyWith(
                    fontSize: defaultSize.screenWidth * .024,
                  ),
                ),
                SizedBox(
                  height: defaultSize.screenHeight * .01,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.star_rounded, color: Color(0xff498AEE)),
                const SizedBox(width: 4),
                Text(
                  '3.2',
                  style: labelTextStyle(context)?.copyWith(),
                ),
              ],
            ),
            SizedBox(
              width: defaultSize.screenWidth * .06,
            ),
            SalukTransparentButton(
              title: AppLocalisation.getTranslated(context, LKSeeDetails),
              buttonWidth: WIDTH_5 * 2,
              borderColor: PRIMARY_COLOR,
              onPressed: () {
                NavRouter.push(
                    context,  ParticipantsByCommunityDetailsScreen(
                  hasWonTheReward: hasWonTheReward,
                ));
              },
              buttonHeight: HEIGHT_1 + 2,
              style: labelTextStyle(context)?.copyWith(
                fontSize: defaultSize.screenWidth * .028,
                color: PRIMARY_COLOR,
              ),
              borderRadius: BorderRadius.circular(
                defaultSize.screenWidth * .02,
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}
