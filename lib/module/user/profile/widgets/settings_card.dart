import 'package:app/module/influencer/more/view/languages.dart';
import 'package:app/module/influencer/more/view/notifications.dart';
import 'package:app/module/user/profile/general_settings.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

import 'user_profile_tile.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
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
            iconPath: 'assets/svgs/ic_profile_settings_1.svg',
            text: 'General Settings',
            onTap: ()=> navigatorKey.currentState?.pushNamed(GeneralSettings.id),
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_settings_2.svg',
            text: 'Languages',
            onTap: ()=> navigatorKey.currentState?.pushNamed(Languages.id),
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_settings_3.svg',
            text: 'Privacy Settings',
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_settings_4.svg',
            text: 'Legals',
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_settings_5.svg',
            text: 'Support',
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_settings_6.svg',
            text: 'About',
          ),
        ],
      ),
    );
  }
}
