import 'dart:io';

import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String path;
  final Function onClose;
  const ImageContainer({Key? key, required this.path, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.topRight,
      height: HEIGHT_5 * 2,
      width: double.maxFinite,
      decoration: BoxDecoration(
        image: path.contains('http')
            ? DecorationImage(image: NetworkImage(path), fit: BoxFit.fitWidth)
            : DecorationImage(image: FileImage(File(path)), fit: BoxFit.fitWidth),
        borderRadius: BorderRadius.circular(WIDTH_3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => onClose(),
            child: Container(
                padding: const EdgeInsets.all(3),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.5)),
                child: const Icon(
                  Icons.close,
                  size: 15,
                  color: TOGGLE_BACKGROUND_COLOR,
                )),
          ),
        ],
      ),
    );
  }
}
