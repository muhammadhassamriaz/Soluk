import 'package:app/module/user/community/view/community_view.dart';
import 'package:app/module/user/home/home_view.dart';
import 'package:app/module/user/meals/meals_view.dart';
import 'package:app/module/user/profile/profile_view.dart';
import 'package:flutter/material.dart';

import 'widgets/user_bottom_navbar.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {

  int _selectedIndex = 2;

  Widget getCurrentScreen(int index) {
    Widget widget = Container();
    switch (index) {
      case 0:
        widget = const HomeView();
        break;
      case 1:
        widget = const MealsView();
        break;
      case 2:
        widget = const CommunityView();
        break;
      case 3:
        widget = const ProfileView();
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCurrentScreen(_selectedIndex),
      bottomNavigationBar: UserBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
