import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/model/initpayment/SDKInitiatePaymentResponse.dart';
import 'package:eat_more_app/model/check_out_response.dart';
import '../color.dart';

class CouponPaymentList extends StatefulWidget {
  const CouponPaymentList({Key key, this.methods, this.coupons, this.isCoupon=false, this.callBack}) : super(key: key);
  final List<PaymentMethods> methods;
  final List<Payment> coupons;
  final Function callBack;
  final bool isCoupon;

  @override
  _CouponPaymentListState createState() => _CouponPaymentListState();
}

class _CouponPaymentListState extends State<CouponPaymentList> {
  var _selectedPaymentIndex;
  var _length;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.isCoupon){
      _length=widget.coupons.length;
    }
    else{
      _length=widget.methods.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: widget.isCoupon?MainAxisAlignment.center:MainAxisAlignment.start,
      children: List.generate(_length, (index1) {
        var _item;
        if(widget.isCoupon){
        _item=widget.coupons[index1];
        }
        else{
        _item=widget.methods[index1];
        }
        return Padding(
            padding: EdgeInsetsDirectional.only(
                start: index1 == 0 ? 20 : 8),
            child: Stack(
              alignment: const AlignmentDirectional(-0.9, -1.1),
              children: [
                GestureDetector(
                  onTap:(){
                     if(_selectedPaymentIndex!=index1){
                       setState(() =>_selectedPaymentIndex=index1);
                       widget.callBack(widget.isCoupon?  _item.key:
                       _item.paymentMethodId.toString()
                       );
                     }
                    },
                  child: Container(
                    width: widget.isCoupon?140:null,
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 5),
                    // width: 77,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: index1 == _selectedPaymentIndex
                                ? primaryIconColor
                                : grey10,
                            width: 1.0)
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImageComponent(
                          url: widget.isCoupon?_item.image:_item.imageUrl,
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                              widget.isCoupon?_item.value: _item.paymentMethodAr,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: index1==_selectedPaymentIndex?true:false,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: primaryIconColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                )
              ],
            ));
      }),
    );
  }
}
