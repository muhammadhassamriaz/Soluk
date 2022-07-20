import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView(
    this.text, {
    Key? key,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.textAlign,
    this.color = Colors.black,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color color;
  final double? height;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      ),
    );
  }
}
