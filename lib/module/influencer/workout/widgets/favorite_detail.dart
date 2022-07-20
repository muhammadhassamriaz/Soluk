import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/influencer/workout/model/fav_meal_modal.dart' as fav;
import 'package:app/module/influencer/workout/widgets/add_favorite_meal.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FavoriteDetail extends StatefulWidget {
  static const id = 'ProgramDetail';
  final fav.Data favItem;
  const FavoriteDetail({Key? key, required this.favItem}) : super(key: key);

  @override
  State<FavoriteDetail> createState() => _FavoriteDetailState();
}

class _FavoriteDetailState extends State<FavoriteDetail> {
  // bool _switchValue = true;
  @override
  Widget build(BuildContext context) {
    // final _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
    // _workoutProgramBloc.add(SubscribersListLoadingEvent());
    return Scaffold(
        body:
            // BlocConsumer<WorkoutProgramBloc, WorkoutProgramState>(
            //   listener: (context, state) {
            //     // if (state is SubscribersListLoadingState) {
            //     //   Future.delayed(const Duration(seconds: 2), () {
            //     //     _workoutProgramBloc.add(SubscribersListLoadedEvent());
            //     //   });
            //     // }
            //   },
            //   builder: (context, state) {
            //     // if (state is SubscribersListLoadingState) {
            //     //   return const Center(
            //     //     child: CircularProgressIndicator(
            //     //       color: Colors.grey,
            //     //     ),
            //     //   );
            //     // }
            //     // if (state is SubscribersListLoadedState) {
            //       return
            Column(
      children: [
        SB_1H,
        SB_1H,
        Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: HEIGHT_5 * 3.5,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.favItem.imageUrl??''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SolukBackButton(
                        callback: () {},
                      ),
                      Text(
                        'Favorite Meals',
                        style: subTitleTextStyle(context)?.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                      SB_5W,
                      // InkWell(
                      //   onTap: () {},
                      //   child: Container(
                      //     height: defaultSize.screenWidth * .09,
                      //     width: defaultSize.screenWidth * .09,
                      //     decoration:const BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.only(
                      //         topRight: Radius.circular(10.0),
                      //         topLeft: Radius.circular(10.0),
                      //         bottomLeft: Radius.circular(10.0),
                      //         bottomRight: Radius.circular(10.0),
                      //       ),
                      //     ),
                      //     child: Center(
                      //       // child: Icon(
                      //       //   Icons.delete_outline_outlined,
                      //       //   color: Colors.red,
                      //       //   size: defaultSize.screenWidth * .05,
                      //       // ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: HEIGHT_5 * 1.5,
                ),
                Container(
                  width: double.maxFinite,
                  height: defaultSize.screenHeight * 0.7,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Title',
                                    maxLines: 1,
                                    style: hintTextStyle(context)?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.favItem.title ?? '',
                                    maxLines: 1,
                                    style: hintTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  var route=MaterialPageRoute(builder: (context)=> AddFavoriteMeal(favItem: widget.favItem,));
                                  Navigator.push(context, route);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (_) =>
                                  //       AddWorkoutProgram(
                                  //             isEditScreen: true,
                                  //             title:
                                  //                 'Bodywieght for Uper Boday',
                                  //             description:
                                  //                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam dui nascetur vulputate vehicula odio vestibulum tellus scelerisque. Id quam sit ridiculus arcu arcu, egestas purus. Morbi fermentum sollicitudin sagittis gravida tempor, risus. Nunc dictum pellentesque feugiat sed vitae scelerisque risus, elementum.',
                                  //             completionBadge: '',
                                  //             difficultyLevel: '',
                                  //             programType: '',
                                  //           )),
                                  // );
                                },
                                child: Container(
                                  height: defaultSize.screenWidth * .09,
                                  width: defaultSize.screenWidth * .09,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(30.0),
                                      topLeft: Radius.circular(30.0),
                                      bottomLeft: Radius.circular(30.0),
                                      bottomRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                      size: defaultSize.screenWidth * .05,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SB_1H,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // item(context, '423', 'Calories'),
                              item(context, '${widget.favItem.proteins}',
                                  'Protiens'),
                              item(context, '${widget.favItem.fats}', 'Fats'),
                              item(context, '${widget.favItem.carbs}', 'Carbs'),
                            ],
                          ),
                          SB_1H,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              item(context, '${widget.favItem.mealType}',
                                  'Meal Type',
                                  verticalDirection: VerticalDirection.up),
                              item(context, 'Calories',
                                  '${widget.favItem.calories}',
                                  verticalDirection: VerticalDirection.up),
                              item(context, '${widget.favItem.mealLevel}',
                                  'Meal Classification',
                                  verticalDirection: VerticalDirection.up),
                              // item(context, '423', 'Carbs'),
                            ],
                          ),
                          SB_1H,
                          Text(
                            'Method & Instruction',
                            maxLines: 1,
                            style: hintTextStyle(context)?.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${widget.favItem.method}',
                            style: hintTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          ),
                          SB_1H,
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            // SingleChildScrollView(
            //   physics: const ScrollPhysics(),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.only(top: 2.h),
            //         child: WorkoutProgramTile(
            //           image: WORKOUT_COVER2,
            //           title: "Workout Title",
            //           description: "Body Workout Programs",
            //           callback: () {},
            //         ),
            //       ),
            //       Text(
            //         AppLocalisation.getTranslated(
            //             context, LKWorkoutWeek),
            //         style: subTitleTextStyle(context)?.copyWith(
            //           color: Colors.black,
            //           fontSize: 18.sp,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    )
        // ;
        // }
        // return Container();
        // },
        // ),
        );
  }

  item(BuildContext context, String title, String subTitle,
      {VerticalDirection verticalDirection = VerticalDirection.down}) {
    return Column(
      verticalDirection: verticalDirection,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: subTitleTextStyle(context)?.copyWith(
              color: Colors.black,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold),
        ),
        Text(
          subTitle,
          style: subTitleTextStyle(context)?.copyWith(
            color: Colors.grey,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}
