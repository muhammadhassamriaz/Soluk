class SocialLinksModal {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  SocialLinksModal(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  SocialLinksModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseDetails = json['responseDetails'] != null
        ?  ResponseDetails.fromJson(json['responseDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['responseCode'] = responseCode;
    data['responseDescription'] = responseDescription;
    if (responseDetails != null) {
      data['responseDetails'] = responseDetails!.toJson();
    }
    return data;
  }
}

class ResponseDetails {
  String? facebook;
  String? instagram;
  String? youtube;

  ResponseDetails({this.facebook, this.instagram, this.youtube});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    instagram = json['instagram'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['youtube'] = youtube;
    return data;
  }
}
