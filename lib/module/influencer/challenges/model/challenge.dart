import 'package:json_annotation/json_annotation.dart';

part 'challenge.g.dart';

@JsonSerializable(explicitToJson: true)
class ChallengeModel {
  final int? userId;
  final int? id;
  final String? assetUrl;
  final String? assetType;
  final String? title;
  final String? badge;
  final int? maxUsers;
  final String? description;
  final String? challengeExpiry;
  final String? challengeStatus;
  final int? isActive;
  final int? createBy;
  final String? createdDate;
  final dynamic modifiedBy;
  final dynamic modifiedDate;
  final String? createdAt;
  final String? updatedAt;
  ChallengeModel({
    this.userId,
    this.id,
    this.assetUrl,
    this.assetType,
    this.title,
    this.badge,
    this.maxUsers,
    this.description,
    this.challengeExpiry,
    this.challengeStatus,
    this.isActive,
    this.createBy,
    this.createdDate,
    required this.modifiedBy,
    required this.modifiedDate,
    this.createdAt,
    this.updatedAt,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeModelToJson(this);
}

@JsonSerializable()
class GetAllChallenges {
  @JsonKey(name: "responseDetails")
  final List<ChallengeModel>? allChallenges;

  GetAllChallenges({this.allChallenges});

  factory GetAllChallenges.fromJson(Map<String, dynamic> json) =>
      _$GetAllChallengesFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllChallengesToJson(this);
}
