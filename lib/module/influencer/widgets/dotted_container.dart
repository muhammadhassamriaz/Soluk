import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../res/constants.dart';
import '../../../services/localisation.dart';

class DottedContainer extends StatelessWidget {
  final Widget? child;

  final VoidCallback? callback;

  const DottedContainer({
    Key? key,
    this.child,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback!();
      },
      child: DottedBorder(
        radius: const Radius.circular(15),
        dashPattern: const [5, 5],
        color: PRIMARY_COLOR,
        borderType: BorderType.RRect,
        child: Container(
          height: HEIGHT_5 * 2,
          width: double.maxFinite,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: child ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle,
                    size: WIDTH_5,
                    color: PRIMARY_COLOR,
                  ),
                  Text(
                    AppLocalisation.getTranslated(context, LKUploadPreviewImVd),
                    textAlign: TextAlign.center,
                    style: labelTextStyle(context)
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
