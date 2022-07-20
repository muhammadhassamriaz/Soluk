import 'dart:convert';
import 'dart:io';

import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/module/influencer/workout/model/tags.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/shared_preference_manager.dart';

class GetInfluencerRepo{
  Future<GetInfluencerModel?> getInfluencerInfo() async {
  try {
      ApiResponse apiResponse  = await sl.get<WebServiceImp>().fetchGetAPI(
      endPoint: 'api/influencer/get-info',
      params: {'userId': PreferenceManager.instance.getString(PREFS_USERID)}
      // body: {},
    );
    if(apiResponse.status==APIStatus.success){
 var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    GetInfluencerModel _getInfluencerModel = GetInfluencerModel.fromJson(response);
    return _getInfluencerModel;
    }else{
      return null;
    }
   
  } catch (e) {
    print(e);
    return null;
  }
  }
}