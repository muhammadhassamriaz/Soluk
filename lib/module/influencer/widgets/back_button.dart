import 'package:app/res/globals.dart';
import 'package:app/utils/enums.dart';
import 'package:flutter/material.dart';

class SolukBackButton extends StatelessWidget {
  final VoidCallback? callback;

  const SolukBackButton({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        constraints: BoxConstraints(
          maxHeight: defaultSize.screenWidth * .09,
          maxWidth: defaultSize.screenWidth * .09,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(
            defaultSize.screenWidth * .02,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: defaultSize.screenWidth * .05,
          ),
        ),
      ),
    );
  }
}
