import 'package:flutter/material.dart';


class CommunityFriendsTile extends StatelessWidget {
  const CommunityFriendsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
            NetworkImage('https://picsum.photos/200/300'),
            radius: 24,
          ),
          SizedBox(width: 10),
          Text(
            'John Doe',
            style:
            TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, size: 16),
        ],
      ),
    );
  }
}