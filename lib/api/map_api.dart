


import 'http_manager.dart';

class API {
  ///Map APIs
  static const String GET_COORDINATES_URL = 'maps.googleapis.com';
  static const String GET_COORDINATES_PATH = '/maps/api/directions/json';


  ///Authentication APIs
  // static Future<APIResultModel> getRouteCoordinates(dynamic parameters) async {
  //   print(parameters);
  //   return APIResultModel.fromResponse(
  //       response: await HttpManager.get(baseUrl: GET_COORDINATES_URL,
  //           subUrl: GET_COORDINATES_PATH,
  //           parameters: parameters),
  //       data: null);
  // }
}