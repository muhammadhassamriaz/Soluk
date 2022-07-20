import 'package:app/module/influencer/challenges/view/participants/participants_detail_screen.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../../../animations/slide_up_transparent_animation.dart';
import '../../../../../repo/repository/web_service.dart';
import '../../../../../services/localisation.dart';
import '../../../../../utils/dependency_injection.dart';
import '../../../more/widget/custom_alert_dialog.dart';
import '../../../widgets/action_pop_up.dart';
import '../../../widgets/reward_popup.dart';

class ChallengerTile extends StatelessWidget {
  const ChallengerTile({Key? key}) : super(key: key);

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
            SalukTransparentButton(
              title: AppLocalisation.getTranslated(context, LKSeeDetails),
              buttonWidth: WIDTH_5 * 2,
              borderColor: PRIMARY_COLOR,
              onPressed: () {
                NavRouter.push(context,
                    const ParticipantsDetailsScreen(isRewardScreen: false));
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
            SizedBox(
              width: defaultSize.screenWidth * .02,
            ),
            SalukGradientButton(
              title: AppLocalisation.getTranslated(context, LKGiveReward),
              buttonWidth: WIDTH_5 * 2.2,
              borderColor: PRIMARY_COLOR,
              onPressed: () {
                navigatorKey.currentState?.push(
                  SlideUpTransparentRoute(
                    enterWidget: CustomAlertDialog(
                      sigmaX: 0,
                      sigmaY: 0,
                      contentWidget: RewardPopUp(
                        iconPath: 'assets/images/ic_success_tick.png',
                        title: AppLocalisation.getTranslated(context, LKSuccessfully),
                        content: AppLocalisation.getTranslated(context, LKRewardGivenSuccessfully),
                        actionButtons: SizedBox(
                          child: SalukGradientButton(
                            title: AppLocalisation.getTranslated(context, LKDone),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            buttonHeight: HEIGHT_2+5,
                          ),
                        ),
                      ),
                    ),
                    routeName: CustomAlertDialog.id,
                  ),
                );
              },
              buttonHeight: HEIGHT_1 + 2,
              style: labelTextStyle(context)?.copyWith(
                fontSize: defaultSize.screenWidth * .028,
                color: Colors.white,
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
