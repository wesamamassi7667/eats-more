import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/helper.dart';

class AdsImageComponent extends StatelessWidget {
  final List<SliderImage> ads;
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
                Helper.openTarget(ads
                    .firstWhere(
                        (element) => element.display_slider_id == item.id,
                    orElse: () => null),context);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: CachedNetworkImageComponent(url: ads
                  .firstWhere(
                      (element) => element.display_slider_id == item.id,
                  orElse: () => null)
                  ?.image,),
            ),
          );
  }
}


