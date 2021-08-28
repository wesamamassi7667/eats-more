import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RestaurantsApiModel>(
        builder: (context, child, model) {
      if (model.loggedUser?.avatar != null)
        return CircleAvatar(
          radius: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CachedNetworkImage (
              imageUrl: model.loggedUser?.avatar??"",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CupertinoActivityIndicator(),
              errorWidget: (BuildContext context, String url, Object error) {
                print(error);
                return const Icon(Icons.error);
              },
            ),
          ),
        );
      else {
        final placeholderCharSources = <String>[
          model.loggedUser?.fname,
          model.loggedUser?.email,
          '-',
        ];
        final placeholderChar = placeholderCharSources
            .firstWhere(
                (String str) => str != null && str.trimLeft().isNotEmpty)
            .trimLeft()[0]
            .toUpperCase();
        return   Container(

          child: CircleAvatar(
            radius: 40,
            child: Text(placeholderChar),
          ),
        );
      }

    });
  }
}
