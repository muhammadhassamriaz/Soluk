import 'package:json_annotation/json_annotation.dart';

part 'standard_response.g.dart';

@JsonSerializable()
class StandardResponse {
  // fields go here
  String? status;
  dynamic message;
  int? responseCode;
  dynamic responseDetails;

  StandardResponse({this.responseDetails, this.message, this.status, this.responseCode});

  Map<String, dynamic> dataAsMap() {
    return responseDetails as Map<String, dynamic>;
  }

  String getMessage() {
    if (message is List && (message as List).isNotEmpty) {
      return (message as List)[0];
    } else if (message is String) {
      return message as String;
    }
    return "Unknown";
  }

  factory StandardResponse.fromJson(Map<String, dynamic> json) => _$StandardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StandardResponseToJson(this);
}
