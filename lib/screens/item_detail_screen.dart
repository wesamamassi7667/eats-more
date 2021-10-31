import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/common/common.dart';
import 'package:eat_more_app/component/item_detail_component.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/component/vendor_logo.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/model/arguments/item_detail_argument.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


// ignore: must_be_immutable
class ItemDetailsScreen extends StatefulWidget {
  final ItemDetailsArgument arguments;
 ItemDetailsScreen(this.arguments,{Key key}) : super(key: key);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  var _isLoading=false;
  var _quantity=1;
  var _isLoading1=false;
  List<List<int>> selectedItems;
  Product _product;
  double _totalPriceProduct;
  List<AddonCategory> _addonCategories;
  String _addons;

  @override
  void initState() {
    // TODO: implement initState
    selectedItems=[];
    super.initState();
    _getProductInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: background,
          body: _isLoading?MyProgressIndicator():
          ScopedModelDescendant<RestaurantsApiModel>(
            builder:(context,child,model)=> NestedScrollView(
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
                            width: 40.0,height: 40.0,url:widget.arguments.vendorLogo
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
                    child: ItemDetailColumn(
                                quantity:_quantity,
                                item:_product.product_info,
                                pressMines:()=>_pressMinesButton(),
                                pressPlus:()=>_pressPlusButton(),
                                totalPriceProduct: _totalPriceProduct,
                                callBack: this._updateTotalProductCallBack,
                                 selectedItems: selectedItems,
                            ),
                  ),
                  PositionedDirectional(
                    start: 30,
                    end: 30,
                    bottom: 30,
                    child: ElevatedButton(
                      onPressed: (){
                        if(!model.isLoggedIn()){
                          Common.showSlideUpLoginView(context);
                          return;
                        }
                        _addToCart();
                      },
                      style: AppThemeData.elevatedButtonStyle(borderRadius: 10.0),
                      child:_isLoading1?Center(child: CupertinoActivityIndicator()): Row(
                        children: [
                          Text(
                            AppLocalization.of(context).translate('add_cart') ,
                          ),
                          Spacer(),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:'$_totalPriceProduct ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: orange
                                  )
                              ),
                              TextSpan(
                                  text:
                                  AppLocalization.of(context).translate("sr"),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  )
                              )
                            ]),
                          ),
                          // Text('$_totalPriceProduct ' + AppLocalization.of(context).translate('sr'))
                        ],
                      ),
                    )
                  ),

                ],
              ),
              ),
          ),
      );
  }
  void _addToCart() async{
    if(_product.product_info.addons!=null) {
      if(!_checkAddons()){
        return;
      }
      else{
      getAddonsString();
      }
    }
    setState(() => _isLoading1=true);
    var _body={
      "product_quantity":_quantity.toString(),
      "product_id":_product.product_info.product_id.toString(),
      "vendor_id":widget.arguments.vendorId.toString(),
      'product_addons':_addons??"",
      "custom_addons":"test custom product"
    };

    try{
    await AppApi.cartClient.addCart(_body);
      _getCart();
    }
    catch(err){
      setState(() => _isLoading1=false);
      AppDialog.showMe(context, err.toString());
    }
  }

  void _getCart() async {
    final response=await  AppApi.cartClient.listCart(widget.arguments.vendorId);
         setState(() => widget.arguments.totalCart=response.products_price);
        Navigator.pop(context,AddCart(response.products,response.products_price));
        setState(()=> _isLoading1=false);

  }

  void _getProductInfo() async{
    setState(()=> _isLoading=true);
    await ScopedModel.of<RestaurantsApiModel>(context).getProductInfo(widget.arguments.product_id).then((value){
      if(value.status.status){
        setState(() {
          _product=value.data;
          _totalPriceProduct=double.parse(_product.product_info?.price);
          _addonCategories=_product.product_info?.addons?.addon_category??[];
        });
        _initializeArray();
      }
      setState(() => _isLoading=false);
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

  void  getAddonsString() {
    _addons = "{\"addons\":[";
    for(var i1=0;i1<_addonCategories.length;i1++) {
      for(var i=0;i<_addonCategories[i1].addons.length;i++){
        Addons _addon=_addonCategories[i1].addons[i];
        if(selectedItems[i1].contains(_addon.addon_id)){
          _addons += "{\"addon_id\": \"${_product.product_info.addons.addon_category[i1].addons[i].addon_id.toString()}\"}," ;
        }
      }
    }
    _addons=_addons.substring(0,_addons.length-1);
    _addons += "]}";

  }

  bool _checkAddons(){
    for(var i1=0;i1<_addonCategories.length;i1++) {
      if (_addonCategories[i1].cat_is_mandatory)
        if (selectedItems[i1].length != _addonCategories[i1].cat_choose_maximum) {
          AppDialog.showMe(context,
              'You must add ' + '${_addonCategories[i1].cat_choose_maximum}' +
                  " additions from the " + _addonCategories[i1].cat_name);
          return false;
        }
    }
    return true;

  }

  _initializeArray(){
    for(int i=0;i<_addonCategories.length;i++){
      selectedItems.add([]);
    }
 }



}




