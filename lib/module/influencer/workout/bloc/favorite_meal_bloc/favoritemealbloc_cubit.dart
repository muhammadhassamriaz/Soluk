import 'dart:async';
import 'dart:convert';

import 'package:app/module/influencer/workout/model/fav_meal_modal.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/shared_preference_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'favoritemealbloc_state.dart';

class FavoritemealblocCubit extends Cubit<FavoritemealblocState> {
  FavoritemealblocCubit() : super(FavoritemealblocInitial());
  RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;
  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();
  Stream<ProgressFile> get progressStream => progressCont.stream;
  StreamSink<ProgressFile> get _progressSink => progressCont.sink;
  Future<bool> addFavoriteMeal(
      Map<String, String> body, List<String> fields, List<String> paths) async {
    print(body);
    // return false;
    BotToast.showLoading();
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .
        // postVideosPictures(
        postdioVideosPictures(
            onUploadProgress: (p) {
              if (p.done == p.total) {
                _progressSink.add(ProgressFile(done: 0, total: 0));
              } else {
                _progressSink.add(p);
              }
            },
            endPoint: 'api/user/add-fav-meal',
            body: body,
            fileKeyword: fields,
            files: paths);
    BotToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      getfavoriteMeal();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateFavoriteMeal(
      Map<String, String> body, List<String> fields, List<String> paths) async {
    BotToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().
    // postVideosPictures(
      postdioVideosPictures(
            onUploadProgress: (p) {
              print(((p.done/p.total)*100).toInt());
              if (p.done == p.total) {
                _progressSink.add(ProgressFile(done: 0, total: 0));
              } else {
                _progressSink.add(p);
              }
            },
        endPoint: 'api/user/update-fav-meal',
        body: body,
        fileKeyword: fields,
        files: paths);
    BotToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      getfavoriteMeal();
      return true;
    } else {
      return false;
    }
  }

  int pageNumber = 1;
  onLoadMore() async {
    pageNumber++;
    await getfavoriteMeal(initial: false);
    _refreshController.loadComplete();
  }

  onRefresh() async {
    // pageNumber=0;
    // await getfavoriteMeal(initial: false);
    _refreshController.refreshCompleted();
  }

  getfavoriteMeal({bool initial = true}) async {
    if (initial) {
      pageNumber = 1;
      emit(const FavoritemealLoading());
    }

    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
        endPoint: 'api/user/get-fav-meal', //?limit=10&pageNumber=1&userId=8',
        params: {
          'limit': '10',
          'pageNumber': '$pageNumber',
          'userId': PreferenceManager.instance.getString(PREFS_USERID),
        });
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    FavMealsModal _favMeal = FavMealsModal.fromJson(response);
    if (initial) {
      if ((_favMeal.responseDetails?.data ?? []).isEmpty) {
        emit(const FavoritemealEmpty());
      } else {
        emit(FavoritemealData(favMeals: _favMeal));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      state.favMeal?.responseDetails!.currentPage = pageNumber;
      state.favMeal?.responseDetails?.data = [
        ...state.favMeal?.responseDetails?.data ?? [],
        ..._favMeal.responseDetails?.data ?? []
      ];
      emit(FavoritemealData(favMeals: state.favMeal));
    }
  }
}
