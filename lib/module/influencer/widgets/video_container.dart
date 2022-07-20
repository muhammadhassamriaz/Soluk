import 'dart:io';

import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoContainer extends StatelessWidget {
  final Function()? closeButton;
  final Function()? playVideo;
  final String? netUrl;
  final File? file;
  final double? width;
  final double? height;
  const VideoContainer(
      {Key? key, this.closeButton, this.playVideo, this.file, this.netUrl, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onTap: playVideo,
          child: Container(
            height: HEIGHT_5 * 2,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(WIDTH_3),
            ),
            child: Icon(
              Icons.play_circle_fill,
              size: 45,
            ),
            width: defaultSize.screenWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: closeButton,
            child: Container(
              width: 20,
              height: 20,
              child: SvgPicture.asset('assets/svgs/cross_icon.svg', height: 25, width: 25),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
          ),
        )
      ],
    );
  }
}
