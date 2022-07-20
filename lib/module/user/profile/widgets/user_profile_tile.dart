import 'package:app/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/text_view.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    Key? key,
    this.onTap,
    required this.iconPath,
    required this.text,
    this.isSubscriptionCard = false,
  }) : super(key: key);
final Function? onTap;
  final String iconPath;
  final String text;
  final bool isSubscriptionCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=> onTap!(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            iconPath.contains('png')
                ? Image.asset(
                    iconPath,
                    height: 30,
                    width: 30,
                  )
                : SvgPicture.asset(iconPath),
            SizedBox(width: 12),
            TextView(
              text,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            Spacer(),
            isSubscriptionCard
                ? Container(
                    height: 30,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            )),
                        child: TextView(
                          'Manage',
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        )),
                  )
                : Icon(Icons.arrow_forward_ios_rounded, size: 16),
          ],
        ),
      ),
    );
  }
}
