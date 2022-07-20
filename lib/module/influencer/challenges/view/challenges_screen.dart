import 'package:app/module/influencer/challenges/cubit/challenges_bloc/challengesbloc_cubit.dart';
import 'package:app/module/influencer/challenges/view/add_challenges.dart';
import 'package:app/module/influencer/challenges/widget/challenges_widget.dart';
import 'package:app/module/influencer/challenges/widget/create_challenge_widget.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';

class ChallengesScreen extends StatefulWidget {
  static const String id = "/challenges";

  const ChallengesScreen({Key? key}) : super(key: key);

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  dynamic challengesCubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: AppBody(
          bgColor: backgroundColor,
          title: AppLocalisation.getTranslated(context, LKChallenges),
          body: BlocBuilder<ChallengesblocCubit, ChallengesblocState>(
            builder: (context, state) {
              if (state is ChallengesLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.grey,
                ));
              } else if (state is ChallengesEmpty) {
                return const CreateChallengeWidget();
              }
              if (state is ChallengesLoaded) {
                return const ChallengesWidget();
              }
              return Container();
            },
          )),
      floatingActionButton:
          BlocBuilder<ChallengesblocCubit, ChallengesblocState>(
        builder: (context, state) {
          if (state is! ChallengesEmpty) {
            return FAB(callback: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AddChallenges()));
            });
          }
          return Container();
        },
      ),
    );
  }
}

class CreateChallengeClass {
  static bool _isChallengeCreated = false;

  static bool get isChallengeCreated => _isChallengeCreated;

  static challengeCreated() {
    _isChallengeCreated = true;
  }
}
