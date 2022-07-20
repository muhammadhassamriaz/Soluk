import 'package:app/module/user/widgets/text_view.dart';
import 'package:flutter/material.dart';

import '../../../../../res/constants.dart';
import '../../../widgets/user_appbar.dart';

class ActivitiesView extends StatelessWidget {
  const ActivitiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: UserAppbar(
        title: 'Activities',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            TextView(
              'Challenges',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            SizedBox(height: 16),
            ...List.generate(3, (index) => ActivityCard()),
            SizedBox(height: 20),
            TextView(
              'Workout Programs',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            SizedBox(height: 16),
            ...List.generate(3, (index) => ActivityCard()),
          ],
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            'Completed 100 pushup challenge.',
            fontSize: 16,
          ),
          SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: TextView('22,feb 2022', color: Colors.grey),
          )
        ],
      ),
    );
  }
}
