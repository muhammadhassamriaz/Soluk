import 'package:flutter/material.dart';

import '../../widgets/community_header_text.dart';
import '../../widgets/user_community_challenges_card.dart';

class ChallengesView extends StatelessWidget {
  const ChallengesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommunityHeaderText('All Challenges'),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(top: 8, bottom: 10),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 190,
                mainAxisExtent: 190,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return UserCommunityChallengesCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
