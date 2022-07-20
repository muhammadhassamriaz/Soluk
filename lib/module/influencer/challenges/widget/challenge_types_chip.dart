import 'package:flutter/material.dart';

import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';

class ChallengeTypeChips extends StatefulWidget {
  const ChallengeTypeChips({
    Key? key,
    this.chips,
  }) : super(key: key);
  final List<String>? chips;

  @override
  State<ChallengeTypeChips> createState() => _ChallengeTypeChipsState();
}

class _ChallengeTypeChipsState extends State<ChallengeTypeChips> {
  final List<String> chipTitles = ["Approved", "Unapproved"];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(
      widget.chips != null && widget.chips!.isNotEmpty
          ? widget.chips!.length
          : chipTitles.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Chip(
              backgroundColor: selectedIndex == index ? PRIMARY_COLOR : null,
              label: Text(
                  widget.chips != null && widget.chips!.isNotEmpty
                      ? widget.chips![index]
                      : chipTitles[index],
                  style: selectedIndex == index
                      ? labelTextStyle(context)?.copyWith(
                          color: Colors.white,
                        )
                      : hintTextStyle(context)),
            ),
          ),
        );
      },
    ));
  }
}
