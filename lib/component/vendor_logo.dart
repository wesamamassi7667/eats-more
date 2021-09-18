
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class VendorLogo extends StatelessWidget {
  final String url;

  const VendorLogo({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 49,
      height: 49,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
              url),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
