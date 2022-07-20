import 'package:app/res/color.dart';
import 'package:flutter/material.dart';

class FriendsDetailsButton extends StatelessWidget {
  FriendsDetailsButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.textColor = Colors.white,
    this.backgroundColor = PRIMARY_COLOR,
    this.isOutlinedButton = false,
    this.horizontalPadding = 0,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final Color textColor;
  final Color backgroundColor;
  final bool isOutlinedButton;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: TextButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: isOutlinedButton ? Colors.transparent : backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 50),
          side: BorderSide(color: PRIMARY_COLOR, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
            fontSize: 12
          ),
        ),
      ),
    );
  }
}
