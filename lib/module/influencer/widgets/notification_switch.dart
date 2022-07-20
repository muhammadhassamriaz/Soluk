
import 'package:flutter/cupertino.dart';

class NotificationSwitch extends StatefulWidget {
  const   NotificationSwitch({Key? key}) : super(key: key);

  @override
  _NotificationSwitchState createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  bool notificationValue = false;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: CupertinoSwitch(
        value: notificationValue,
        onChanged: (_) {
          notificationValue = _;
          setState(() {});
        },
      ),
    );
  }
}
