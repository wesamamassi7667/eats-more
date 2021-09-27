import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
import 'cached_network_image_component.dart';
class CategoryProductItem extends StatelessWidget {
  const CategoryProductItem({Key key, this.index, this.products, this.tap, this.press, this.animation}) : super(key: key);
  final int index;
  final Animation animation;
  final List<ProductInfo> products;
  final Function tap,press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:tap,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset(0, 0),
        ).animate(animation),
        child: SecondContainerComponent(
          startP: 11,topP:6,bottomP: 14,endP:27 ,
           start: 16,end: 16,top: index==0?0:16,
          child: Row(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: CachedNetworkImageComponent(
                  url: products[index].image,
                  width: 96,
                  height: 96,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products[index].product_name,
                      style: TextStyle(
                        fontFamily:
                        'DIN Next LT Arabic',
                        fontSize: 18,
                        color: black2,
                      ),
                    ),
                    Text(
                      products[index].product_desc ??
                          "",
                      style: TextStyle(
                        fontFamily:
                        'DIN Next LT Arabic',
                        fontSize: 13,
                        color: const Color(0xc7707070),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          products[index].product_price +
                              " " +
                              AppLocalization.of(context).translate("sr"),
                          style: TextStyle(
                            fontFamily: 'DIN Next LT Arabic',
                            fontSize: 14,
                            color: primaryIconColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        products[index].product_calories == null
                            ? SizedBox.shrink()
                            : Text(
                          products[index].product_calories +
                              " " +
                              AppLocalization.of(context).translate('calorie'),
                            style: TextStyle(
                            fontFamily: 'DIN Next LT Arabic',
                            fontSize: 14,
                            color: const Color(0xff9d5000),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Spacer(),

              CupertinoButton(
                onPressed: press,
                child: Icon(
                  Icons.add_box_rounded,
                  size: 30,
                  color: primaryIconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
