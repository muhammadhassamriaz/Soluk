import 'package:app/module/influencer/challenges/cubit/challenges_detail_bloc/challengesdetailbloc_cubit.dart';
import 'package:app/module/influencer/challenges/model/challenges_details_modals.dart';
import 'package:app/module/influencer/challenges/view/add_challenges.dart';
import 'package:app/module/influencer/challenges/widget/challenge_states.dart';
import 'package:app/module/influencer/challenges/widget/challenges_widget.dart';
import 'package:app/module/influencer/challenges/widget/create_challenge_widget.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/empty_screen.dart';
import 'package:app/module/influencer/widgets/fab.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';
import '../widget/participants_and_rewards_widget.dart';
import 'comments_screen.dart';

class ChallengeDetailScreen extends StatefulWidget {
  static const String id = "/challengeDetail";
  final int challengeId;
  const ChallengeDetailScreen({Key? key, required this.challengeId})
      : super(key: key);

  @override
  State<ChallengeDetailScreen> createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ChallengesdetailblocCubit>(context)
        .getChallengeData(widget.challengeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, LKChallenges),
        body: BlocBuilder<ChallengesdetailblocCubit, ChallengesdetailblocState>(
          builder: (context, state) {
            if (state is ChallengesDetailsLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.grey));
            }
           else if(state is ChallengesDetailsLoaded){
          Data  item= state.blogDetailData!.responseDetails!.data![0];
              return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      '${item.assetUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    item.title!,
                    style: subTitleTextStyle(context)
                        ?.copyWith(fontSize: defaultSize.screenWidth * .050),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalisation.getTranslated(context, LKDescription),
                    style: hintTextStyle(context)?.copyWith(
                        fontSize: defaultSize.screenWidth * .044,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${item.description}',
                    style: labelTextStyle(context)?.copyWith(
                      fontSize: defaultSize.screenWidth * .040,
                    ),
                  ),
                  const SizedBox(height: 16),
                   ParticipantsAndRewardWidget(detail: item),
                  Text(
                    AppLocalisation.getTranslated(
                        context, LKChallengerValidity),
                    style: subTitleTextStyle(context)
                        ?.copyWith(fontSize: defaultSize.screenWidth * .040),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.challengeExpiry}',
                    // '12 Feb, 10:30 Pm',
                    style: labelTextStyle(context)?.copyWith(
                      fontSize: defaultSize.screenWidth * .039,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          NavRouter.push(
                            context,
                             CommentsScreen(challengeId: '${item.id}'),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    AppLocalisation.getTranslated(
                                        context, LKComments),
                                    style: subTitleTextStyle(context)?.copyWith(
                                        fontSize:
                                            defaultSize.screenWidth * .050),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 1,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '(${item.commentsCount})',
                        style: labelTextStyle(context)?.copyWith(
                          fontSize: defaultSize.screenWidth * .040,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          NavRouter.push(
                            context,
                            CommentsScreen(challengeId: '${item.id}'),
                          );
                        },
                        child: Text(
                          AppLocalisation.getTranslated(context, LKAddComment),
                          style: labelTextStyle(context)?.copyWith(
                              fontSize: defaultSize.screenWidth * .036,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      )
                    ],
                  ),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                ],
              ),
            );
           }
            return Container();
          },
        ),
      ),
    );
  }
}
