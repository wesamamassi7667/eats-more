
import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/horozintal_divider.dart';
import 'package:eat_more_app/component/radio_list_tile.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/check_out_response.dart';
import 'package:eat_more_app/widgets/first_payment_tile.dart';
import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/model/initpayment/SDKInitiatePaymentResponse.dart';
 class PaymentMethodWidget extends StatefulWidget {
   const PaymentMethodWidget({Key key, this.paymentsType, this.paymentMethods, this.callBack, this.idCallBack}) : super(key: key);
   final List<Payment> paymentsType;
   final List<PaymentMethods> paymentMethods;
   final Function callBack,idCallBack;

   @override
   _PaymentMethodWidgetState createState() => _PaymentMethodWidgetState();
 }

 class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
   var _selectedIndex;
   var _isExpanded=false;
   var _selectedId;
   @override
   Widget build(BuildContext context) {
     return SecondContainerComponent(
       startP: 15,topP: 13,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(AppLocalization.of(context).translate("payment_method"),
             style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.w500
             ),
           ),
           ListView.separated(
               shrinkWrap: true,
               physics: ClampingScrollPhysics(),
               itemBuilder: (context, index) {
                 // _isExpanded= _selectedIndex==0?true:false;
                 if (widget.paymentsType[index].key=='visa')
                   return _buildFirstTile(index);
                 return _otherTiles(index);
               },
               separatorBuilder: (context, index) {
                 return HorizontalDivider();
               },
               itemCount: widget.paymentsType.length)
         ],
       ),
     );
   }

   Widget _buildFirstTile(index) {
     return Theme(
       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
       child: FirstPaymentTile(
         paymentType:widget.paymentsType[index],
         methods: widget.paymentMethods,
         selectedIndex: _selectedIndex,
         onchange: _onChange,
         index: index,
         onExpansionChange :(v)=>_onExpansionChange(v, index),
         isExpanded:_isExpanded,
         callBack:widget.idCallBack ,
       )
     );
   }

   Widget _otherTiles(int index) {
     return RadioListTilePayment(
       onChanged: _onChange,
       index: index,
       selectedIndex: _selectedIndex,
       paymentType: widget.paymentsType[index],
     );
   }

   _onChange(int index){
     if(_selectedIndex!=index){
      setState(() {
        _selectedIndex=index;
      });
      widget.callBack(widget.paymentsType[index].key);
     }
   }


   void  _onExpansionChange(bool v,int index){
     setState(() {
        _selectedIndex=index;
        _isExpanded=v;
     });
     widget.callBack(widget.paymentsType[index].key);
   }
 }
