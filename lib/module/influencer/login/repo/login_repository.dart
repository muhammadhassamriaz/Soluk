import 'dart:convert';
import 'dart:developer';

import 'package:app/module/influencer/routes.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/shared_preference_manager.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../user/user_dashboard.dart';
import '../../main_screen.dart';

class LoginRepository extends WebServiceImp {
  LoginRepository._();

  static Future<void> signIn(String emailPhoneNumber, String password, BuildContext context) async {
    print('///////////////////////');
    BotToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().loginAPI(
      body: {
        "emailOrPhone": emailPhoneNumber,
        "password": password,
      },
    );
    print(apiResponse.statusCode);
    print(apiResponse.data);
    BotToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);
    if (response['responseCode'] != null && response['responseCode'] == ACCOUNT_NOT_VERIFIED) {
      showSnackBar(
        context,
        "Pin has been sent to your email.",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      navigatorKey.currentState?.pushNamed(
        VerificationPinScreen.id,
        arguments: {
          "email": emailPhoneNumber,
          "isFromSignUpScreen": true,
          "password": password,
        },
      );
    } else if (response['responseCode'] != null && response['responseCode'] != SUCCESS) {
      showSnackBar(context, response['responseDescription']);
    } else {
      print('aaeeeeeeeeeeeeeeeeeeeeeeeeeee');
      print(response['access_token']);
      sl.get<AccessDataMembers>().setToken(response['access_token']);
      getUserType();
    }
  }

  static Future<void> getUserType() async {
    print("get user type");
    ApiResponse apiResponse = await sl.get<WebServiceImp>().getUserTypeApi();

    log('GET USER TYPE API :: $apiResponse');

    var response = jsonDecode(apiResponse.data);

    if (response['status'] == 'success' && response['responseCode'] == "00") {
      int userId = response['responseDetails']['userId'];
      String userName = response['responseDetails']['username'];
      int userType = response['responseDetails']['userType'];
      PreferenceManager.instance.setString(PREFS_USERID, userId.toString());
      PreferenceManager.instance.setString(PREFS_USERNAME, userName.toString());
      PreferenceManager.instance.setString(PREFS_USERTYPE, userType.toString());

      if (userType == 1) {
        /// Navigate to influencer dashboard
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(MainScreen.id, (route) => false);
      } else if (userType == 2) {
        /// Navigate to user dashboard
        navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => UserDashboard(),
            ),
            (route) => false);
      }
    }
  }

  static Future<void> forgotPassword(BuildContext context, String email) async {
    BotToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
          endPoint: "api/user/forget-password",
          body: {
            "emailOrPhone": email,
          },
          isAuthTokenRequired: false,
        );
    BotToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);
    if (response['responseCode'] != null && response['responseCode'] != SUCCESS) {
      invalidDataSnackBar(context, response['responseCode']);
    } else {
      navigatorKey.currentState?.pushNamed(
        VerificationPinScreen.id,
        arguments: {
          "email": email,
          "isFromSignUpScreen": false,
        },
      );
    }
  }

  static Future<void> resetPassword(
      String pin, String email, String password, BuildContext context) async {
    BotToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
          endPoint: "api/user/reset-password",
          body: {"emailOrPhone": email, "otp": pin, "newPassword": password},
          isAuthTokenRequired: false,
        );
    BotToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);
    if (response['responseCode'] != null && response['responseCode'] != SUCCESS) {
      invalidDataSnackBar(context, response['responseCode']);
    } else {
      showSnackBar(
        context,
        "New password created successfully.",
        textColor: Colors.white,
        backgroundColor: Colors.black,
      );
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        LoginScreen.id,
        (_) => false,
      );
    }
  }

  static Future<void> signUp(String fullname, String email, String password, String phoneNumber,
      String instagram, String youtube, BuildContext context) async {
    BotToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
          endPoint: "api/user/signup",
          body: {
            "fullname": fullname,
            "email": email,
            "password": password,
            "phone": phoneNumber,
            "new_password": password,
            "instagram": instagram,
            "youtube": youtube,
            "roleId": "1",
          },
          isAuthTokenRequired: false,
        );
    BotToast.closeAllLoading();

    if (apiResponse.status == APIStatus.error) {
      if (apiResponse.statusCode == 11) {
        showSnackBar(context, "Email/Phone already exist.");
      }
    } else {
      Fluttertoast.showToast(msg: 'Registration successful, Please login to continue');
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        LoginScreen.id,
        (_) => false,
      );
    }
  }

  static Future<void> verifyOTP(BuildContext context, String pin) async {
    Map<String, dynamic> data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    BotToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
          endPoint: data['isFromSignUpScreen'] ? 'api/user/account-verify' : "api/user/otp-verify",
          body: {
            "emailOrPhone": data['email'],
            "otp": pin,
            "password": data['password'],
          },
          isAuthTokenRequired: false,
        );
    if (apiResponse.status == APIStatus.success) {
      data['isFromSignUpScreen']
          ? signIn(data['email'], data['password'], context)
          : navigatorKey.currentState?.pushNamedAndRemoveUntil(
              ResetPasswordScreen.id,
              (_) => false,
              arguments: {
                "pin": pin,
                "email": data['email'],
              },
            );
    } else {
      BotToast.closeAllLoading();
      showSnackBar(context, apiResponse.data);
    }
  }

  static Future<void> resendOTP(BuildContext context) async {
    Map<String, dynamic> data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    BotToast.showLoading();
    ApiResponse apiResponse = (await sl.get<WebServiceImp>().callPostAPI(
          endPoint: "api/login",
          body: {
            "emailOrPhone": data['email'],
            "password": data['password'],
          },
          isAuthTokenRequired: false,
        ));
    BotToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);
    if (response['responseCode'] != null && response['responseCode'] == ALREADY_EXIST) {
      showSnackBar(context, "Code successfully sent to your email");
    }
    if (response['responseCode'] != null && response['responseCode'] != SUCCESS) {
      invalidDataSnackBar(context, response['responseCode']);
    } else {
      sl.get<AccessDataMembers>().setToken(response['access_token']);
    }
  }
}
