import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/model/dynamic_response.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';
import 'cached_network_image_component.dart';
class CategoryProductItem extends StatefulWidget {
  const CategoryProductItem({Key key, this.tap, this.animation, this.product, this.index}) : super(key: key);
  final Animation animation;
  final Function tap;
  final int index;
  final ProductInfo product;
  @override
  _CategoryProductItemState createState() => _CategoryProductItemState();
}

class _CategoryProductItemState extends State<CategoryProductItem> {

  IconData _icon=CupertinoIcons.heart;

  @override
  Widget build(BuildContext context) {
    ProductInfo _product =widget.product;
    return GestureDetector(
      onTap:widget.tap,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset(0, 0),
        ).animate(widget.animation),
        child: SecondContainerComponent(
          startP: 11,topP:6,bottomP: 6,endP:0 ,
          start: 16,end: 16,top: widget.index==0?0:16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: CachedNetworkImageComponent(
                  url: _product.image,
                  width: 96,
                  height: 96,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                    _product.product_name,
                        style: TextStyle(
                          fontFamily:
                          'DIN Next LT Arabic',
                          fontSize: 18,
                          color: black2,
                        ),
                      ),
                      Text(
                        _product.product_desc ??
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
                            _product.product_price +
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
                          _product.product_calories == null
                              ? SizedBox.shrink()
                              : Text(
                            _product.product_calories +
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
              ),
              CupertinoButton(
                onPressed: ()=>_addToFavorite(context,_product.product_id),
                child: Icon(
                  _icon,
                  color: red,
                  size: 15,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  _addToFavorite(BuildContext context,int id) async {
    var _body={"product_id": id.toString()};
    Helper.showSingleAnimationDialog(context);
    DynamicResponse response= await ScopedModel.of<RestaurantsApiModel>(context).addFavorite(_body);
    Navigator.pop(context);
    if(!response.status.status){
      AppDialog.showMe(context, response.status.HTTP_response);
    }
    else{
      setState(()=>_icon=CupertinoIcons.heart_fill);
    }
  }
}

