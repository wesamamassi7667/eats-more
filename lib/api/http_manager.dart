
import 'dart:convert';

import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:http/http.dart' as http;

class HttpManager {

  static Map<String, String> getHeader() {
    return {
      'Authorization': 'Bearer ${UtilSharedPreferences.getString('token')}',
      "Content-Type": "application/json",
    };
  }

  ///POST Method
  static Future<http.Response> post({
    String baseUrl,
    String path,
    Map<String, dynamic> body,
  }) async {
    try {
      final response = await http.post(
          Uri.https(baseUrl , '/api$path'),
          headers: getHeader(), body: json.encode(body));
      return response;
    } catch (error) {
      return null;
    }
  }

  ///GET Method
  static Future<http.Response> get({
    String baseUrl,
   String path,
    Map<String, dynamic> parameters,
  }) async {
    try {
      final response = await http.get(
          Uri.https(baseUrl, path, parameters),
          headers: getHeader());
      return response;
    } catch (error) {
      return null;
    }
  }
}