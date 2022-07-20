import 'dart:convert';

import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:app/module/influencer/workout_programs/view/workout_day/bloc/workout_day_state.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WorkOutDayCubit extends Cubit<WorkOutDayState> {
  WorkOutDayCubit() : super(WorkOutDayInitial());
  final RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;
  int pageNumber = 1;
  onLoadMore() async {
    // pageNumber++;
    // await getAllExercises(initial: false);
    _refreshController.loadComplete();
  }

  onRefresh() async {
    // pageNumber=0;
    print("here");
    // await getAllExercises(initial: true);
    _refreshController.refreshCompleted();
  }

  getAllExercises({bool initial = true, String? id}) async {
    if (initial) {
      pageNumber = 1;
      emit(const WorkOutDayLoading());
    }
    try {
      ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
          endPoint: 'api/user/workout/week/day/exercise', //?limit=10&pageNumber=1&userId=8',
          params: {
            'workoutDayId': id!,
            //"load": ["sets", "rounds"]
          });
      var response = jsonDecode(apiResponse.data);
      print("api response code :: ${apiResponse.statusCode}");
      print(apiResponse.data);
      print(apiResponse.status);
      GetAllExerciseResponse exerciseResponse = GetAllExerciseResponse.fromJson(response);
      if (initial) {
        if ((exerciseResponse.responseDetails!.data ?? []).isEmpty) {
          emit(const WorkOutDayEmpty());
        } else {
          emit(WorkOutDayLoaded(data: exerciseResponse));
        }
      } else {
        //  FavMealsModal fav= FavMealsModal();
        state.exerciseResponse?.responseDetails!.currentPage = pageNumber;
        state.exerciseResponse?.responseDetails?.data = [
          ...state.exerciseResponse?.responseDetails?.data ?? [],
          ...exerciseResponse.responseDetails?.data ?? []
        ];
        emit(WorkOutDayLoaded(data: state.exerciseResponse));
      }
    } catch (e) {
      print("exception workout : ${e.toString()}");
      emit(WorkOutDayError());
    }
  }
}
