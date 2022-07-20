import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/fab.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/bloc/workout_program_bloc.dart';
import 'package:app/module/influencer/workout_programs/model/get_workout_plan_response.dart';
import 'package:app/module/influencer/workout_programs/view/add_workout_program.dart';
import 'package:app/module/influencer/workout_programs/view/add_workout_program_1b.dart';
import 'package:app/module/influencer/workout_programs/widgets/main_workout_program_tile.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class WorkoutPrograms extends StatefulWidget {
  static const id = 'WorkoutProgramScreen';

  WorkoutPrograms({
    Key? key,
  }) : super(key: key);

  @override
  State<WorkoutPrograms> createState() => _WorkoutProgramsState();
}

class _WorkoutProgramsState extends State<WorkoutPrograms> {
  String selectedTab = 'All Programs';
  late TabController _tabController;

  final TextEditingController _searchController = TextEditingController();

  GetWorkoutPlansResponse? getWorkoutPlansResponse;

  List<Data> data = [];

  late final _workoutProgramBloc;

  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
    _workoutProgramBloc.add(GetWorkoutProgramsEvent());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('Load next Page');
        if (getWorkoutPlansResponse!.responseDetails.nextPageUrl != '') {
          print('Loading next Page');
          _workoutProgramBloc.add(GetWorkoutProgramsNextBackPageEvent(
              pageUrl: getWorkoutPlansResponse!.responseDetails.nextPageUrl));
        }
      }
    });
    //_tabController = TabController(vsync: this, length: 3);
  }

  Future<void> _pullRefresh() async {
    data.clear();
    if (getWorkoutPlansResponse != null) {
      getWorkoutPlansResponse!.responseDetails.totalPublished = 0;
      getWorkoutPlansResponse!.responseDetails.totalUnpublished = 0;
    }
    _workoutProgramBloc.add(GetWorkoutProgramsEvent());
  }

  @override
  Widget build(BuildContext context) {
    //_workoutProgramBloc.add(GetWorkoutProgramsEvent());
    return BlocConsumer<WorkoutProgramBloc, WorkoutProgramState>(listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is ErrorState) {
        showSnackBar(
          context,
          state.error,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      } else if (state is InternetErrorState) {
        showSnackBar(
          context,
          state.error,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      } else if (state is GetWorkoutProgramsState) {
        getWorkoutPlansResponse = state.getWorkoutPlansResponse;
        data.addAll(getWorkoutPlansResponse!.responseDetails.data);
        print('>>>>>>>>>>Data Length:${data.length}');
      }
    }, builder: (context, state) {
      return DefaultTabController(
        length: 3,
        child: ModalProgressHUD(
          inAsyncCall: state is LoadingState,
          child: Scaffold(
            backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
            body: RefreshIndicator(
              onRefresh: _pullRefresh,
              child: AppBody(
                  title: AppLocalisation.getTranslated(context, LKWorkoutPrograms),
                  bgColor: SCAFFOLD_BACKGROUND_COLOR,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.isNotEmpty
                          ? TabBar(
                              labelColor: Colors.white,
                              labelStyle: labelTextStyle(context)!.copyWith(fontSize: 10.sp),
                              unselectedLabelColor: Colors.black,
                              unselectedLabelStyle:
                                  labelTextStyle(context)!.copyWith(fontSize: 10.sp),
                              indicator: BoxDecoration(
                                  color: PRIMARY_COLOR,
                                  borderRadius:
                                      BorderRadius.circular(defaultSize.screenHeight * 0.05)),
                              tabs: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      AppLocalisation.getTranslated(context, LKAll),
                                      maxLines: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      AppLocalisation.getTranslated(context, LKPublished),
                                      maxLines: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: Text(
                                      AppLocalisation.getTranslated(context, LKUnPublished),
                                      maxLines: 1,
                                    ),
                                  ),
                                ])
                          : SizedBox(),
                      data.isNotEmpty ? SB_1H : SizedBox(),
                      data.isNotEmpty
                          ? Container(
                              height: HEIGHT_3,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  defaultSize.radius(60),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultSize.screenWidth * .02,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      decoration: InputDecoration(
                                        hintText: AppLocalisation.getTranslated(context, LKSearch),
                                        hintStyle: hintTextStyle(context),
                                        border: InputBorder.none,
                                        labelStyle: hintTextStyle(context),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: defaultSize.screenHeight * .02,
                                          horizontal: defaultSize.screenWidth * .02,
                                        ),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: defaultSize.screenWidth * .02,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: HEIGHT_1 * 1.5,
                                      width: HEIGHT_1 * 1.5,
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.search,
                                        size: defaultSize.screenWidth * .05,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SB_1H,
                      Expanded(
                        child: TabBarView(
                          children: [
                            getWorkoutPlansResponse != null
                                ? data.isNotEmpty
                                    ? ListView.builder(
                                        controller: _scrollController,
                                        shrinkWrap: true,
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        itemCount:
                                            getWorkoutPlansResponse != null ? data.length : 0,
                                        itemBuilder: (BuildContext context, int index) {
                                          return MainWorkoutProgramTile(
                                            image: data[index].assetUrl,
                                            mediaType: data[index].assetType,
                                            title: data[index].title,
                                            details:
                                                "${data[index].weeksCount} Weeks - ${data[index].exercisesCount} Workouts",
                                            numberOfViews: data[index].userViews.toString(),
                                            ratting: data[index].rating.toString(),
                                            callback: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => AddWorkoutPrograms1b(
                                                    title: 'Workout Title',
                                                    iD: data[index].id,
                                                    data: data[index],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      )
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => AddWorkoutProgram(
                                                      isEditScreen: false,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: SvgPicture.asset(PLUS_ICON)),
                                          const SizedBox(height: 14),
                                          Text(
                                            AppLocalisation.getTranslated(
                                                context, LKCreateWorkoutProgram),
                                            style: subTitleTextStyle(context)?.copyWith(
                                                fontSize: defaultSize.screenWidth * .050),
                                          ),
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                            child: Text(
                                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sollicitudin porttitor turpis non at nec facilisis lacus.",
                                              textAlign: TextAlign.center,
                                              style: hintTextStyle(context),
                                            ),
                                          ),
                                        ],
                                      )
                                : SizedBox(),
                            getWorkoutPlansResponse != null
                                ? getWorkoutPlansResponse!.responseDetails.totalPublished != 0
                                    ? Container(
                                        height: defaultSize.screenHeight * 0.7,
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          physics: const AlwaysScrollableScrollPhysics(),
                                          itemCount:
                                              getWorkoutPlansResponse != null ? data.length : 0,
                                          itemBuilder: (BuildContext context, int index) {
                                            return data[index].isActive == 1
                                                ? MainWorkoutProgramTile(
                                                    image: data[index].assetUrl,
                                                    mediaType: data[index].assetType,
                                                    title: data[index].title,
                                                    details:
                                                        "${data[index].weeksCount} Weeks - ${data[index].exercisesCount} Workouts",
                                                    numberOfViews: data[index].userViews.toString(),
                                                    ratting: data[index].rating.toString(),
                                                    callback: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) => AddWorkoutPrograms1b(
                                                            title: 'Workout Title',
                                                            iD: data[index].id,
                                                            data: data[index],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : SizedBox();
                                          },
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalisation.getTranslated(
                                                context, LKNoPublishedProgram),
                                            style: subTitleTextStyle(context)?.copyWith(
                                                fontSize: defaultSize.screenWidth * .050),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      )
                                : SizedBox(),
                            getWorkoutPlansResponse != null
                                ? getWorkoutPlansResponse!.responseDetails.totalUnpublished != 0
                                    ? Container(
                                        height: defaultSize.screenHeight * 0.7,
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          physics: const AlwaysScrollableScrollPhysics(),
                                          itemCount:
                                              getWorkoutPlansResponse != null ? data.length : 0,
                                          itemBuilder: (BuildContext context, int index) {
                                            return data[index].isActive != 1
                                                ? MainWorkoutProgramTile(
                                                    image: data[index].assetUrl,
                                                    mediaType: data[index].assetType,
                                                    title: data[index].title,
                                                    details:
                                                        "${data[index].weeksCount} Weeks - ${data[index].exercisesCount} Workouts",
                                                    numberOfViews: data[index].userViews.toString(),
                                                    ratting: data[index].rating.toString(),
                                                    callback: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) => AddWorkoutPrograms1b(
                                                            title: 'Workout Title',
                                                            iD: data[index].id,
                                                            data: data[index],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : SizedBox();
                                          },
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalisation.getTranslated(
                                                context, LKNoUnPublishedProgram),
                                            style: subTitleTextStyle(context)?.copyWith(
                                                fontSize: defaultSize.screenWidth * .050),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            floatingActionButton: getWorkoutPlansResponse != null
                ? data.isNotEmpty
                    ? FAB(
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddWorkoutProgram(
                                isEditScreen: false,
                              ),
                            ),
                          );
                        },
                      )
                    : SizedBox()
                : SizedBox(),
          ),
        ),
      );
    });
  }
}
