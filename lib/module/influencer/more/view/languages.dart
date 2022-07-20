import 'dart:convert';

import 'package:app/module/influencer/bloc/language_bloc.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
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

class Languages extends StatefulWidget {
  static const String id = "/more_languages";

  const Languages({Key? key}) : super(key: key);

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  @override
  void initState() {
    super.initState();
    _getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    final _languageBloc = BlocProvider.of<LanguageBloc>(context);
    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, LKLanguages),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SB_1H,
            Text(
              AppLocalisation.getTranslated(context, LKSelectLanguage),
              style: labelTextStyle(context)?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SB_1H,
            BlocBuilder<LanguageBloc, Language>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _languageBloc.add(English());
                        AppLocalisation.changeLanguage("en", context);
                        PreferenceManager.instance.setString(PREFS_LANG, 'en');
                        sl.get<WebServiceImp>().callPostAPI(
                            endPoint: "api/user/add-language",
                            body: {"language": "english"});
                      },
                      child: Container(
                        height: HEIGHT_4,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200]!,
                              spreadRadius: 4.0,
                              blurRadius: 14.0,
                            ),
                          ],
                          borderRadius: BORDER_CIRCULAR_RADIUS,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: WIDTH_1,
                          ),
                          child: Row(
                            children: [
                              Text(
                                AppLocalisation.getTranslated(
                                    context, LKEnglish),
                                style: labelTextStyle(context),
                              ),
                              const Spacer(),
                              Icon(Icons.check_circle,
                                  color: PreferenceManager.instance
                                                  .getString(PREFS_LANG) ==
                                              'en' ||
                                          PreferenceManager.instance
                                                  .getString(PREFS_LANG) ==
                                              ''
                                      ? PRIMARY_COLOR
                                      : Colors.grey[400])
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: defaultSize.screenHeight * .02,
                    ),
                    InkWell(
                      onTap: () {
                        _languageBloc.add(Arabic());
                        AppLocalisation.changeLanguage("ar", context);
                        PreferenceManager.instance.setString(PREFS_LANG, 'ar');
                        sl.get<WebServiceImp>().callPostAPI(
                            endPoint: "api/user/add-language",
                            body: {"language": "arabic"});
                      },
                      child: Container(
                        height: HEIGHT_4,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200]!,
                              spreadRadius: 4.0,
                              blurRadius: 14.0,
                            ),
                          ],
                          borderRadius: BORDER_CIRCULAR_RADIUS,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: WIDTH_1,
                          ),
                          child: Row(
                            children: [
                              Text(
                                AppLocalisation.getTranslated(
                                    context, LKArabic),
                                style: labelTextStyle(context),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.check_circle,
                                color: PreferenceManager.instance
                                            .getString(PREFS_LANG) ==
                                        'ar'
                                    ? PRIMARY_COLOR
                                    : Colors.grey[400],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _getLanguage() async {
    ApiResponse? apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
          endPoint: "api/user/get-language",
          isAuthTokenRequired: true,
        );

    if (apiResponse.data == null) return;

    final response = json.decode(apiResponse.data);

    if (apiResponse.data != null) {
      if (apiResponse.status == APIStatus.success) {
        if (response['responseDetails']['language']
            .toString()
            .toLowerCase()
            .contains("eng")) {
          BlocProvider.of<LanguageBloc>(context, listen: false).add(English());
        } else {
          {
            BlocProvider.of<LanguageBloc>(context, listen: false).add(Arabic());
          }
        }
      }
    }
  }
}
