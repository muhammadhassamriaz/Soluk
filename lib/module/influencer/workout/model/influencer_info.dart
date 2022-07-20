import 'package:json_annotation/json_annotation.dart';

part 'influencer_info.g.dart';

@JsonSerializable()
class InfluencerInfo {
  String? id;
  String? profileImage;
  String? coverImageVideo;
  List<String>? tags;
  String? longIntro;
  String? goals;
  String? credentials;
  String? requirements;
  InfluencerInfo({
    this.id,
    this.profileImage,
    this.coverImageVideo,
    this.tags,
    this.longIntro,
    this.goals,
    this.credentials,
    this.requirements,
  });

  factory InfluencerInfo.fromJson(Map<String, dynamic> json) => _$InfluencerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfluencerInfoToJson(this);
}
