import 'package:app/module/user/profile/grocery_screen.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

import 'user_profile_tile.dart';

class WorkoutsCard extends StatelessWidget {
  const WorkoutsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_1.svg',
            text: 'My Influencers',
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_2.svg',
            text: 'My Workouts',
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_3.svg',
            text: 'Downloads',
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_4.svg',
            text: 'My Challenges',
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_5.svg',
            text: 'My Badges',
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_6.svg',
            text: 'Weight Progress',
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_7.svg',
            text: 'Grocery List',
            onTap: ()=> navigatorKey.currentState?.pushNamed(GroceryScreen.id),

          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_8.svg',
            text: 'Friends',
          ),
        ],
      ),
    );
  }
}
