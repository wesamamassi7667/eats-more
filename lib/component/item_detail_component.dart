import 'package:eat_more_app/component/text_with_line.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class ItemDetailColumn extends StatefulWidget {
  final ProductInfo item;
  final Function pressPlus,pressMines;
 final List<int> lengthTrue;
  final int quantity;
  final List<List<bool>> isChecked;
  final double totalPriceProduct;
  final Function callBack;
 ItemDetailColumn({
    Key key, this.item, this.pressPlus, this.pressMines, this.quantity, this.isChecked, this.lengthTrue, this.totalPriceProduct, this.callBack
  }) : super(key: key);
  @override
  _ItemDetailColumnState createState() => _ItemDetailColumnState();
}

class _ItemDetailColumnState extends State<ItemDetailColumn> {
  ProductInfo _product;
  List<AddonCategory> addonCategoryList;
  double _totalProductPrise;
  @override
  void initState() {
    _product=widget.item;
    addonCategoryList=_product.addons?.addon_category??[];
    _totalProductPrise=widget.totalPriceProduct;
    // TODO: implement initState

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                    _product.product_name,
                    style: TextStyle(
                      fontSize: 20,
                      color: black2,
                      height: 0.9
                    ),
                  ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWithLine(isOffer: _product.product_offer==null?false:true, price:_product.price ,),
                  _product.product_offer==null? SizedBox.shrink():Text(
                    "${_product.product_offer.offer_new_price}" +" "+AppLocalization.of(context).translate("sr"),
                    style:TextStyle(
                      fontSize: 16,
                      color: black,
                      height: 0.9
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),

        SizedBox(
          height: 22,
        ),
        _product.product_desc==null?SizedBox.shrink(): Padding(
          padding: EdgeInsetsDirectional.only(start: 16,end: 16),
          child: Text(
            _product.product_desc,
            style: TextStyle(
              fontSize: 13,
              color: grey4.withOpacity(0.78),
            ),
            maxLines: 3,
          ),
        ),
        _product.product_calories==null?SizedBox.shrink():  Padding(
          padding: const EdgeInsetsDirectional.only(start: 16,top: 3),
          child: Text(
            '${_product.product_calories} ' + AppLocalization.of(context).translate('calorie') ,
            style: TextStyle(
                fontSize: 13,
                color: grey4.withOpacity(0.78)
            ),

          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5,right:16,left: 16 ),
          child: Divider(
            color: grey4.withOpacity(0.24),
          ),
        ),
        SizedBox(height: 15,),
        Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start:16.0),
              child: Text(
                AppLocalization.of(context).translate("quantity"),
                style: TextStyle(
                  fontFamily: 'DIN Next LT Arabic',
                  fontSize: 20,
                  color: black1,
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                CupertinoButton(
                  onPressed: widget.pressPlus,
                  child: Icon(
                    Icons.add_box_rounded,
                    size: 20,
                    color: primaryIconColor,
                  ),
                ),
                Text(
                  '${widget.quantity}',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 23,
                    color: const Color(0xff141414),
                    fontWeight: FontWeight.w500,
                  ),

                ),
                CupertinoButton(
                  onPressed: widget.pressMines ,
                  child: Icon(
                    Icons.indeterminate_check_box_rounded,
                    size: 20,
                    color: primaryIconColor,
                  ),
                ),
              ],
            ),

          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5,right:16,left: 16),
          child: Divider(
            color: grey4.withOpacity(0.24),
          ),
        ),
        _product.addons?.addon_category==null?SizedBox.shrink():  Column(
          children: [
            SizedBox(height: 12.4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 16),
                  child: Text(
                    AppLocalization.of(context).translate("additions"),
                    style: TextStyle(
                      fontFamily: 'DIN Next LT Arabic',
                      fontSize: 20,
                      color: black1,
                    ),

                  ),
                ),
              ],
            ),
            // SizedBox(height: 15,),
            ListView.builder(
                itemCount: addonCategoryList.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context,index){

                  AddonCategory addonCategory=addonCategoryList[index];
                  int _lengthChecked=widget.lengthTrue[index];

                  return ExpansionTile(
                      title:   Row(
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                           Container(
                             width:MediaQuery.of(context).size.width-200,
                             child: Text(
                                    addonCategory.cat_name +
                                        '${addonCategory.cat_is_mandatory == true?"*":""}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: black1,
                                    ),
                                    maxLines: 2,

                                  ),
                           ),


                          Spacer(),
                              addonCategory.cat_choose_type=='multi'? Text(
                              widget.isChecked[index].contains(true)?
                              '$_lengthChecked/${addonCategory.cat_choose_maximum}'
                              :AppLocalization.of(context).translate('choose') +' ${addonCategory.cat_choose_maximum}' ,
                              style: TextStyle(
                                fontSize: 12,
                                color: black1,
                              ),

                            ):Text(
                            '${addonCategory.cat_choose_maximum}',
                           style: TextStyle(
                             fontFamily: 'DIN Next LT Arabic',
                             fontSize: 15,
                             color: black1,
                           ),
                            ),

                        ],
                      ),
                      leading: Icon(
                        Icons.add,
                        color: black,
                      ),
                      children: List.generate(addonCategory.addons.length, (index1) {
                        Addons addons=addonCategory.addons[index1];
                        bool _isChecked=widget.isChecked[index][index1];
                        return Row(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Checkbox(
                                  activeColor: black,
                                  value: _isChecked, onChanged:(v){
                                setState(() {
                                  if(_lengthChecked!=addonCategory.cat_choose_maximum){
                                    widget.isChecked[index][index1]=v;
                                    if(widget.isChecked[index][index1]){
                                      widget.lengthTrue[index]=widget.lengthTrue[index]+1;
                                      widget.callBack(widget.totalPriceProduct+addons.addon_price);
                                    }
                                    else{
                                      widget.lengthTrue[index]--;
                                      widget.callBack(widget.totalPriceProduct-addons.addon_price);
                                    }
                                    print(widget.lengthTrue[index]);
                                  }
                                  else if(widget.isChecked[index][index1]){
                                    widget.isChecked[index][index1]=!widget.isChecked[index][index1];
                                    widget.lengthTrue[index]=widget.lengthTrue[index]-1;
                                    widget.callBack(widget.totalPriceProduct-addons.addon_price);

                                    print(widget.lengthTrue[index]);}
                                });
                              }),
                            ),
                            Text(
                             addons.addon_name ,
                              style: TextStyle(
                                fontSize: 15,
                                color:black1,
                              ),
                            ),
                            Spacer(),
                            addons.addon_price.toString().trim()=="0.0"?  SizedBox.shrink():Padding(
                              padding: const EdgeInsetsDirectional.only(end:8.0),
                              child: Text(
                                '${addons.addon_price}' +' '+AppLocalization.of(context).translate("sr"),
                                style: TextStyle(
                                  fontFamily: 'DIN Next LT Arabic',
                                  fontSize: 13,
                                  color: grey2,
                                ),
                              ),
                            ),
                          ],
                        );
                      })

                  );
                }

            ),
          ],
        )


      ],
    );
  }
}


