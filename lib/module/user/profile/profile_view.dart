import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/module/user/widgets/user_appbar.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../repo/data_source/local_store.dart';
import '../../../res/globals.dart';
import '../../../services/localisation.dart';
import '../../../utils/nav_router.dart';
import '../../../utils/shared_preference_manager.dart';
import '../../influencer/login/view/pre_registration_screen.dart';
import '../../influencer/more/widget/more_tile.dart';
import 'widgets/settings_card.dart';
import 'widgets/subscription_card.dart';
import 'widgets/workouts_card.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: UserAppbar(
        title: '',
        hasCenteredWidget: true,
        centeredWidget: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/200/300'),
              radius: 30,
            ),
            SizedBox(height: 10),
            TextView('John Doe', fontSize: 18, fontWeight: FontWeight.w600),
            TextView('Active, Monthly', fontSize: 10, color: Colors.grey,)
          ],
        ),
        action: [
          SvgPicture.asset('assets/svgs/ic_edit_profile.svg'),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileHeaderText('Workouts',topPadding: 8),
              WorkoutsCard(),
              ProfileHeaderText('Subscription'),
              SubscriptionCard(),
              ProfileHeaderText('Settings'),
              SettingsCard(),
              SizedBox(height: 60),
              TextView('Version 1.0.0', color: Colors.grey, fontSize: 14),
              SizedBox(height: 20),
              LogoutButton(),
              SB_1H,
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeaderText extends StatelessWidget {
  const ProfileHeaderText(this.text, {Key? key,this.topPadding = 24}) : super(key: key);
  final String text;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: topPadding, bottom: 15),
      child: TextView(
        text,
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MoreTile(
      title: AppLocalisation.getTranslated(context, LKLogOut),
      asset: EXIT_ICON,
      isLogout: true,
      callback: () async {
        LocalStore.removeData(LSKeyAuthToken);
        LocalStore.removeData(LSKeySelectedLanguage);
        await PreferenceManager.instance.clear();
        NavRouter.pushAndRemoveUntil(context, const PreRegistrationScreen());
      },
    );
  }
}
