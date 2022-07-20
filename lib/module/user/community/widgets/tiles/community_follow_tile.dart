import 'package:flutter/material.dart';

class CommunityFollowTile extends StatelessWidget {
  const CommunityFollowTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/200/300'),
            radius: 24,
          ),
          SizedBox(width: 10),
          Text(
            'John Doe',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Container(
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff498AEE),
                padding: EdgeInsets.symmetric(horizontal: 18),
                shape: StadiumBorder(),
              ),
              onPressed: () {},
              child: Text(
                '+ Follow',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
