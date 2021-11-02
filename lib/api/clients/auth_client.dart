


import 'package:eat_more_app/model/login_response.dart';

import '../http_manager.dart';

class AuthClient {
  Future <User> loginUser(body) async {
    try {
    final response=await HttpManager.post<User>(
        'auth/login',
        body,
            (json) => User.fromJson(json),
      );
    return response;

    } catch (err) {
      throw (err);
    }
  }

  Future <User> verifyCode(body) async {
    try {
      final response=await HttpManager.post<User>(
        'auth/submitcode',
        body, (json) => User.fromJson(json),
      );
      return response;

    } catch (err) {
      throw (err);
    }
  }

  Future <void> updateFcmToken(body) async {
    try {
      await HttpManager.post<void>(
        'auth/updateFcm_token',
        body, (json) {},
      );
    } catch (err) {
      throw (err);
    }
  }

  Future<void> logout() async {
    try {
      await HttpManager.get<void>(
        'auth/logout',
       (json) {},
      );
    } catch (err) {
      throw (err);
    }
  }
}