
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/app_text_field.dart';
import 'package:eat_more_app/component/close_button_sheet.dart';
import 'package:eat_more_app/component/radio_list_tile.dart';
import 'package:eat_more_app/component/rajhi_sheet.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/check_out_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';
class CouponSheet extends StatefulWidget {
  final List<Payment> types;
  final int id;
  final String type;
  final double total;

  const CouponSheet({Key key, this.types, this.id, this.type, this.total}) : super(key: key);
  @override
  _CouponSheetState createState() => _CouponSheetState();
}

class _CouponSheetState extends State<CouponSheet> {
  FocusNode _codeFocusNode = new FocusNode();
  TextEditingController _code = new TextEditingController();
  var _showSecond=false;
  var _isLoading=false;
  int _selectedIndex=0;
  var _selectedType='';
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      child: AnimatedCrossFade(
        crossFadeState:
        _showSecond ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 400),
        firstChild: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.45,
          minChildSize: 0.45,
          maxChildSize: 0.7,
          builder:(context,controller)=>  SingleChildScrollView(
               controller: controller,
              child: Container(
                  padding: EdgeInsetsDirectional.only(top: 10,bottom: 30),
                  child: Column(
                    children: [
                      Text(AppLocalization.of(context).translate("coupon_type"),style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 10,),
                      ListView.separated(
                           shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context,index){
                            return RadioListTilePayment(
                              index: index,
                              paymentMethods: widget.types,
                              selectedIndex: _selectedIndex,
                              onChanged: (v){
                                setState(() {
                                  _selectedIndex=index;
                                  _selectedType=widget.types[_selectedIndex].key;
                                });
                              },
                            );
                          }, separatorBuilder: (context,index){
                            return Divider(
                              color: grey4.withOpacity(0.24),
                              thickness: 1,
                            );
                          }, itemCount:widget.types.length ),

                      SizedBox(height: 15,),
                      Container(
                        width:double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          child:Text(AppLocalization.of(context).translate("select")) ,
                          onPressed: (){
                            setState(() {
                              _showSecond=true;

                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
            ),
        ),
        secondChild: _selectedType=='rajhi'?RajhiSheet(total:widget.total):Container(
          height: 254,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CloseButtonSheet(),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 33),
                  child: APPTextField(
                    hintText: AppLocalization.of(context).translate("coupon_code"),
                    focusNode: _codeFocusNode,
                    nextFocus: null,
                    textEditingController: _code,
                    textType: TextInputType.name,
                    // errMessage: 'الاسم مطلوب',
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 33),
                  child: ElevatedButton(
                    child: Text(AppLocalization.of(context).translate("add")),
                    onPressed: ()=> _applyCoupon(),

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _applyCoupon() async{
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading=true;
    });
    var _body={
      "code_coupon":_code.text.trim(),
      "type":widget.type,
    };
    await ScopedModel.of<RestaurantsApiModel>(context).applyCoupon(widget.id,_body ).then((value) {
      if(value.status.status){
        Navigator.pop(context,[value.data.couponDiscountAmount,value.data.finalPrice,value.data.couponCode,"",""]);
        AppDialog.showMe(context, value.status.HTTP_response,isError: false);
      }
      else{
        AppDialog.showMe(context, value.status.HTTP_response);}
      setState(() {
        _isLoading=false;
      });
    });
  }
}

