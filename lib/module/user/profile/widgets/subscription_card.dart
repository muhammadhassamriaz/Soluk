import 'package:flutter/material.dart';

import 'user_profile_tile.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          UserProfileTile(
            iconPath: 'assets/images/saluk_logo.png',
            text: 'Active, Monthly',
            isSubscriptionCard: true,
          ),
        ],
      ),
    );
  }
}
