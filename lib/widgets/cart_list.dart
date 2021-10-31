
import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/common/common.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:eat_more_app/widgets/cart_item.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/horozintal_divider.dart';
import 'package:eat_more_app/model/cart_response.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class CartList extends StatefulWidget {
  final int vendorId;
  final Function updateCartCallBack;
  final List<ProductCart> carts;

  const CartList({Key key, this.carts, this.vendorId, this.updateCartCallBack}) : super(key: key);
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  var _length=4;
  var _lengthCart;

  @override
  void initState() {
    // TODO: implement initState
    _lengthCart=widget.carts.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SecondContainerComponent(
      topP: 13,bottomP: 13,startP: 15,
      radius: const BorderRadius.all(Radius.circular(5)),
      child:
      ListView.separated(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context,index){
            if(_lengthCart>4&&_length!=_lengthCart&&index==3){
              return TextButton(
                child: Text(AppLocalization.of(context).translate('more')),
                onPressed: (){
                   setState(() {
                     _length=_lengthCart;
                   });
                },
                style: AppThemeData.textButtonStyle(backgroundColor: Colors.transparent,primary: primaryIconColor),
              );
            }
            return CartItem(
              productCart: widget.carts[index],
              index: index,
              pressPlus:()=>_updateQuantity(widget.carts[index],true,context),
              pressMines: ()=>widget.carts[index].quantity == 1
                  ? null:_updateQuantity(widget.carts[index], false, context),
              pressDelete:(){
                Common.showAlertDialog(
                    context,
                    AppLocalization.of(context).translate("sure_delete_item"),
                    AppLocalization.of(context).translate("remove"), () {
                  _deleteCart(widget.carts[index].basket_product_id,context);
                });
              } ,
            );
          },
          separatorBuilder:(_,index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HorizontalDivider(),
            );
          },
          itemCount: _lengthCart>4?_length:_lengthCart),


    );
  }

  _updateQuantity(ProductCart productCart, bool isPlus,BuildContext context) async {
    try{
      var _body = {
        "new_quantity": isPlus
            ? '${productCart.quantity + 1}'
            : '${productCart.quantity - 1}',
        "vendor_id": '${widget.vendorId}'
      };
      Common.showSingleAnimationDialog(context);
      await AppApi.cartClient.updateCart(productCart.basket_product_id, _body);
      _getCart(context);
    }
    catch(err){
      Common.showError(err,context);
    }
  }

  void _getCart(context) async{
    try{
      final response= await AppApi.cartClient.listCart(widget.vendorId);
      if (response != null) {
        widget.updateCartCallBack(response.products??[],response.products_price??0.0);
      }
      Navigator.pop(context);
    }
    catch(err){
      Common.showError(err,context);
    }
  }

  Future<void> _deleteCart(int cartId,context) async {
    try{
      Navigator.pop(context);
      Common.showSingleAnimationDialog(context);
      await AppApi.cartClient.deleteCart(cartId);
      _getCart(context);
    }
    catch(err){
      Common.showError(err, context);
    }
  }
}


