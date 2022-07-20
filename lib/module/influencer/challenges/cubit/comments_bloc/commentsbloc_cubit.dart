import 'dart:convert';

import 'package:app/module/influencer/challenges/model/comments_modal.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'commentsbloc_state.dart';

class CommentsblocCubit extends Cubit<CommentsblocState> {
  CommentsblocCubit() : super(CommentsblocInitial());
  final RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;
  int pageNumber = 1;
  Future<bool> addComment(
    String challengeId,
    String descrip,
  ) async {
    BotToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
      endPoint: 'api/user/challenges/35/comments',
      body: {"description": descrip},
    );
    BotToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      pageNumber = 1;
      getComments(challengeId, initial: false, refresh: true);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete(String challengeId, String id) async {
    // BotToast.showLoading();
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .delete(endPoint: 'api/user/challenges/$challengeId/comments/$id');
    // BotToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      pageNumber = 1;
      getComments(challengeId, initial: false, refresh: true);
      return true;
    } else {
      return false;
    }
  }

  onLoadMore(String challengeId) async {
    pageNumber++;
    await getComments(challengeId, initial: false);
    _refreshController.loadComplete();
  }

  onRefresh(String challengeId) async {
    pageNumber = 1;
    await getComments(challengeId, initial: false, refresh: true);
    _refreshController.refreshCompleted();
  }

  Future<void> getComments(String challengeId,
      {bool initial = true, bool refresh = false}) async {
    print('//////////////////');
    if (initial) {
      pageNumber = 1;
      emit(const CommentsLoading());
    }
    print('//////////////////');

    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
        endPoint: 'api/user/challenges/$challengeId/comments',
        params: {
          'limit': '20',
          'pageNumber': '$pageNumber',
          // 'userId': PreferenceManager.instance.getString(PREFS_USERID),
          // 'isNutritionBlog': "0"
        });
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    CommentsModal _commentsData = CommentsModal.fromJson(response);
    if (initial || refresh) {
      if ((_commentsData.responseDetails?.data ?? []).isEmpty) {
        emit(const CommentsEmpty());
      } else {
        emit(CommentsLoaded(commentsData: _commentsData));
      }
    } else {
      state.commentsData?.responseDetails!.currentPage = pageNumber;
      state.commentsData?.responseDetails?.data = [
        ...state.commentsData?.responseDetails?.data ?? [],
        ..._commentsData.responseDetails?.data ?? []
      ];
      emit(CommentsLoaded(commentsData: state.commentsData));
    }
  }
}
