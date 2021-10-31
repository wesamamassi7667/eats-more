import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileAvatar extends StatelessWidget {
  final String filePath;

  const ProfileAvatar({Key key, this.filePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RestaurantsApiModel>(
        builder: (context, child, model) {
      if (model.loggedUser?.avatar != null){
        print("dd");
        print(model.loggedUser.avatar);
        return CircleAvatar(
          radius: 40,
          backgroundImage: filePath!=null?Image.file(
            File(filePath),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ).image: Helper.buildCachedNetworkImageProvider(
              model.loggedUser?.avatar??"",
            ),
          );}
      else {
        // final placeholderCharSources = <String>[
        //   model.loggedUser?.fname,
        //   model.loggedUser?.email,
        //   '-',
        // ];
        // final placeholderChar = placeholderCharSources
        //     .firstWhere(
        //         (String str) => str != null && str.trimLeft().isNotEmpty)
        //     .trimLeft()[0]
        //     .toUpperCase();
        return   Container(

          child: CircleAvatar(
            radius: 40,
            child: Icon(Icons.account_circle),
          ),
        );
      }

    });
  }
}
