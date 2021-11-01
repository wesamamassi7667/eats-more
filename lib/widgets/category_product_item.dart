import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/common/common.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/image_card.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';

class CategoryProductItem extends StatefulWidget {
  const CategoryProductItem(
      {Key key,
      this.tap,
      this.animation,
      this.product,
      this.index,
      this.scaffoldKeys})
      : super(key: key);
  final Animation animation;
  final Function tap;
  final GlobalKey<ScaffoldState> scaffoldKeys;
  final int index;
  final ProductInfo product;
  @override
  _CategoryProductItemState createState() => _CategoryProductItemState();
}

class _CategoryProductItemState extends State<CategoryProductItem> {
  bool _isFavorite;
  ProductInfo _product;

  @override
  void initState() {
    _product = widget.product;
    _isFavorite = _product.is_joined ?? false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RestaurantsApiModel>(
      builder: (context, child, model) => GestureDetector(
        onTap: widget.tap,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset(0, 0),
          ).animate(widget.animation),
          child: SecondContainerComponent(
            startP: 11,
            topP: 6,
            bottomP: 6,
            endP: 27,
            start: 16,
            end: 16,
            top: widget.index == 0 ? 0 : 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageCard(url: _product.image),
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
                            fontSize: 15,
                            color: black2,
                          ),
                        ),
                        Text(
                          _product.product_desc ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            color: grey4,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              _product.product_price +
                                  " " +
                                  AppLocalization.of(context).translate("sr"),
                              style: TextStyle(
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
                                        AppLocalization.of(context)
                                            .translate('calorie'),
                                    style: TextStyle(
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
                  onPressed: () {
                    if (!model.isLoggedIn()) {
                      Common.showSlideUpLoginView(context);
                      return;
                    }
                    if (_isFavorite) {
                      _deleteFavoriteItem(_product.product_id, widget.index);
                    } else {
                      _addToFavorite(context, _product.product_id);
                    }
                  },
                  child: Icon(
                    _isFavorite
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: red,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addToFavorite(BuildContext context, int id) async {
    try{
      var _body = {"product_id": id.toString()};
      Common.showSingleAnimationDialog(context);
      await AppApi.favouriteClient.addFavourite(_body);
      Navigator.pop(context);
      setState(() => _isFavorite = true);
    }
    catch(err){
      Common.showError(err, context);
    }
  }

  _deleteFavoriteItem(int productId, index) async {
    try {
      Common.showSingleAnimationDialog(context);
      await AppApi.favouriteClient.deleteFavourite(productId);
      Navigator.pop(context);
      setState(() => _isFavorite = false);

    } catch (err) {
      Common.showError(err, context);
    }
  }
}


