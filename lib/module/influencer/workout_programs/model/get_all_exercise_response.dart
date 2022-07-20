class GetAllExerciseResponse {
  GetAllExerciseResponse({
    this.status,
    this.responseCode,
    this.responseDescription,
    this.responseDetails,
  });
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  GetAllExerciseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseDetails = json['responseDetails'] != null
        ? new ResponseDetails.fromJson(json['responseDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = new Map<String, dynamic>();
    _data['status'] = this.status;
    _data['responseCode'] = this.responseCode;
    _data['responseDescription'] = this.responseDescription;
    if (this.responseDetails != null) {
      _data['responseDetails'] = this.responseDetails!.toJson();
    }
    return _data;
  }
}

class ResponseDetails {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  ResponseDetails(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  Data(
      {required this.id,
      required this.workoutId,
      required this.workoutWeekId,
      required this.workoutDayId,
      required this.title,
      required this.workoutType,
      required this.exerciseTime,
      required this.assetType,
      required this.assetUrl,
      required this.instructions,
      required this.restTime,
      required this.videoDuration,
      required this.isActive,
      required this.createdBy,
      this.sets});
  late final int id;
  late final int workoutId;
  late final int workoutWeekId;
  late final int workoutDayId;
  late final String title;
  late final String workoutType;
  late final String exerciseTime;
  late final String assetType;
  late final String assetUrl;
  late final String instructions;
  late final String restTime;
  late final String videoDuration;
  late final int isActive;
  late final int createdBy;
  List<Sets>? sets;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutId = json['workoutId'];
    workoutWeekId = json['workoutWeekId'];
    workoutDayId = json['workoutDayId'];
    title = json['title'] ?? '';
    workoutType = json['workoutType'] ?? '';
    exerciseTime = json['exerciseTime'] ?? '';
    assetType = json['assetType'] ?? '';
    assetUrl = json['assetUrl'] ?? '';
    instructions = json['instructions'] ?? '';
    restTime = json['restTime'] ?? '';
    videoDuration = json['videoDuration'] ?? '';
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    if (json['sets'] != null) {
      sets = <Sets>[];
      json['sets'].forEach((v) {
        sets!.add(new Sets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['workoutId'] = workoutId;
    _data['workoutWeekId'] = workoutWeekId;
    _data['workoutDayId'] = workoutDayId;
    _data['title'] = title;
    _data['workoutType'] = workoutType;
    _data['exerciseTime'] = exerciseTime;
    _data['assetType'] = assetType;
    _data['assetUrl'] = assetUrl;
    _data['instructions'] = instructions;
    _data['restTime'] = restTime;
    _data['videoDuration'] = videoDuration;
    _data['isActive'] = isActive;
    _data['createdBy'] = createdBy;
    if (this.sets != null) {
      _data['sets'] = this.sets!.map((v) => v.toJson()).toList();
    }
    return _data;
  }
}

class Sets {
  Sets(
      {required this.id,
      required this.workoutDayExerciseId,
      required this.title,
      required this.workoutType,
      required this.exerciseTime,
      required this.assetType,
      required this.assetUrl,
      required this.instructions,
      required this.restTime,
      required this.videoDuration,
      required this.createdBy,
      this.type});
  late final int id;
  late final int workoutDayExerciseId;
  late final String title;
  late final String workoutType;
  late final String exerciseTime;
  late final String assetType;
  late final String assetUrl;
  late final String instructions;
  late final String restTime;
  late final String videoDuration;
  late final int createdBy;
  String? type;

  Sets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutDayExerciseId = json['workoutDayExerciseId'];
    title = json['title'] ?? '';
    workoutType = json['workoutType'] ?? '';
    exerciseTime = json['exerciseTime'] ?? '';
    assetType = json['assetType'] ?? '';
    assetUrl = json['assetUrl'] ?? '';
    instructions = json['instructions'] ?? '';
    restTime = json['restTime'] ?? '';
    videoDuration = json['videoDuration'] ?? '';
    createdBy = json['createdBy'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['workoutDayExerciseId'] = workoutDayExerciseId;
    _data['title'] = title;
    _data['workoutType'] = workoutType;
    _data['exerciseTime'] = exerciseTime;
    _data['assetType'] = assetType;
    _data['assetUrl'] = assetUrl;
    _data['instructions'] = instructions;
    _data['restTime'] = restTime;
    _data['videoDuration'] = videoDuration;
    _data['createdBy'] = createdBy;
    _data['type'] = type;
    return _data;
  }
}

class Links {
  Links({
    required this.url,
    required this.label,
    required this.active,
  });
  late final String url;
  late final String label;
  late final bool active;

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'] ?? '';
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['label'] = label;
    _data['active'] = active;
    return _data;
  }
}
