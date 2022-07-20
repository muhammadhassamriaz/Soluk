import 'package:app/module/influencer/workout/bloc/favorite_meal_bloc/favoritemealbloc_cubit.dart';
import 'package:app/module/influencer/workout/model/fav_meal_modal.dart';
import 'package:app/module/influencer/workout/widgets/add_favorite_meal.dart';
import 'package:app/module/influencer/workout/widgets/all_blogs.dart';
import 'package:app/module/influencer/workout/widgets/all_favorite_meals.dart';
import 'package:app/module/influencer/workout/widgets/components/favorite_meal_card.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/module/influencer/workout/widgets/favorite_detail.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/empty_screen.dart';
import 'package:app/module/influencer/widgets/item_details.dart';
import 'package:app/module/influencer/widgets/item_tile.dart';
import 'package:app/module/influencer/workout/bloc/blog_bloc.dart';
import 'package:app/module/influencer/workout/model/blog.dart';
import 'package:app/module/influencer/workout/widgets/add_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteMeals extends StatelessWidget {
  const FavoriteMeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final _favMealbloc= BlocProvider.of<FavoritemealblocCubit>(context, listen: false);
        _favMealbloc.getfavoriteMeal();
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
         bgColor:  backgroundColor,
        title: "Favorite Meals",
        body: BlocBuilder<FavoritemealblocCubit, FavoritemealblocState>(
            builder: (context, state) {
          if (state is FavoritemealLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          }
          if (state is FavoritemealEmpty) {
            return EmptyScreen(
              title: "Add Favorite Meals",
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddFavoriteMeal(),
                  ),
                );
              },
            );
          } else if (state is FavoritemealData) {
            return RefreshWidget(
              refreshController:_favMealbloc.refreshController ,
              onLoadMore: ()=>_favMealbloc.onLoadMore(),
              onRefresh: ()=>_favMealbloc.onRefresh(),
              child: ListView.builder(
                itemCount: state.favMeal?.responseDetails?.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Data item = state.favMeal!.responseDetails!.data![index];
                
                  return FavoriteMealCard(
                    favItem: item,
                    callback: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => FavoriteDetail(favItem: item)));
                    },
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
      floatingActionButton:
          BlocBuilder<FavoritemealblocCubit, FavoritemealblocState>(
        builder: (context, state) {
          return (state.favMeal?.responseDetails?.data ?? []).isNotEmpty
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AddFavoriteMeal()));
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
