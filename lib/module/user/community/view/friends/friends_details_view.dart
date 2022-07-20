import 'package:flutter/material.dart';

import '../../../../../res/constants.dart';
import '../../../widgets/user_appbar.dart';
import '../../widgets/friends_details_activity_card.dart';
import '../../widgets/friends_details_profile_card.dart';

class FriendsDetailsView extends StatelessWidget {
  const FriendsDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: UserAppbar(
        title: 'Friends',
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          FriendsDetailsProfileCard(),
          SizedBox(height: 14),
          FriendsDetailsActivityCard(),
        ],
      ),
    );
  }
}
