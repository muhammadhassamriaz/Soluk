import 'package:app/module/influencer/challenges/view/participants/participants_detail_screen.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';

import '../../../../../services/localisation.dart';

class RewardTile extends StatelessWidget {
  const RewardTile({Key? key}) : super(key: key);

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
            Column(
              children: [
                Image.asset(
                  'assets/images/ic_reward.png',
                  height: 26,
                  width: 26,
                ),
                const SizedBox(height: 1),
                Text(
                  AppLocalisation.getTranslated(context, LKGold),
                  style: hintTextStyle(context)?.copyWith(
                    fontSize: defaultSize.screenWidth * .020,
                  ),
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
                NavRouter.push(context,
                    const ParticipantsDetailsScreen(isRewardScreen: true));
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
