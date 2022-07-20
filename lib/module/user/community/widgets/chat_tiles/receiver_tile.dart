import 'package:flutter/material.dart';

import '../../../../../res/color.dart';

class ReceiverTile extends StatelessWidget {
  const ReceiverTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12,right: 26),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/200/300'),
            radius: 21,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mus maecenas in rutrum consequat elementum et. Lobortis tempus, urna accumsan massa sit blandit ac velit arcu.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '11:30 am',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
