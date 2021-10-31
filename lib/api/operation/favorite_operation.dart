

import 'package:eat_more_app/component/common/common.dart';
import 'package:eat_more_app/model/dynamic_response.dart';
import 'package:eat_more_app/model/stauts.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../restaurants_api_model.dart';

class FavoriteOperation{

  Future<void> deleteFavorite(BuildContext context,favoriteId) async {
      Common.showSingleAnimationDialog(context);
      DynamicResponse response = await ScopedModel.of<RestaurantsApiModel>(context).deleteFavorite(favoriteId);
      if (!response.status.status) {
        return Future.error(response.status.HTTP_response);
      }
      Navigator.pop(context);
      return null;
    }
  }


