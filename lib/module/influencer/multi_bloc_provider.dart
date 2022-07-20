import 'package:app/module/influencer/challenges/cubit/badges_bloc/badgesbloc_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/challenges_bloc/challengesbloc_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/challenges_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/challenges_detail_bloc/challengesdetailbloc_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/comments_bloc/commentsbloc_cubit.dart';
import 'package:app/module/influencer/income_analytics/bloc/income_graph_bloc.dart';
import 'package:app/module/influencer/income_analytics/repo/income_graph_repo.dart';
import 'package:app/module/influencer/more/bloc/cubit/promobloc_cubit.dart';
import 'package:app/module/influencer/more/bloc/suggestion_bloc/suggestionbloc_cubit.dart';
import 'package:app/module/influencer/views_analytics/bloc/views_graph_bloc.dart';
import 'package:app/module/influencer/views_analytics/repo/views_graph_repo.dart';
import 'package:app/module/influencer/more/repo/more_repository.dart';
import 'package:app/module/influencer/subscribers/bloc/subscriber_bloc.dart';
import 'package:app/module/influencer/subscribers/repo/subscribers_repo.dart';
import 'package:app/module/influencer/workout/bloc/about_me_bloc/aboutmebloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/blog_bloc/blogbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/favorite_ingre_bloc/favorite_cubit.dart';
import 'package:app/module/influencer/workout/bloc/favorite_meal_bloc/favoritemealbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/influencer/get_influencer_bloc.dart';
import 'package:app/module/influencer/workout/bloc/influencer_bloc.dart' as bl;
import 'package:app/module/influencer/workout_programs/bloc/workout_program_bloc.dart';
import 'package:app/module/influencer/workout_programs/repo/workout_program_repo.dart';
import 'package:app/module/influencer/workout/bloc/meal_bloc/mealbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/nutrients_bloc/nutrientsbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/social_links_bloc/sociallinksbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/tags/tags_bloc.dart';
import 'package:app/module/influencer/workout/bloc/tags_bloc/tagsbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/workout_dashboard_bloc/workoutdashboardbloc_cubit.dart';
import 'package:app/module/influencer/workout/repo/get_infuencer_repo.dart';
import 'package:app/module/influencer/workout/repo/get_tags.dart';
import 'package:app/module/influencer/workout/widgets/nutrients_detail.dart';
import 'package:app/module/influencer/workout_programs/bloc/workout_program_bloc.dart';
import 'package:app/module/influencer/workout_programs/repo/workout_program_repo.dart';
import 'package:app/package/bloc_route.dart';
import 'package:app/utils/default_size_handler.dart';
import 'package:app/utils/enums.dart' as enums;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'more/cubit/suggestion_cubit.dart';
import 'my_app.dart';
import 'workout/bloc/nutrient_bloc.dart';

class InitialiseBlocs extends StatelessWidget {
  const InitialiseBlocs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LanguageBloc(enums.Language.ENGLISH)),
          BlocProvider(create: (_) => OnboardingBloc(enums.Screens.Screen_1)),
          BlocProvider(create: (_) => BottomNavBloc(enums.Action.DASHBOARD)),
          BlocProvider(create: (_) => LinkBloc([])),
          BlocProvider(create: (_) => BlogBloc([])),
          BlocProvider(create: (_) => NutrientBloc([])),
          BlocProvider(create: (_) => bl.InfluencerBloc(InfluencerInfo())),
          BlocProvider(create: (_) => IncomeGraphBloc(IncomeGraphRepo())),
          BlocProvider(create: (_) => ViewsGraphBloc(ViewsGraphRepo())),
          BlocProvider(create: (_) => SubscriberBloc(SubscriberRepo())),
          BlocProvider(
              create: (_) =>
                  GetInfluencerBloc(getInfluencerRepo: GetInfluencerRepo())),
          BlocProvider(create: (_) => TagsBloc(tagsRepo: TagsRepo())),
          BlocProvider(create: (_) => ChallengesCubit()),
          BlocProvider(create: (_) => ChallengesblocCubit()),
          BlocProvider(create: (_) => BadgesblocCubit()),
          BlocProvider(create: (_) => SuggestionblocCubit()),
          BlocProvider(create: (_) => ChallengesdetailblocCubit()),
          BlocProvider(create: (_) => FavoriteCubit()),
          BlocProvider(create: (_) => WorkoutdashboardblocCubit()),
          BlocProvider(create: (_) => PromoblocCubit()),
          BlocProvider(create: (_) => CommentsblocCubit()),
          BlocProvider(create: (_) => FavoritemealblocCubit()),
          BlocProvider(create: (_) => AboutmeblocCubit()),
          BlocProvider(create: (_) => TagsblocCubit()),
          BlocProvider(create: (_) => SociallinksblocCubit()),
          BlocProvider(create: (_) => BlogblocCubit()),
          BlocProvider(create: (_) => NutrientsblocCubit()),
          BlocProvider(create: (_) => MealblocCubit()),
          // BlocProvider(create: (_) => SuggestionCubit(const MoreRepository())),
          BlocProvider(
            create: (_) => WorkoutProgramBloc(WorkoutProgramRepo()),
          ),
          BlocProvider(
            create: (_) => SubscriberBloc(SubscriberRepo()),
          ),
          BlocProvider(create: (_) => ChallengesCubit()),
          BlocProvider(
            create: (_) => WorkoutProgramBloc(WorkoutProgramRepo()),
          ),
        ],
        child: DefaultSizeInit(
          builder: () => const MyApp(),
        ),
      ),
    );
  }
}
