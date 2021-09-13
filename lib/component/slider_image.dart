import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';


class SliderWidget extends StatelessWidget {
  final List<SliderImage> sliders;
  final Function change;
  const SliderWidget({
    Key key, this.sliders, this.change

  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        height: 187,
         autoPlay: true,
        initialPage: 0,
        viewportFraction: 0.6,
        onPageChanged: change,
      ),
      items: sliders.map((item) {
        return GestureDetector(
          onTap: ()=>Helper.openTarget(item,context),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(17)),
            ),
            child:CachedNetworkImage(
              imageUrl:item.image,
              height: 187,
              fit: BoxFit.cover,
              // fit: BoxFit.fitWidth,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CupertinoActivityIndicator(),
              errorWidget: (BuildContext context, String url, Object error) {
                print(error);
                return const Icon(Icons.error);
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}