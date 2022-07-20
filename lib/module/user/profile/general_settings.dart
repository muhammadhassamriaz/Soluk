import 'dart:convert';

import 'package:app/module/influencer/bloc/language_bloc.dart';
import 'package:app/module/influencer/more/view/change_password.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/user/profile/widgets/user_profile_tile.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/shared_preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../influencer/widgets/notification_switch.dart';

class GeneralSettings extends StatefulWidget {
  static const String id = "/general_settings";

  const GeneralSettings({Key? key}) : super(key: key);

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        bgColor: backgroundColor,
        title: 'General Settings',
        // title: AppLocalisation.getTranslated(context, LKLanguages),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SB_1H,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  Container(
                    height: HEIGHT_4,
                    // width: double.maxFinite,
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey[200]!,
                    //       spreadRadius: 4.0,
                    //       blurRadius: 14.0,
                    //     ),
                    //   ],
                    //   borderRadius: BORDER_CIRCULAR_RADIUS,
                    // ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ALERT_ICON,
                          // color: PRIMARY_COLOR,
                          height: WIDTH_4,
                          width: WIDTH_4,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          'Notifications',
                          // AppLocalisation.getTranslated(
                          //     context, LKNotificationAlerts),
                          style: labelTextStyle(context)!.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        const Spacer(),
                        const NotificationSwitch()
                      ],
                    ),
                  ),
                  UserProfileTile(
                    iconPath: LOCK_ICON,
                    text: 'Change Password',
                    onTap: () =>
                        navigatorKey.currentState?.pushNamed(ChangePassword.id),
                  ),
                  // UserProfileTile(
                  //   iconPath: 'assets/images/saluk_logo.png',
                  //   text: 'Active, Monthly',
                  //   isSubscriptionCard: true,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
