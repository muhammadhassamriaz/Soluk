
import 'package:app/module/influencer/login/repo/login_repository.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/influencer_tab.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_password_textfield.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/string_manipulator.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "/signup_screen";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailAddressTextEditingController =
          TextEditingController(),
      _passwordTextEditingController = TextEditingController(),
      _phoneNumberTextEditingController = TextEditingController(),
      _fullNameTextEditingController = TextEditingController(),
      _instagramTextEditingController = TextEditingController(),
      _youtubeTextEditingController = TextEditingController(),
      _promoCodeTextEditingController = TextEditingController();

  final ValueNotifier<int> _selectedTabNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _onDataLoaded(),
      ),
    );
  }

  _onDataLoaded() {
    return DefaultTabController(
      length: 2,
      child: AppBody(
        title: AppLocalisation.getTranslated(context, LKSignUp),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: defaultSize.screenHeight * .2,
                    width: defaultSize.screenHeight * .2,
                    child: Image.asset(
                      APP_LOGO,
                      scale: defaultSize.scaleWidth,
                    ),
                  ),
                ),
                SB_3H,
                Text(
                  AppLocalisation.getTranslated(context, LKSignUp),
                  style: headingTextStyle(context),
                ),
                Text(
                  AppLocalisation.getTranslated(context, LKBecome),
                  style: labelTextStyle(context),
                ),
                SB_1H,
                Container(
                  height: HEIGHT_4,
                  width: defaultSize.screenWidth * .48,
                  padding: EdgeInsets.all(
                    defaultSize.screenWidth * .015,
                  ),
                  decoration: BoxDecoration(
                    color: TOGGLE_BACKGROUND_COLOR,
                    borderRadius: BORDER_CIRCULAR_RADIUS,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: TabBar(
                    isScrollable: true,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BORDER_CIRCULAR_RADIUS,
                    ),
                    labelStyle: labelTextStyle(context)?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: labelTextStyle(context)?.copyWith(
                      color: Colors.grey,
                    ),
                    labelColor: PRIMARY_COLOR,
                    onTap: (i) {
                      _selectedTabNotifier.value = i;
                      _selectedTabNotifier.notifyListeners();
                    },
                    unselectedLabelColor: Colors.grey[500],
                    tabs: [
                      Tab(
                        text: AppLocalisation.getTranslated(context, LKUser),
                      ),
                      Tab(
                        text: AppLocalisation.getTranslated(
                          context,
                          LKInfulencer,
                        ),
                      ),
                    ],
                  ),
                ),
                SB_1H,
                SalukTextField(
                  textEditingController: _fullNameTextEditingController,
                  hintText: '',
                  onValidator: (value) {
                    return StringManipulator.getValidFullName(value);
                  },
                  onChange: (value) {
                    setState(() {});
                  },
                  isFormField: true,
                  labelText: AppLocalisation.getTranslated(context, LKFullName),
                ),
                SB_1H,
                SalukTextField(
                  textEditingController: _emailAddressTextEditingController,
                  hintText: '',
                  onValidator: (value) {
                    return StringManipulator.getValidEmail(value);
                  },
                  onChange: (value) {
                    setState(() {});
                  },
                  isFormField: true,
                  labelText: AppLocalisation.getTranslated(context, LKEmail),
                  textInputType: TextInputType.emailAddress,
                ),
                SB_1H,
                SalukTextField(
                  textEditingController: _phoneNumberTextEditingController,
                  hintText: '',
                  onValidator: (value) {
                    return StringManipulator.getValidPhoneNumber(value);
                  },
                  onChange: (value) {
                    setState(() {});
                  },
                  textInputType: TextInputType.phone,
                  isFormField: true,
                  labelText:
                      AppLocalisation.getTranslated(context, LKMobileNumber),
                ),
                SB_1H,
                PasswordTextField(
                  passwordTextEditingController: _passwordTextEditingController,
                  isFormField: true,
                  onChange: (value) {
                    setState(() {});
                  },
                  onValidator: (value) {
                    return StringManipulator.getValidPassword(value);
                  },
                ),
                SB_1H,
                ValueListenableBuilder(
                  valueListenable: _selectedTabNotifier,
                  builder: (context, value, child) {
                    return SizedBox(
                      height: _selectedTabNotifier.value == 0
                          ? defaultSize.screenHeight * .1
                          : defaultSize.screenHeight * .35,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          SalukTextField(
                            textEditingController:
                                _promoCodeTextEditingController,
                            hintText: '',
                            onChange: (value) {
                              setState(() {});
                            },
                            isFormField: true,
                            labelText:
                                AppLocalisation.getTranslated(context, LKPromo),
                          ),
                          InfluencerTabView(
                            instagramTextEditingController:
                                _instagramTextEditingController,
                            youtubeTextEditingController:
                                _youtubeTextEditingController,
                            onChange: (value) {
                              setState(() {});
                            },
                            onChange1: (value) {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SB_1H,
                SalukGradientButton(
                  title: AppLocalisation.getTranslated(context, LKSignUp),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      LoginRepository.signUp(
                          _fullNameTextEditingController.text,
                          _emailAddressTextEditingController.text,
                          _passwordTextEditingController.text,
                          _phoneNumberTextEditingController.text,
                          _instagramTextEditingController.text,
                          _youtubeTextEditingController.text,
                          context);
                    }
                  },
                  buttonHeight: HEIGHT_4,
                  dim: _fullNameTextEditingController.text.isNotEmpty &&
                          _passwordTextEditingController.text.isNotEmpty &&
                          _emailAddressTextEditingController.text.isNotEmpty &&
                          _phoneNumberTextEditingController.text.isNotEmpty &&
                          (_instagramTextEditingController.text.isNotEmpty &&
                                  _youtubeTextEditingController
                                      .text.isNotEmpty ||
                              _promoCodeTextEditingController.text.isNotEmpty)
                      ? false
                      : true,
                ),
                SB_1H,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
