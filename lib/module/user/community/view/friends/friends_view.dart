import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';

import '../../widgets/tiles/community_friends_tile.dart';
import '../../widgets/community_header_text.dart';
import 'friends_details_view.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommunityHeaderText('All Friends'),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 8, bottom: 10),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                    onTap: () {
                      NavRouter.push(context, FriendsDetailsView());
                    },
                    child: CommunityFriendsTile());
              },
            ),
          ),
        ],
      ),
    );
  }
}
