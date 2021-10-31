import 'package:eat_more_app/component/text_with_line.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/widgets/counter_cart_widget.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class ItemDetailColumn extends StatefulWidget {
  final ProductInfo item;
  final Function pressPlus, pressMines;
  final List<List<int>> selectedItems;
  final int quantity;
  final double totalPriceProduct;
  final Function callBack;
  const ItemDetailColumn(
      {Key key,
      this.item,
      this.pressPlus,
      this.pressMines,
      this.selectedItems,
      this.quantity,
      this.totalPriceProduct,
      this.callBack})
      : super(key: key);

  @override
  _ItemDetailColumnState createState() => _ItemDetailColumnState();
}

class _ItemDetailColumnState extends State<ItemDetailColumn> {
  ProductInfo _product;
  List<AddonCategory> addonCategoryList;

  @override
  void initState() {
    _product = widget.item;
    addonCategoryList = _product.addons?.addon_category ?? [];
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
                style: TextStyle(fontSize: 20, height: 0.9),
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWithLine(
                    isOffer: _product.product_offer == null ? false : true,
                    price: _product.price,
                  ),
                  _product.product_offer == null
                      ? SizedBox.shrink()
                      : Text(
                          "${_product.product_offer.offer_new_price}" +
                              " " +
                              AppLocalization.of(context).translate("sr"),
                          style: TextStyle(fontSize: 16, height: 0.9),
                        ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 22,
        ),
        _product.product_desc == null
            ? SizedBox.shrink()
            : Padding(
                padding: EdgeInsetsDirectional.only(start: 16, end: 16),
                child: Text(
                  _product.product_desc,
                  style: TextStyle(
                    fontSize: 13,
                    color: grey4.withOpacity(0.78),
                  ),
                  maxLines: 3,
                ),
              ),
        _product.product_calories == null
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsetsDirectional.only(start: 16, top: 3),
                child: Text(
                  '${_product.product_calories} ' +
                      AppLocalization.of(context).translate('calorie'),
                  style: TextStyle(fontSize: 13, color: grey4.withOpacity(0.78)),
                ),
              ),
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 16, left: 16),
          child: Divider(
            color: grey4.withOpacity(0.24),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start:16.0),
              child: Text(
                AppLocalization.of(context).translate("quantity"),
                style: TextStyle(fontSize: 20,),
              ),
            ),
            Spacer(),
            CountCartWidget(pressPlus:widget.pressPlus, pressMines: widget.pressMines, quantity: widget.quantity,),
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
                      fontSize: 20,
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
                  int _lengthChecked=widget.selectedItems[index].length;
                  return ExpansionTile(
                      title:   Row(
                        children: [
                          Container(
                            width:MediaQuery.of(context).size.width-200,
                            child: Text(
                              addonCategory.cat_name + '${addonCategory.cat_is_mandatory == true?"*":""}',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              maxLines: 2,

                            ),
                          ),
                          Spacer(),
                          addonCategory.cat_choose_type=='multi'? Text(
                            widget.selectedItems[index].isNotEmpty?
                            '$_lengthChecked/${addonCategory.cat_choose_maximum}'
                                :AppLocalization.of(context).translate('choose') +' ${addonCategory.cat_choose_maximum}' ,
                            style: TextStyle(
                              fontSize: 12,
                              color: black1,
                            ),

                          ):Text(
                            '${addonCategory.cat_choose_maximum}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),

                        ],
                      ),
                      leading: Icon(
                        Icons.add,
                      ),
                      children: List.generate(addonCategory.addons.length, (index1) {
                        Addons addons=addonCategory.addons[index1];
                        bool _isExist=widget.selectedItems[index].contains(addons.addon_id);
                        return Row(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Checkbox(
                                  activeColor: primaryIconColor,
                                  value: _isExist, onChanged:(v){
                                if(_lengthChecked<addonCategory.cat_choose_maximum){
                                  if(_isExist){
                                    _removeChecked(index,addons);
                                  }
                                  else{
                                    _addChecked(index,addons);
                                  }
                                }
                                else {
                                  if(_isExist)
                                    _removeChecked(index,addons);
                                }
                              }),
                            ),
                            Text(
                              addons.addon_name ,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                            addons.addon_price.toString().trim()=="0.0"?  SizedBox.shrink():Padding(
                              padding: const EdgeInsetsDirectional.only(end:8.0),
                              child: Text(
                                '${addons.addon_price}' +' '+AppLocalization.of(context).translate("sr"),
                                style: TextStyle(
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


  void _removeChecked(int index, Addons addons) {
    setState((){
      widget.selectedItems[index].remove(addons.addon_id);
    });
    widget.callBack(widget.totalPriceProduct-addons.addon_price);
  }

  _addChecked(index,Addons addons) {
    setState((){
      widget.selectedItems[index].add(addons.addon_id);
    });
    widget.callBack(widget.totalPriceProduct+addons.addon_price);
  }
}
