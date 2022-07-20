import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../res/constants.dart';
import '../../../../../services/localisation.dart';
import '../../widget/cards_tiles/challenger_tile.dart';
import '../../widget/cards_tiles/reward_tile.dart';

class ParticipantsByInfluencerScreen extends StatefulWidget {
  const ParticipantsByInfluencerScreen({Key? key}) : super(key: key);

  @override
  State<ParticipantsByInfluencerScreen> createState() =>
      _ParticipantsByInfluencerScreenState();
}

class _ParticipantsByInfluencerScreenState
    extends State<ParticipantsByInfluencerScreen> {
  bool isParticipantsSelected = true;
  bool isRewardsSelected = false;

  final PageController _pageController = PageController();

  void _selectParticipantChip() {
    setState(() {
      isParticipantsSelected = true;
      isRewardsSelected = false;
      _pageController.animateToPage(0,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void _selectRewardChip() {
    setState(() {
      isParticipantsSelected = false;
      isRewardsSelected = true;
      _pageController.animateToPage(1,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, LKParticipants),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                choiceChipWidget(context,
                    title: AppLocalisation.getTranslated(
                        context, LKAllParticipants),
                    isIncomeSelected: isParticipantsSelected,
                    onSelected: (val) => _selectParticipantChip()),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 2.09.w),
                  child: choiceChipWidget(
                    context,
                    title: AppLocalisation.getTranslated(context, LKRewards),
                    isIncomeSelected: isRewardsSelected,
                    onSelected: (val) => _selectRewardChip(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  if (page == 0) {
                    _selectParticipantChip();
                  } else {
                    _selectRewardChip();
                  }
                },
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const ChallengerTile();
                    },
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const RewardTile();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
