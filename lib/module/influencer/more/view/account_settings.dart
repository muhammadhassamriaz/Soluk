import 'package:app/animations/slide_up_transparent_animation.dart';
import 'package:app/module/influencer/more/widget/custom_alert_dialog.dart';
import 'package:app/module/influencer/widgets/action_pop_up.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';

class AccountSettings extends StatelessWidget {
  static const String id = "/more_account_settings";
  const AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, LKAccountSettings),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SB_1H,
            SizedBox(
              width: defaultSize.screenWidth * .6,
              child: Text(
                "Lorem ipsum dolor sit amet, ",
                style: headingTextStyle(context)?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: defaultSize.screenHeight * .015,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Posuere euismod fermentum feugiat venenatis metus feugiat euismod. Ut sodales rhoncus, elementum vitae pretium. Porttitor varius cursus sapien vulputate etiam at rutrum pretium eu.",
              style: labelTextStyle(context),
            ),
            SB_2H,
            InkWell(
              onTap: () {
                navigatorKey.currentState?.push(
                  SlideUpTransparentRoute(
                    enterWidget: CustomAlertDialog(
                      contentWidget: ActionPopUp(
                        title: AppLocalisation.getTranslated(
                            context, LKDeleteAccount),
                        content: AppLocalisation.getTranslated(
                            context, LKConfirmDelete),
                        actionButtons: Row(
                          children: [
                            SizedBox(
                              width: defaultSize.screenWidth * .35,
                              child: SalukGradientButton(
                                title: AppLocalisation.getTranslated(
                                    context, LKNo),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                buttonHeight: HEIGHT_3,
                                linearGradient: const LinearGradient(
                                  colors: [
                                    Colors.black,
                                    Colors.black,
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: defaultSize.screenWidth * .35,
                              child: SalukGradientButton(
                                title: AppLocalisation.getTranslated(
                                    context, LKYes),
                                onPressed: () async {
                                  await sl.get<WebServiceImp>().callPostAPI(
                                      endPoint: "api/user/delete", body: {});
                                  Phoenix.rebirth(context);
                                },
                                buttonHeight: HEIGHT_3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    routeName: CustomAlertDialog.id,
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    BIN_ICON,
                  ),
                  SizedBox(
                    width: defaultSize.screenWidth * .02,
                  ),
                  Text(
                    AppLocalisation.getTranslated(context, LKDeleteAccount),
                    style: labelTextStyle(context)?.copyWith(
                      color: RED_COLOR,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
