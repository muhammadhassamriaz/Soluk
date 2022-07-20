import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  const EmptyScreen({
    Key? key,
    required this.title,
    required this.callback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle,
            size: defaultSize.screenWidth * .12,
            color: PRIMARY_COLOR,
          ),
          SizedBox(
            height: defaultSize.screenHeight * .01,
          ),
          Text(
           title,
            style: subTitleTextStyle(context),
          ),
          SB_1H,
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sollicitudin porttitor turpis non at nec facilisis lacus.",
            textAlign: TextAlign.center,
            style: hintTextStyle(context),
          ),
        ],
      ),
    );
  }
}
