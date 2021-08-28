import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/helper.dart';

class AdsImageComponent extends StatelessWidget {
  final List<Ads> ads;
  final SpecSlider item;

  const AdsImageComponent({Key key, this.ads, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ads
                .firstWhere((element) => element.display_slider_id == item.id,
                    orElse: () => null)
                ?.image ==
            null
        ? SizedBox.shrink()
        : GestureDetector(
            onTap: () {
              Helper.openApp(
                ads
                    .firstWhere(
                        (element) => element.display_slider_id == item.id,
                        orElse: () => null)
                    ?.link,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: CachedNetworkImage(
                imageUrl: ads
                    .firstWhere(
                        (element) => element.display_slider_id == item.id,
                        orElse: () => null)
                    ?.image,
                width: double.infinity,
                height: 240.34,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CupertinoActivityIndicator(),
                errorWidget: (BuildContext context, String url, Object error) {
                  print(error);
                  return const Icon(Icons.error);
                },
              ),
            ),
          );
  }
}
