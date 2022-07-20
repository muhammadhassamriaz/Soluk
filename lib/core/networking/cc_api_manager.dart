// @dart=2.9
import 'package:app/core/networking/standard_response.dart';
import 'package:dio/dio.dart';

import 'auth_manager.dart';
import 'rest_api_helper.dart';

class CCApiManager {
  RestApiHelper _helper;
  String _baseUrl;

  CCApiManager._privateConstructor();
  static final CCApiManager instance = CCApiManager._privateConstructor();

  void initialize(String baseUrl) {
    _helper = RestApiHelper();
    _baseUrl = baseUrl;
  }

  Future<StandardResponse> request(
    String path,
    HttpMethod method,
    AuthenticationType type,
    Map<String, dynamic> params,
  ) async {
    return requestWithUrl("$_baseUrl$path", method, type, params);
  }

  Future<StandardResponse> requestWithUrl(
    String url,
    HttpMethod method,
    AuthenticationType type,
    Map<String, dynamic> params,
  ) async {
    Map<String, String> headers = new Map<String, String>();

    headers.addAll(AuthManager.instance.authHeaders);
    print("headers : $headers");

    if (params == null) {
      params = new Map<String, String>();
    }

    Response response;

    switch (method) {
      case HttpMethod.GET:
        response = await _helper.get(url, headers: headers, body: params);
        break;
      case HttpMethod.POST:
        response = await _helper.post(url, headers: headers, body: params);
        break;
      case HttpMethod.PUT:
        response = await _helper.put(url, headers: headers, body: params);
        break;
      case HttpMethod.DELETE:
        break;
      default:
        break;
    }

    print("API RespOnse : $response");
    try {
      final st = _parseResponse(response);
      print("st : ${st.message}");
      if (st.status != 1) {
        print("status not 200 : ${st.message}");
        throw (st.getMessage());
      }
      return st;
    } catch (e) {
      //print(response.data);
      print("api exp :: ${e.toString()}");
      throw e;
    }
  }

  StandardResponse _parseResponse(Response response) {
    try {
      print("Response : ${response.data}");
      // final parsed = json.decode(response.data);
      final standardResponse = StandardResponse.fromJson(response.data);
      return standardResponse;
    } catch (e) {
      print("Response ex : $e");
      throw e;
    }
  }
}

enum HttpMethod { GET, POST, PUT, DELETE }

enum AuthenticationType { POST, PRE, OPEN }
