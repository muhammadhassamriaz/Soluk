import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/empty_screen.dart';
import 'package:app/module/influencer/widgets/item_details.dart';
import 'package:app/module/influencer/widgets/item_tile.dart';
import 'package:app/module/influencer/workout/bloc/nutrient_bloc.dart';
import 'package:app/module/influencer/workout/bloc/nutrients_bloc/nutrientsbloc_cubit.dart';
import 'package:app/module/influencer/workout/model/nutrients.dart';
import 'package:app/module/influencer/workout/model/nutrients_modal.dart';
import 'package:app/module/influencer/workout/widgets/add_nutrient.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/module/influencer/workout/widgets/nutrients_detail.dart';
import 'package:app/module/influencer/workout/widgets/nutrients_plans.dart';
import 'package:app/module/influencer/workout_programs/widgets/plan_title.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NutrientsPlan extends StatelessWidget {
  const NutrientsPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nutrientsbloc = BlocProvider.of<NutrientsblocCubit>(context);
    nutrientsbloc.getNutrientsBlogs();
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
        bgColor: backgroundColor,
        title: "Nutrients Plan",
        body: BlocBuilder<NutrientsblocCubit, NutrientsblocState>(
            builder: (_, state) {
          if (state is NutrientsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          } else if (state is NutrientsblocEmpty) {
            return EmptyScreen(
              title: "Add Nutrients",
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddNutrients(),
                  ),
                );
              },
            );
          } else if (state is NutrientsblocLoaded) {
            return RefreshWidget(
              refreshController: nutrientsbloc.refreshController,
              onLoadMore: () => nutrientsbloc.onLoadMore(),
              onRefresh: () => nutrientsbloc.onRefresh(),
              child: ListView.builder(
                itemCount:
                    state.nutrientsData?.responseDetails?.data?.length ?? 0,
                itemBuilder: (ctx, i) {
                  Data item = state.nutrientsData!.responseDetails!.data![i];
                  return PlanTile(
                    image: item.imageUrl!,
                    title: item.title!,
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                NutrientsDetail(nutrientsData: item)),
                      );
                    },
                  );
                },
              ),
            );
          }
          return Container();
        }),
      ),
      floatingActionButton: BlocBuilder<NutrientsblocCubit, NutrientsblocState>(
        builder: (context, snapshot) {
          return snapshot is! NutrientsblocEmpty
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddNutrients(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.add,
                    size: WIDTH_4,
                  ),
                  backgroundColor: PRIMARY_COLOR,
                )
              : Container();
        },
      ),
    );
  }
}
