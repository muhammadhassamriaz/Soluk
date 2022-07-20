import 'dart:io';
import 'package:app/module/influencer/widgets/bottom_nav_icon.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class UserBottomNavBar extends StatelessWidget {
  const UserBottomNavBar(
      {Key? key, required this.selectedIndex, required this.onTap})
      : super(key: key);
  final int selectedIndex;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Platform.isIOS ? 16 : 0),
      height: Platform.isIOS ? 75 : 62,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.15),
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: BottomNavIcon(
              callback: () {
                onTap(0);
              },
              asset: 'assets/svgs/ic_user_home.svg',
              matched: selectedIndex == 0,
              title: 'Home',
            ),
          ),
          Expanded(
            child: BottomNavIcon(
              callback: () {
                onTap(1);
              },
              asset: 'assets/svgs/ic_user_meals.svg',
              matched: selectedIndex == 1,
              title: 'Meals',
            ),
          ),
          Expanded(
            child: BottomNavIcon(
              callback: () {
                onTap(2);
              },
              asset: 'assets/svgs/ic_user_community.svg',
              matched: selectedIndex == 2,
              title: 'Community',
            ),
          ),
          Expanded(
            child: BottomNavIcon(
              callback: () {
                onTap(3);
              },
              asset: 'assets/svgs/ic_user_profile.svg',
              matched: selectedIndex == 3,
              title: 'John Doe',
            ),
          ),
        ],
      ),
    );
  }
}
