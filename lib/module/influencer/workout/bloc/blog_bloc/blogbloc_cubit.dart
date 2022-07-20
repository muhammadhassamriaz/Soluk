import 'dart:async';
import 'dart:convert';

import 'package:app/module/influencer/workout/model/blog_modal.dart';
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

part 'blogbloc_state.dart';

class BlogblocCubit extends Cubit<BlogblocState> {
  BlogblocCubit() : super(BlogblocInitial());
  final RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;
  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();
  Stream<ProgressFile> get progressStream => progressCont.stream;
  StreamSink<ProgressFile> get _progressSink => progressCont.sink;
  int pageNumber = 1;

  onLoadMore() async {
    print('loaddddddddd');
    pageNumber++;
    await getBlogs(initial: false);
    _refreshController.loadComplete();
  }

  onRefresh() async {
    pageNumber = 1;
    await getBlogs(initial: false);
    _refreshController.refreshCompleted();
  }

  Future<bool> addBlog(
      Map<String, String> body, List<String> fields, List<String> paths) async {
    BotToast.showLoading();
    ApiResponse apiResponse =
        await sl.get<WebServiceImp>().postdioVideosPictures(
            onUploadProgress: (p) {
              if (p.done == p.total) {
                _progressSink.add(ProgressFile(done: 0, total: 0));
              } else {
                _progressSink.add(p);
              }
            },
            // .postVideosPictures(
            endPoint: 'api/user/add-user-blog',
            body: body,
            fileKeyword: fields,
            files: paths);
    BotToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      getBlogs();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateBlog(
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
        endPoint: 'api/user/update-user-blog',
        body: body,
        fileKeyword: fields,
        files: paths);
    BotToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      getBlogs();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete(String id) async {
    BotToast.showLoading();
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .delete(endPoint: 'api/user/delete-user-blog/$id');
    BotToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      getBlogs();
      return true;
    } else {
      return false;
    }
  }

  getBlogs({bool initial = true}) async {
    if (initial) {
      pageNumber = 1;
      emit(const BlogblocLoading());
    }

    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
        endPoint: 'api/user/get-user-blog', //?limit=10&pageNumber=1&userId=8',
        params: {
          'limit': '20',
          'pageNumber': '$pageNumber',
          'userId': PreferenceManager.instance.getString(PREFS_USERID),
          'isNutritionBlog': "0"
        });
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    BlogsModal _blogData = BlogsModal.fromJson(response);
    if (initial) {
      if ((_blogData.responseDetails?.data ?? []).isEmpty) {
        emit(const BlogblocEmpty());
      } else {
        emit(BlogblocLoaded(blogData: _blogData));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      state.blogData?.responseDetails!.currentPage = pageNumber;
      state.blogData?.responseDetails?.data = [
        ...state.blogData?.responseDetails?.data ?? [],
        ..._blogData.responseDetails?.data ?? []
      ];
      emit(BlogblocLoaded(blogData: state.blogData));
    }
  }
}
