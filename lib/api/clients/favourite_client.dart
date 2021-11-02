import 'package:eat_more_app/model/favorite_response.dart';

import '../http_manager.dart';

class FavouriteClient {
  Future<void> addFavourite(body) async {
    try {
      await HttpManager.post<void>(
        'auth/favorite',
        body,
        (json) => {},
      );
    } catch (err) {
      throw (err);
    }
  }

  Future<void> deleteFavourite(int favoriteId) async {
    try {
      await HttpManager.delete<void>(
        'auth/favorite/$favoriteId',
        (json) => {},
      );
    } catch (err) {
      throw (err);
    }
  }

  Future<List<Favorite>> listFavourite() async {
    try {
     final response= await HttpManager.get<FavoriteData>(
        'auth/favorite',
        (json) =>FavoriteData.fromJson(json),);
     return response?.favorite??[];

    } catch (err) {
      throw (err);
    }
  }
}
