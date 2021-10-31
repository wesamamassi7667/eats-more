import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/item_detail_component.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductSheet extends StatefulWidget {
  final int id;
  final AnimationController controller;
  final int idVendor;
  final String logo;
  final String name;

  const ProductSheet(
      {Key key, this.id, this.controller, this.idVendor, this.logo, this.name})
      : super(key: key);

  @override
  _ProductSheetState createState() => _ProductSheetState();
}

class _ProductSheetState extends State<ProductSheet> {
  var _isLoading = false;
  Product _product;
  var _quantity = 1;
  var _isLoading1 = false;
  List<List<bool>> _isCheckedAddons;
  List<int> _lengthTrue;

  @override
  void initState() {
    // TODO: implement initState
    _isCheckedAddons = [];
    _lengthTrue = [];
    print(widget.idVendor.toString());
    super.initState();
    _getProductInfo();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CupertinoActivityIndicator())
        : ScopedModelDescendant<RestaurantsApiModel>(
          builder:(context,child,model)=> Column(
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.only(start: 16, end: 16, top: 16),
                  child: ClipRRect(
                    child: Banner(
                      message:  _product.product_info.product_offer==null?"":AppLocalization.of(context).translate('offer'),
                      location: BannerLocation.topStart,
                      color:  _product.product_info.product_offer==null?Colors.transparent:Colors.red,
                      child: Container(
                        height: 287.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                            image: DecorationImage(
                                image: Helper.buildCachedNetworkImageProvider(_product.product_info.image_preview,),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ),
                // ItemDetailColumn(
                //   quantity: _quantity,
                //   item: _product.product_info,
                //   pressMines: _quantity == 1
                //       ? null
                //       : () {
                //           setState(() {
                //             _quantity--;
                //           });
                //         },
                //   pressPlus: () {
                //     setState(() {
                //       _quantity++;
                //     });
                //   },
                //   isChecked: _isCheckedAddons,
                //   lengthTrue: _lengthTrue,
                // ),
                SizedBox(
                  height: 5,
                ),
                _isLoading1
                    ? TextButton(
                        onPressed: null,
                        child: CupertinoActivityIndicator(),
                        style: ElevatedButton.styleFrom(
                          primary: primaryIconColor,
                          // padding: EdgeInsets.symmetric(vertical: 6,horizontal: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16))),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextButton.icon(

                          onPressed: () {
                            if(!model.isLoggedIn()){

                            }
                            _addToCart();
                            print(_product.product_info.product_id);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: primaryIconColor,
                            // padding: EdgeInsets.symmetric(vertical: 6,horizontal: 18),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16))),
                          ),
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          label: Text(
                            AppLocalization.of(context).translate("add_cart"),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: background,
                            ),
                          ),
                        ),
                      )
              ],
            ),
        );
  }

  void _getProductInfo() async {
    setState(() {
      _isLoading = true;
    });
    await ScopedModel.of<RestaurantsApiModel>(context)
        .getProductInfo(widget.id)
        .then(( value) {
      if (value.status.status) {
        setState(() {
          _product = value.data;
        });
        print(_product.product_info.product_id);
        if (_product.product_info.addons?.addon_category != null)
          for (var i = 0;
              i < _product.product_info.addons.addon_category.length;
              i++) {
            List<bool> _isChecked = [];
            _lengthTrue.add(0);
            for (var i1 = 0;
                i1 <
                    _product
                        .product_info.addons.addon_category[i].addons.length;
                i1++) _isChecked.add(false);
            _isCheckedAddons.add(_isChecked);
            print(_isCheckedAddons);
            print(i);
          }
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _addToCart() async {
    var addonsArray = "";
    if (_product.product_info.addons != null) {
      addonsArray = "{\"addons\":[";

      for (var i1 = 0;
          i1 < _product.product_info.addons.addon_category.length;
          i1++) {
        for (var i = 0;
            i < _product.product_info.addons.addon_category[i1].addons.length;
            i++) {
          if (_isCheckedAddons[i1][i]) {
            // _lengthTrue[i1]++;
            addonsArray +=
                "{\"addon_id\": \"${_product.product_info.addons.addon_category[i1].addons[i].addon_id.toString()}\"},";
          }
        }
        print(addonsArray);
        if (_product.product_info.addons.addon_category[i1]
            .cat_is_mandatory) if (_lengthTrue[
                i1] !=
            _product
                .product_info.addons.addon_category[i1].cat_choose_maximum) {
          AppDialog.showMe(
              context,
              'You must add ' +
                  '${_product.product_info.addons.addon_category[i1].cat_choose_maximum}' +
                  " additions from the " +
                  _product.product_info.addons.addon_category[i1].cat_name);
          return;
        }
      }
      addonsArray = addonsArray.substring(0, addonsArray.length - 1);
      addonsArray += "]}";
    }
    setState(() {
      _isLoading1 = true;
    });
    var _body = {
      "product_quantity": _quantity.toString(),
      "product_id": _product.product_info.product_id.toString(),
      "vendor_id": widget.idVendor.toString(),
      'product_addons': addonsArray,
      "custom_addons": "test custom product"
    };
    print(_body);

    // await ScopedModel.of<RestaurantsApiModel>(context)
    //     .addToCart(_body)
    //     .then((value) {
    //   if (value.status.status) {
    //     if (mounted) _getCart();
    //   }
    // });
  }

  // void _getCart() async {
  //   await ScopedModel.of<RestaurantsApiModel>(context)
  //       .getCart(widget.idVendor)
  //       .then((value) {
  //     if (value.status.status) {
  //       if (widget.controller != null) {
  //         widget.controller.fling(velocity: 1.0);
  //         ScopedModel.of<RestaurantsApiModel>(context).setTotal(value.data.products_price.toString());
  //         ScopedModel.of<RestaurantsApiModel>(context).setLogo(widget.logo);
  //         ScopedModel.of<RestaurantsApiModel>(context).setName(widget.name);
  //         ScopedModel.of<RestaurantsApiModel>(context).setId(widget.idVendor);
  //       }
  //       Navigator.pop(
  //           context, AddCart(value.data.products, value.data.products_price));
  //     }
  //     setState(() {
  //       _isLoading1 = false;
  //     });
  //   });
  // }
}
