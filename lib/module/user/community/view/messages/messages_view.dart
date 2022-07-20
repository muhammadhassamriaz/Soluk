import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';

import '../../widgets/community_header_text.dart';
import '../../widgets/tiles/recent_messages_tile.dart';
import 'chat_view.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommunityHeaderText('Messages'),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 8, bottom: 10),
              itemCount: 6,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      NavRouter.push(context, ChatView());
                    },
                    child: RecentMessagesTile());
              },
            ),
          ),
        ],
      ),
    );
  }
}
