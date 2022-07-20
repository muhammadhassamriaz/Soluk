import 'package:flutter/material.dart';

import '../../../../res/color.dart';
import '../../../../res/constants.dart';
import '../../widgets/user_appbar.dart';
import 'friends_detais_button.dart';


class FriendsDetailsProfileCard extends StatelessWidget {
  const FriendsDetailsProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 18,vertical: 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width : double.infinity,
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                            NetworkImage('https://picsum.photos/200/300'),
                            radius: 30,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'John Doe',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 3,
                      child: Column(
                        children: [
                          Icon(Icons.info_outline),
                          Text(
                            'Report',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                  alignment: Alignment.bottomRight,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    children: [
                      SocialAccountWidget(
                        iconPath: 'assets/images/img_insta.png',
                        userName: '@Jhon12',
                      ),
                      Spacer(),
                      SocialAccountWidget(
                        iconPath: 'assets/images/img_snapchat.png',
                        userName: '@Jhon12',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FriendsDetailsButton(
                      title: 'Message',
                      onPressed: (){},
                    ),
                    FriendsDetailsButton(
                      title: 'Unfollow',
                      onPressed: (){},
                      textColor: PRIMARY_COLOR,
                      isOutlinedButton: true,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SocialAccountWidget extends StatelessWidget {
  const SocialAccountWidget({
    required this.iconPath,
    required this.userName,
    Key? key,
  }) : super(key: key);
  final String userName;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          iconPath,
          height: 34,
          width: 34,
        ),
        SizedBox(width: 10),
        Text(
          userName,
          style: TextStyle(fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}