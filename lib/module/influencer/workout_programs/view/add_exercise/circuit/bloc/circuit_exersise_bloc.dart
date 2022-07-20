import 'dart:convert';

import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:app/module/influencer/workout_programs/model/workout_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_excerise_state.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/model/round_exercise_request_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/model/rounds_response.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CircuitWorkOutCubit extends Cubit<CircuitWorkOutState> {
  CircuitWorkOutCubit() : super(ExerciseInitial());
  final RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;

  Future<bool> addSupperSet({exerciseRequestModel}) async {
    var data = {
      'title': exerciseRequestModel.workoutTitle,
      //'exerciseTime': exerciseRequestModel.exerciseTime,
      'assetType': exerciseRequestModel.assetType,
    };
    var endPoint =
        '/api/user/workout/${exerciseRequestModel.workoutID}/week/${exerciseRequestModel.weekID}/day/${exerciseRequestModel.dayID}/exercise/supersets';
    BotToast.showLoading();
    try {
      print("image file : ${exerciseRequestModel.media}");

      ApiResponse apiResponse = await WebServiceImp.postDataMultiPart(data,
          endPoint: endPoint, image: exerciseRequestModel.media);

      BotToast.closeAllLoading();
      print("api response :: ${apiResponse.data}");

      if (apiResponse.status == APIStatus.success) {
        Data data = Data.fromJson(apiResponse.data['responseDetails']);
        emit(ExerciseLoaded(data: data));
        return true;
      } else {
        emit(ExerciseError(message: apiResponse.errorMessage));
        return false;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      print("exc : ${e.toString()}");
      emit(ExerciseError(message: e.toString()));
      return false;
    }
  }

  Future<bool> addRounds({Map<String, dynamic>? data, WorkOutModel? exerciseData}) async {
    var endPoint = '/api/user/workout/week/day/exercise/${exerciseData!.exerciseId}/subType/round';
    BotToast.showLoading();
    try {
      ApiResponse apiResponse = await WebServiceImp.postData(body: data!, endPoint: endPoint);

      BotToast.closeAllLoading();
      print("api response :: ${apiResponse.data}");

      if (apiResponse.status == APIStatus.success) {
        var jsonResponse = apiResponse.data['responseDetails'];
        print("json response : ${jsonResponse.length}");
        List<RoundsData> roundsList =
            jsonResponse.map<RoundsData>((data) => RoundsData.fromJson(data)).toList();
        print("rounds list :${roundsList.length}");
        emit(RoundsLoaded(roundsList: roundsList));
        return true;
      } else {
        emit(ExerciseError(message: apiResponse.errorMessage));
        return false;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      print("exc : ${e.toString()}");
      emit(ExerciseError(message: e.toString()));
      return false;
    }
  }

  Future<bool> addRoundsExercise({RoundExerciseRequest? exerciseData}) async {
    print("exercise type : ${exerciseData!.exerciseType!}");
    var data = {
      'title': exerciseData.workoutTitle,
      'assetsType': exerciseData.assetType,
      'instructions': exerciseData.description,
      'type': exerciseData.exerciseType,
    };
    if (exerciseData.exerciseType == "Time") {
      print("her");
      data.addAll({'setTime': exerciseData.exerciseValue});
    } else if (exerciseData.exerciseType == "Reps") {
      data.addAll(
          {'noOfReps': exerciseData.exerciseValue, 'dropSet': exerciseData.dropSet.toString()});
    } else if (exerciseData.exerciseType == "Custom") {
      data.addAll({'count': exerciseData.exerciseCustomValue});
    }
    print("body : $data");
    var endPoint =
        '/api/user/workout/week/day/exercise/${exerciseData.exerciseId}/subType/${exerciseData.roundId}/set';
    BotToast.showLoading();
    try {
      ApiResponse apiResponse = await WebServiceImp.postDataMultiPart(data,
          endPoint: endPoint, image: exerciseData.media);
      BotToast.closeAllLoading();
      print("api response :: ${apiResponse.data}");

      if (apiResponse.status == APIStatus.success) {
        var jsonResponse = apiResponse.data['responseDetails'];
        print("json response : ${jsonResponse.length}");
        List<RoundsData> roundsList =
            jsonResponse.map<RoundsData>((data) => RoundsData.fromJson(data)).toList();
        print("rounds list :${roundsList.length}");
        emit(RoundsLoaded(roundsList: roundsList));
        return true;
      } else {
        emit(ExerciseError(message: apiResponse.errorMessage));
        return false;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      print("exc : ${e.toString()}");
      emit(ExerciseError(message: e.toString()));
      return false;
    }
  }

  getRoundExercises({bool initial = true, String? id}) async {
    try {
      BotToast.showLoading();
      ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetBody(
          endPoint: 'api/user/workout/week/day/exercise', //?limit=10&pageNumber=1&userId=8',
          body: {'exerciseId': id, 'load': "sets"});
      BotToast.closeAllLoading();
      var response = jsonDecode(apiResponse.data);
      print("api response code :: ${apiResponse.statusCode}");
      print(apiResponse.data);
      print(apiResponse.status);

      if (apiResponse.status == APIStatus.success) {
        GetAllExerciseResponse exerciseResponse = GetAllExerciseResponse.fromJson(response);
        emit(RoundExerciseLoaded(data: exerciseResponse));
      } else {
        emit(ExerciseError(message: apiResponse.errorMessage));
      }
    } catch (e) {
      print("exception workout : ${e.toString()}");
      emit(ExerciseError(message: e.toString()));
      BotToast.closeAllLoading();
    }
  }

  Future<bool> putRoundRestTime({String? time, exerciseId, exerciseSubType}) async {
    try {
      print("rest time : $time");
      BotToast.showLoading();
      ApiResponse apiResponse = await sl.get<WebServiceImp>().callPutAPI(
          endPoint:
              'api/user/workout/week/day/exercise/$exerciseId/subType/exerciseSubType/$exerciseSubType', //?limit=10&pageNumber=1&userId=8',
          body: {'restTime': time});
      BotToast.closeAllLoading();

      if (apiResponse.status == APIStatus.success) {
        Fluttertoast.showToast(msg: "Time added successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: apiResponse.errorMessage!);
        return false;
      }
    } catch (e) {
      print("exception workout : ${e.toString()}");
      Fluttertoast.showToast(msg: e.toString());
      BotToast.closeAllLoading();
      return false;
    }
  }

  Future<bool> addTimebaseSuperSet({Map<String, dynamic>? data, WorkOutModel? exerciseData}) async {
    var endPoint =
        '/api/user/workout/week/day/exercise/${exerciseData!.exerciseId}/subType/timebased';
    BotToast.showLoading();
    try {
      ApiResponse apiResponse = await WebServiceImp.postData(body: data!, endPoint: endPoint);

      BotToast.closeAllLoading();
      print("api response :: ${apiResponse.data}");

      if (apiResponse.status == APIStatus.success) {
        var jsonResponse = apiResponse.data['responseDetails'];
        print("json response : ${jsonResponse.length}");
        List<RoundsData> roundsList =
            jsonResponse.map<RoundsData>((data) => RoundsData.fromJson(data)).toList();
        print("rounds list :${roundsList.length}");
        emit(RoundsLoaded(roundsList: roundsList));
        return true;
      } else {
        emit(ExerciseError(message: apiResponse.errorMessage));
        return false;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      print("exc : ${e.toString()}");
      emit(ExerciseError(message: e.toString()));
      return false;
    }
  }
}
