import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:eat_more_app/component/delete_button.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({Key key, this.product, this.press}) : super(key: key);
  final ProductInfo product;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImageComponent(
              url: product.image,
              height: 73,
              width: 73,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 160,
            padding: const EdgeInsetsDirectional.only(start: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.product_name,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: black9)
                ),
                Text(
                    '${product.price}' +
                        " " +
                        AppLocalization.of(context).translate("sr"),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: black9)),
                Text(
                    '${product.description}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xffA6A6A6),
                    ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

              ],
            ),
          ),
          Spacer(),
          DeleteButton(
            press: press,
          )
        ],
      ),
    );
  }
}
