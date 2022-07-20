import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SalukTransparentButton extends StatelessWidget {
  const SalukTransparentButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.textFontSize = 14.0,
      this.isLoading = false,
      this.dim = false,
      this.icon,
      this.height = 45,
      this.textColor = Colors.white,
      this.linearGradient,
      required this.buttonHeight,
      this.style,
      this.buttonWidth,
      this.borderColor,
      this.borderRadius,
      this.buttonColor,
      this.subTitle})
      : super(key: key);

  final String title;
  final String? subTitle;
  final Function onPressed;
  final double textFontSize;
  final bool isLoading;
  final bool dim;
  final Icon? icon;
  final Color textColor;
  final Color? buttonColor;
  final double height;
  final double? buttonHeight;
  final LinearGradient? linearGradient;
  final double? buttonWidth;
  final TextStyle? style;
  final Color? borderColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    print("text color : ${textColor}");
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(defaultSize.screenWidth * .02),
        splashColor: Colors.transparent.withOpacity(0.2),
        highlightColor: Colors.transparent,
        onTap: () {
          onPressed();
        },
        child: Container(
          width: buttonWidth ?? double.maxFinite,
          height: buttonHeight ?? HEIGHT_4,
          decoration: BoxDecoration(
            color: buttonColor ?? Colors.white.withOpacity(0.2),
            borderRadius: borderRadius ?? BORDER_CIRCULAR_RADIUS,
            border: Border.all(
              color: borderColor ?? Colors.white,
              width: defaultSize.screenWidth * .003,
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? SizedBox(),
                icon != null
                    ? SizedBox(
                        width: 5,
                      )
                    : SizedBox(),
                RichText(
                  text: TextSpan(
                    text: title,
                    style: labelTextStyle(context)
                        ?.copyWith(color: textColor, fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                        text: subTitle,
                        style: labelTextStyle(context)?.copyWith(
                            color: textColor, fontWeight: FontWeight.w400, fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
