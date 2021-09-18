import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:eat_more_app/component/count_widget.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/cart_response.dart';
import 'package:eat_more_app/model/order_response.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';

class CartItem extends StatefulWidget {
  final Function press;
  final int index;
  final Order order;
  final List<ProductCart> carts;
  final int id;
  final Function pressPlus;
  final bool loading;
  final bool mines;
  final int selectedIndex;
  final Function pressMines;

  const CartItem({Key key, this.press, this.index, this.order, this.carts, this.id,
    this.pressPlus, this.loading=false, this.selectedIndex, this.pressMines, this.mines=false})
      : super(key: key);
  @override
  _CartItemState createState() => _CartItemState();
}


class _CartItemState extends State<CartItem> {
 List<bool> _isExpanded=[];
 @override
  void initState() {
   print(widget.index);
   if(widget.order==null){
     for(var i=0;i<=widget.carts.length;i++){
       _isExpanded.add(false);
     }
   }
   else
     for(var i=0;i<=widget.order.products.length;i++){
       _isExpanded.add(false);
     }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: widget.order != null ? 16 : 0),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  ExpandIcon(
                    isExpanded: _isExpanded[widget.index],
                    color: Colors.black,
                    expandedColor: Colors.black,
                    padding: EdgeInsets.zero,
                    // constraints: BoxConstraints(),
                    onPressed:(isExpanded) {
                      setState(() {
                        _isExpanded[widget.index]=!isExpanded;
                      });
                    },
                  ),


                  SizedBox(width: 3,),
                  Container(
                    width: widget.order != null ? 50 : 30,
                    height: widget.order != null ? 50 : 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImageComponent(
                        url: widget.order != null
                            ? widget.order.products[widget.index].image
                            : widget.carts[widget.index].product_image,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.order != null
                        ? widget.order.products[widget.index].product_name
                        : widget.carts[widget.index].product_name,
                    style: TextStyle(
                      fontFamily: 'DIN Next LT Arabic',
                      fontSize: 15,
                      color: grey4,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                widget.order != null
                    ? '${widget.order.products[widget.index].quantity}' +
                    "*" +
                    '${widget.order.products[widget.index].one_product_price}' +" "+
                    AppLocalization.of(context).translate("sr")
                    : '${widget.carts[widget.index].quantity}' +
                    "*" +
                    '${widget.carts[widget.index].one_product_price}' +" "+
                    AppLocalization.of(context).translate("sr"),
                style: TextStyle(
                  fontFamily: 'DIN Next LT Arabic',
                  fontSize: 12,
                  color: grey4,
                  fontWeight: FontWeight.w300,
                ),
              ),
              widget.order != null
                  ? SizedBox(
                height: 0,
              )
                  : CupertinoButton(
                onPressed:widget. press,
                child: Icon(
                  Icons.cancel_outlined,
                  color: grey4.withOpacity(0.79),
                ),
              ),
            ],
          ),
          widget.order!=null?SizedBox.shrink():Padding(
            padding: const EdgeInsetsDirectional.only(end: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CounterWidget(
                  quantity: widget.carts[widget.index].quantity,
                  press: widget.pressPlus,
                  loading:widget.loading,
                  index: widget.index,
                  selectedIndex: widget.selectedIndex,
                  pressMines: widget.pressMines,
                  mines: widget.mines,
                ),
              ],
            ),
          ),
          Visibility(
              visible: widget.order!=null?
              widget.order.products[widget.index].addons!=null&&_isExpanded[widget.index]?true:
              false:widget.carts[widget.index].addons!=null&&_isExpanded[widget.index]?true:false,
              child:Column(
                children: [
                  ListTile(
                    title: Text(AppLocalization.of(context).translate('additions')),
                  ),
                  Column(
                      children:List.generate(widget.order!=null?
                         widget.order.products[widget.index].addon?.length??0 :
                      widget.carts[widget.index].addons?.length??0, (index1) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 3),
                          child: Row(
                            children: [
                              Text(
                                widget.order!=null?
                                widget.order.products[widget.index].addon[index1].name:
                                widget.carts[widget.index].addons[index1].addon_name,style: TextStyle(
                                  fontFamily: 'DIN Next LT Arabic'

                              ),),
                              Spacer(),
                              Text(
                                widget.order!=null?
                                "${widget.order.products[widget.index].addon[index1].addon_price}" + " "+AppLocalization.of(context).translate("sr"):

                                "${widget.carts[widget.index].addons[index1].addon_price}" + " "+AppLocalization.of(context).translate("sr"),
                              ),

                            ],
                          ),
                        );
                      })
                  ),
                ],
              )
          )
        ],
      ),
    );
  }

}

