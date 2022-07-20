import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../res/constants.dart';
import '../../../../../services/localisation.dart';
import '../../widget/cards_tiles/challenge_winner_tile.dart';

class ParticipantsByCommunityScreen extends StatefulWidget {
  const ParticipantsByCommunityScreen({Key? key}) : super(key: key);

  @override
  State<ParticipantsByCommunityScreen> createState() =>
      _ParticipantsByCommunityScreenState();
}

class _ParticipantsByCommunityScreenState
    extends State<ParticipantsByCommunityScreen> {
  bool isParticipantsSelected = true;
  bool isRewardsSelected = false;

  final PageController _pageController = PageController();

  void _selectParticipantTile() {
    setState(() {
      isParticipantsSelected = true;
      isRewardsSelected = false;
   
    });
       _pageController.animateToPage(0,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void _selectRewardTile() {
    setState(() {
      isParticipantsSelected = false;
      isRewardsSelected = true;
      
    });
    _pageController.animateToPage(1,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
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
                choiceChipWidget(
                  context,
                  title: AppLocalisation.getTranslated(
                      context, LKAllParticipants),
                  isIncomeSelected: isParticipantsSelected,
                  onSelected: (val) => _selectParticipantTile(),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 2.09.w),
                  child: choiceChipWidget(
                    context,
                    title: AppLocalisation.getTranslated(context, LKWinner),
                    isIncomeSelected: isRewardsSelected,
                    onSelected: (val) => _selectRewardTile(),
                  ),
                )
              ],
            ),
            const SizedBox(height: 14),
            Expanded(
                child: PageView(
                    controller: _pageController,
                    onPageChanged: (page) {
                      if (page == 0) {
                        _selectParticipantTile();
                      } else {
                        _selectRewardTile();
                      }
                    },
                    children: [
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ChallengeWinnerTile();
                    },
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ChallengeWinnerTile(
                        hasWonTheReward: true,
                      );
                    },
                  ),
                ]))
          ],
        ),
      ),
    );
  }
}
