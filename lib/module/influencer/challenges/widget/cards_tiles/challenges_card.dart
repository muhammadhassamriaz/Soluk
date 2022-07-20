import 'package:app/module/influencer/challenges/model/challenges_model.dart';
import 'package:app/module/influencer/challenges/view/challenges_detail_screen.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';

import '../../../../../res/constants.dart';
import '../../../../../res/globals.dart';

class ChallengesCard extends StatefulWidget {
  const ChallengesCard({Key? key, required this.challengesModel})
      : super(key: key);
  final ChallengesModel challengesModel;

  @override
  State<ChallengesCard> createState() => _ChallengesCardState();
}

class _ChallengesCardState extends State<ChallengesCard> {
  Color getColor(String status) {
    if (status == 'Completed') {
      return const Color(0xff7EEE49);
    } else if (status == 'Rejected') {
      return const Color(0xffF85656);
    }
    return const Color(0xff498AEE);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavRouter.push(
            context,
            ChallengeDetailScreen(
              challengeId: widget.challengesModel.id,
            ));
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: double.maxFinite,
            height: HEIGHT_4 + HEIGHT_4,

            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            // margin: const EdgeInsets.only(bottom: 16),
            // height: HEIGHT_5 + HEIGHT_2,
            // width: double.maxFinite,
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BORDER_CIRCULAR_RADIUS * 2,
            // ),
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              children: [
                Container(
                  height: HEIGHT_5 + HEIGHT_4,
                  width: WIDTH_5 * 3.2,
                  decoration: BoxDecoration(
                    borderRadius: BORDER_CIRCULAR_RADIUS * 2,
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.challengesModel.imageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(widget.challengesModel.name,
                            style: labelTextStyle(context)?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: defaultSize.screenWidth * .042)),
                      ),
                      Text(widget.challengesModel.status,
                          style: TextStyle(
                              color: getColor(widget.challengesModel.status),
                              fontSize: 15)),
                    ],
                  ),
                ),
                // const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: WIDTH_2,
                ),
                SB_1W,
              ],
            ),
          ),
          SB_1H
        ],
      ),
    );
  }
}
