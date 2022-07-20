class CCApiController {
  CCApiController._privateConstructor();
  static final CCApiController instance = CCApiController._privateConstructor();

  initialize() {}

  // Future<StandardResponse> bookTable(parms) async {
  //   try {
  //     final response = await CCApiManager.instance.request(
  //       "/?api=book_table",
  //       HttpMethod.POST,
  //       AuthenticationType.PRE,
  //       parms,
  //     );
  //     print("register response :: $response");
  //     return response;
  //   } catch (e) {
  //     print("exception :: $e");
  //     throw e;
  //   }
  // }
  //
  // Future<List<RestaurantData>> getMyFavrt() async {
  //   try {
  //     var userid = await PreferenceUtils.getString("user_id");
  //     final response = await CCApiManager.instance.request(
  //         "/?api=my_shortlist&user_id=$userid&perpage=300",
  //         HttpMethod.GET,
  //         AuthenticationType.POST,
  //         null);
  //     final list = (response.data as List)
  //         .map((e) => RestaurantData.fromJson(e))
  //         .toList();
  //     print("bookings Response  : ${list.length}");
  //
  //     return list;
  //   } catch (e) {
  //     print("get my favrt error : $e");
  //     throw e;
  //   }
  // }

}
