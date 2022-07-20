import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';

import '../../influencer/widgets/back_button.dart';

class UserAppbar extends StatelessWidget with PreferredSizeWidget {
  UserAppbar(
      {Key? key,
      required this.title,
      this.bgColor = backgroundColor,
      this.action,
      this.centeredWidget,
      this.hasCenteredWidget = false})
      : super(key: key);
  final String title;
  final Color bgColor;
  final List<Widget>? action;
  final Widget? centeredWidget;
  final hasCenteredWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: hasCenteredWidget ? centeredWidget : Container(),
      backgroundColor: bgColor,
      titleSpacing: 0,
      centerTitle: true,
      actions: action,
      automaticallyImplyLeading: false,
      title: Text(title, style: TextStyle(color: Colors.black)),
      leadingWidth: 64,
      leading: Container(
        padding: EdgeInsets.only(left: 8),
        margin: EdgeInsets.all(12),
        child: SolukBackButton(),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(hasCenteredWidget ? kToolbarHeight * 2.3 : kToolbarHeight);
}
