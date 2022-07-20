import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/user/community/widgets/chat_tiles/receiver_tile.dart';
import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';

import '../../../widgets/user_appbar.dart';
import '../../widgets/chat_tiles/sender_tile.dart';
import '../../widgets/send_message_widget.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: UserAppbar(title: 'John Doe', bgColor: Colors.white),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 14),
              itemCount: 4,
              itemBuilder: (context, index) {
                return index % 2 == 0 ? SenderTile() : ReceiverTile();
              },
            ),
          ),
          SendMessageWidget(),
        ],
      ),
    );
  }
}
