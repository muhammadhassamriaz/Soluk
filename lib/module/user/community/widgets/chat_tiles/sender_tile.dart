import 'package:flutter/material.dart';

class SenderTile extends StatelessWidget {
  const SenderTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 26),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Magna sagittis scelerisque sed imperdiet in nec tellus eu. hac elementum. Semper aliquam eget tristique congue aliquam mi tellus.',
                    style: TextStyle(color: Colors.black),
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
          SizedBox(width: 4),
          CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/200/300'),
            radius: 21,
          ),
        ],
      ),
    );
  }
}
