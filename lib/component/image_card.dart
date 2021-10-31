import 'package:flutter/material.dart';

import 'cached_network_image_component.dart';

class ImageCard extends StatelessWidget {
  final String url;
  final double height,width;
  const ImageCard({Key key, this.url, this.height=96.0, this.width=96.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)),
      child: CachedNetworkImageComponent(
        url: this.url,
        width: width,
        height: height,
      ),
    );
  }
}
