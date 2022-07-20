import 'package:flutter/material.dart';

import '../../../../../res/constants.dart';
import '../../../../../res/globals.dart';
import '../../../../../services/localisation.dart';

class RewardWidget extends StatelessWidget {
  const RewardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalisation.getTranslated(context, LKReward),
          style: labelTextStyle(context)?.copyWith(
              fontSize: defaultSize.screenWidth * .034,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Image.asset(
          'assets/images/ic_reward.png',
          height: 30,
          width: 30,
        ),
        const SizedBox(height: 6),
        Text(
          'Gold',
          style: hintTextStyle(context)?.copyWith(
              fontSize: defaultSize.screenWidth * .038,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
