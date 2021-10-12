import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/cart_button.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/item_detail_component.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/component/vendor_logo.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class ItemDetailsScreen extends StatefulWidget {
  final int id;
   double total;
  final String logo;
  final int vendorId;
 ItemDetailsScreen({Key key, this.id, this.total, this.logo, this.vendorId}) : super(key: key);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  var _isLoading=false;
  var _quantity=1;
  var _isLoading1=false;
  List<List<bool>> _isCheckedAddons;
  Product _product;
  List<int> _lengthTrue;
  double _totalPriceProduct;



  @override
  void initState() {
    _lengthTrue=[];
    // TODO: implement initState
    _isCheckedAddons=[];
    super.initState();
    _getProductInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: background,
          body: _isLoading?MyProgressIndicator():
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 287.0,
                  floating: false,
                  pinned: true,
                  leading: CloseButton(),
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: VendorLogo(
                          width: 40.0,height: 40.0,url:widget.logo
                      ),
                      background: Container(
                          height: 287.0,
                          decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Helper.buildCachedNetworkImageProvider(_product.product_info.image_preview,),
                            fit: BoxFit.cover,
                          )
                        ),
                        child:
                        _product.product_info.product_offer==null?SizedBox.shrink():
                        Banner(
                                message: AppLocalization.of(context).translate('offer'),
                                location: BannerLocation.bottomEnd,
                                color: Colors.red,
                        ),
                        ),
                        ),
                      )


              ];
            },
            body:   Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                          ItemDetailColumn(
                              quantity:_quantity,
                              item:_product.product_info,
                              pressMines:()=>_pressMinesButton(),
                              pressPlus:()=>_pressPlusButton(),
                              isChecked:_isCheckedAddons,
                              lengthTrue: _lengthTrue,
                              totalPriceProduct: _totalPriceProduct,
                              callBack: this._updateTotalProductCallBack,
                          ),
                      ],
                    ),
                ),
                PositionedDirectional(
                  start: 50,
                  end: 50,
                  bottom: 20,
                  child: CartButton(
                      isLoading: _isLoading1,
                      tap: (){
                        _addToCart();
                      },
                      color: primaryIconColor,
                      total:_totalPriceProduct,
                      text: AppLocalization.of(context).translate('add_cart'),
                    ),
                ),

              ],
            ),
            ),
      );
  }
  void _addToCart() async{
    var addonsArray="";
    if(_product.product_info.addons!=null) {
      addonsArray = "{\"addons\":[";

      for(var i1=0;i1<_product.product_info.addons.addon_category.length;i1++){
      for(var i=0;i<_product.product_info.addons.addon_category[i1].addons.length;i++){
        if(_isCheckedAddons[i1][i]){
          // _lengthTrue[i1]++;
          addonsArray +=
          "{\"addon_id\": \"${_product.product_info.addons.addon_category[i1].addons[i].addon_id.toString()}\"}," ;
      }
      }
        print(addonsArray);
      if(_product.product_info.addons.addon_category[i1].cat_is_mandatory)
        if(_lengthTrue[i1]!=_product.product_info.addons.addon_category[i1].cat_choose_maximum){
          AppDialog.showMe(context,    'You must add ' + '${_product.product_info.addons.addon_category[i1].cat_choose_maximum}'+
              " additions from the " + _product.product_info.addons.addon_category[i1].cat_name);
          return;
        }}
      addonsArray=addonsArray.substring(0,addonsArray.length-1);
      addonsArray += "]}";
    }
    setState(() {
      _isLoading1=true;
    });
    var _body={
      "product_quantity":_quantity.toString(),
      "product_id":_product.product_info.product_id.toString(),
      "vendor_id":widget.vendorId.toString(),
      'product_addons':addonsArray,
      "custom_addons":"test custom product"
    };
    print(_body);

    await ScopedModel.of<RestaurantsApiModel>(context).addToCart(_body).then((value) {
      if(value.status.status){

        if(mounted)
          _getCart();
      }

    });
  }
  void _getCart() async {
    await  ScopedModel.of<RestaurantsApiModel>(context).getCart(widget.vendorId).then((value) {
      if(value.status.status){
         setState(() {
           widget.total=value.data.products_price;
         });
        Navigator.pop(context,AddCart(value.data.products,value.data.products_price));

      }

      setState(() {
        _isLoading1=false;
      });
    });
  }

  void _getProductInfo() async{
    setState(() {
      _isLoading=true;
    });
    await ScopedModel.of<RestaurantsApiModel>(context).getProductInfo(widget.id).then((value){
      if(value.status.status){
        setState(() {
          _product=value.data;
          _totalPriceProduct=double.parse(_product.product_info?.price);
        });
        print(_product.product_info.product_id);
        if(_product.product_info.addons?.addon_category!=null)
          for(var i=0;i<_product.product_info.addons.addon_category.length;i++){
            List<bool> _isChecked=[];
            _lengthTrue.add(0);
          for(var i1=0;i1<_product.product_info.addons.addon_category[i].addons.length;i1++)
            _isChecked.add(false);
          _isCheckedAddons.add(_isChecked);
            print(_isCheckedAddons);
            print(i);
          }

      }
      setState(() {
        _isLoading=false;
      });
    });
  }

   _pressMinesButton() {
    if(_quantity!=1)
      setState(() {
        _quantity--;
        _totalPriceProduct=_totalPriceProduct-double.parse(_product.product_info.price);
      });
  }

  _pressPlusButton() {
    setState(() {
      _quantity++;
      _totalPriceProduct=_totalPriceProduct+double.parse(_product.product_info.price);
    });
  }
  _updateTotalProductCallBack(newTotalPrice){
    setState(()=> _totalPriceProduct=newTotalPrice);
  }


}




