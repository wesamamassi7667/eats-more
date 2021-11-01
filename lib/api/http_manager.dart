import 'dart:convert';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/generic_response.dart';
import 'package:eat_more_app/typdef/model_creator.dart';
import 'package:http/http.dart' as http;

class HttpManager {
  static final String url = "https://api.yalago.net/api/enterprise/eats/";

  static String token;
  static Map<String, String> getHeader({String token}) {
    return {
      'language': UtilSharedPreferences.getInt('lang')==0?'en':'ar',
      'Authorization': UtilSharedPreferences.getString('token'),
      'token':token,
      "platform":Helper.getPlatForm()

    };
  }

  ///POST Method
  static Future<T> post<T>(
    String subUrl,
    body,
    ModelCreator<T> createModel,
    {String token,bool showMessage=false}
  ) async {
    try {
         final response=await http.post(
          Uri.parse('$url' +subUrl),
             body: body,
             headers:getHeader(token: token)
         );
         print(response.body);
          GenericResponse genericResponse=GenericResponse.fromJson(json.decode(response.body),createModel);
          if(genericResponse.status.status){
            print(genericResponse.data);
            if(!showMessage)
            return genericResponse.data;
            else
              return Future.value(genericResponse.status.HTTP_response as T);


          }
      else{
        return Future.error(genericResponse.status.HTTP_response);
      }
    } catch (error) {
      // environment error
      print('error $error');
      return Future.error(error);
    }
  }

  ///DELETE Method
  static Future<T> delete<T>(
      String subUrl,
      ModelCreator<T> createModel,
      ) async {
    try {
      final response=await http.delete(
          Uri.parse('$url' +subUrl),
          headers: getHeader()
      );
      print(response.body);
      GenericResponse genericResponse=GenericResponse.fromJson(json.decode(response.body),createModel);
      if(genericResponse.status.status){
        print(genericResponse.data);
        return genericResponse.data;
      }
      else{
        return Future.error(genericResponse.status.HTTP_response);
      }
    } catch (error) {
      // environment error
      print('error $error');
      return Future.error(error);
    }
  }
  //PUT METHOD
  static Future<T> put<T>(
      String subUrl,
      body,
      ModelCreator<T> createModel,
      ) async {
    try {
      final response=await http.put(
          Uri.parse('$url' +subUrl),
          headers: getHeader(),
           body: body
      );
      print(response.body);
      GenericResponse genericResponse=GenericResponse.fromJson(json.decode(response.body),createModel);
      if(genericResponse.status.status){
        print(genericResponse.data);
        return genericResponse.data;
      }
      else{
        return Future.error(genericResponse.status.HTTP_response);
      }
    } catch (error) {
      // environment error
      print('error $error');
      return Future.error(error);
    }
  }

  ///GET Method
  static Future<T> get<T>(
      String subUrl,
      ModelCreator<T> createModel,
      ) async {
    try {
      final response = await http.get(Uri.parse('$url$subUrl') , headers: getHeader());
      print(response.body);
      GenericResponse genericResponse=GenericResponse.fromJson(json.decode(response.body),createModel);
      if(genericResponse.status.status){
        print(genericResponse.data);
        return genericResponse.data;
      }
      else{
        return Future.error(genericResponse.status.HTTP_response);
      }
    } catch (error) {
      print(error);
      print('error $error');
      return Future.error(error);
    }
  }
}