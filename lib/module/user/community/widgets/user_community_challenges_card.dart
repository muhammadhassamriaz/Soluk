import 'package:flutter/material.dart';

class UserCommunityChallengesCard extends StatelessWidget {
  const UserCommunityChallengesCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage('https://picsum.photos/200/300'),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.black.withOpacity(0.3)),
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16, right: 16),
            child: Center(
                child: Text(
              'LEADING WITH THE JAB',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }
}
