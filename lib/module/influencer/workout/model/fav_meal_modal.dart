class FavMealsModal {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  FavMealsModal(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  FavMealsModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseDetails = json['responseDetails'] != null
        ? new ResponseDetails.fromJson(json['responseDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responseCode'] = this.responseCode;
    data['responseDescription'] = this.responseDescription;
    if (this.responseDetails != null) {
      data['responseDetails'] = this.responseDetails!.toJson();
    }
    return data;
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
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
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
  int? userId;
  int? id;
  String? imageUrl;
  String? title;
  String? mealType;
  String? mealLevel;
  int? calories;
  int? proteins;
  int? carbs;
  int? fats;
  String? method;
  List<Ingredients>? ingredients;

  Data(
      {this.userId,
      this.id,
      this.imageUrl,
      this.title,
      this.mealType,
      this.mealLevel,
      this.calories,
      this.proteins,
      this.carbs,
      this.fats,
      this.method,
      this.ingredients});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    mealType = json['mealType'];
    mealLevel = json['mealLevel'];
    calories = json['calories'];
    proteins = json['proteins'];
    carbs = json['carbs'];
    fats = json['fats'];
    method = json['method'];
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(new Ingredients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    data['mealType'] = this.mealType;
    data['mealLevel'] = this.mealLevel;
    data['calories'] = this.calories;
    data['proteins'] = this.proteins;
    data['carbs'] = this.carbs;
    data['fats'] = this.fats;
    data['method'] = this.method;
    if (this.ingredients != null) {
      data['ingredients'] = this.ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ingredients {
  int? favoriteMealId;
  int? id;
  String? name;
  double? quantity;
  String? type;
  int? proteins;
  int? carbs;
  int? fats;
  int? calories;

  Ingredients(
      {this.favoriteMealId,
      this.id,
      this.name,
      this.quantity,
      this.type,
      this.proteins,
      this.carbs,
      this.fats,
      this.calories});

  Ingredients.fromJson(Map<String, dynamic> json) {
    favoriteMealId = json['favoriteMealId'];
    id = json['id'];
    name = json['name'];
    quantity = double.parse('${json['quantity']}');
    type = json['type'];
    proteins = json['proteins'];
    carbs = json['carbs'];
    fats = json['fats'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favoriteMealId'] = this.favoriteMealId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['type'] = this.type;
    data['proteins'] = this.proteins;
    data['carbs'] = this.carbs;
    data['fats'] = this.fats;
    data['calories'] = this.calories;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
