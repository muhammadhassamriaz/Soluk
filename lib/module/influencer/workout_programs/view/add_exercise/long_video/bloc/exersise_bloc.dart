import 'package:app/module/influencer/workout_programs/view/add_exercise/long_video/bloc/excerise_state.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit() : super(ExerciseInitial());
  final RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;

  Future<bool> addLongVideoExercise(
      Map<String, String> body, List<String> fields, List<String> paths,
      {weekID, workOutID, dayID}) async {
    var endPoint = "/api/user/workout/$workOutID/week/$weekID/day/$dayID/exercise/longvideo";
    BotToast.showLoading();
    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .postVideosPictures(endPoint: endPoint, body: body, fileKeyword: fields, files: paths);
      BotToast.closeAllLoading();
      print(apiResponse.data);
      print(apiResponse.status);
      print('::::::::::::::::::::::');
      if (apiResponse.status == APIStatus.success) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  Future<bool> updateExercise(Map<String, String> body, List<String> fields, List<String> paths,
      {id}) async {
    try {
      BotToast.showLoading();
      print("Fields : ${fields.length}");
      print("path : ${paths.length}");
      print("body : $body");
      ApiResponse apiResponse = await sl.get<WebServiceImp>().postVideosPictures(
          endPoint: 'api/user/workout/week/day/exercise/longvideo/$id',
          body: body,
          fileKeyword: fields,
          files: paths);
      BotToast.closeAllLoading();
      print(apiResponse.data);
      print(apiResponse.status);
      print('::::::::::::::::::::::');
      if (apiResponse.status == APIStatus.success) {
        //getBlogs();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      BotToast.closeAllLoading();

      return false;
    }
  }

  // Future<bool> delete(String id) async {
  //   BotToast.showLoading();
  //   ApiResponse apiResponse =
  //       await sl.get<WebServiceImp>().delete(endPoint: 'api/user/delete-user-blog/$id');
  //   BotToast.closeAllLoading();
  //   print(apiResponse.data);
  //   print(apiResponse.status);
  //   print('::::::::::::::::::::::');
  //   if (apiResponse.status == APIStatus.success) {
  //
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
