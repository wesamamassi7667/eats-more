

import 'package:eat_more_app/model/contact_response.dart';

import '../http_manager.dart';

class ConfigureClient{
  Future <String> contact(body) async {
    try {
      final response = await HttpManager.post<String>(
        'contact-us',
        body, (json) =>null,
        showMessage: true
      );
      return response ??'';
    } catch (err) {
      throw (err);
    }
  }

  Future <SocialMedia> getSocialMedia() async {
    try {
      final response = await HttpManager.get<SocialMedia>(
          'social-media-info',
        (json) =>SocialMedia.fromJson(json),
      );
      return response;
    } catch (err) {
      throw (err);
    }
  }


}