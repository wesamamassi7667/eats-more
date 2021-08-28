import 'package:eat_more_app/component/text_with_line.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class ItemDetailColumn extends StatefulWidget {
  final Product item;
  final Function pressPlus,pressMines;
 final List<int> lengthTrue;
  final int quantity;
  final List<List<bool>> isChecked;
  const ItemDetailColumn({
    Key key, this.item, this.pressPlus, this.pressMines, this.quantity, this.isChecked, this.lengthTrue
  }) : super(key: key);
  @override
  _ItemDetailColumnState createState() => _ItemDetailColumnState();
}

class _ItemDetailColumnState extends State<ItemDetailColumn> {
  @override
  void initState() {

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
            children: [
                Text(
                    widget.item.product_info.product_name,
                    style: TextStyle(
                      fontFamily: 'DIN Next LT Arabic',
                      fontSize: 20,
                      color: black2,
                    ),
                  ),
              Spacer(),
              TextWithLine(isOffer: widget.item.product_info.product_offer!=null, price:widget.item.product_info.price ,),

            ],
          ),
        ),
        widget.item.product_info.product_offer==null? SizedBox.shrink():Padding(
          padding: const EdgeInsetsDirectional.only(end: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.item.product_info.product_offer.offer_new_price +" "+AppLocalization.of(context).translate("sr"),
                style:TextStyle(
                  fontFamily: 'DIN Next LT Arabic',
                  fontSize: 16,
                  color: black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 22,
        ),
        widget.item.product_info.product_desc==null?SizedBox.shrink(): Padding(
          padding: EdgeInsetsDirectional.only(start: 16,end: 16),
          child: Text(
            widget.item.product_info.product_desc,
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 13,
              color: grey4.withOpacity(0.78),
            ),
            maxLines: 3,
          ),
        ),
        widget.item.product_info.product_calories==null?SizedBox.shrink():  Padding(
          padding: const EdgeInsetsDirectional.only(start: 16,top: 3),
          child: Text(
            '${widget.item.product_info.product_calories} ' + AppLocalization.of(context).translate('calorie') ,
            style: TextStyle(
                fontFamily: 'DIN Next LT Arabic',
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
        widget.item.product_info.addons?.addon_category==null?SizedBox.shrink():  Column(
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
                itemCount: widget.item.product_info.addons.addon_category.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context,index){


                  return ExpansionTile(
                      title:   Row(
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                           Container(
                             width:MediaQuery.of(context).size.width-200,
                             child: Text(
                                    widget.item.product_info.addons.addon_category[index].cat_name +
                                        '${widget.item.product_info.addons.addon_category[index].cat_is_mandatory == true?"*":""}',
                                    style: TextStyle(
                                      fontFamily: 'DIN Next LT Arabic',
                                      fontSize: 15,
                                      color: black1,
                                    ),
                                    maxLines: 2,

                                  ),
                           ),


                          Spacer(),
                         widget.item.product_info.addons.addon_category[index].cat_choose_type=='multi'? Text(
                              widget.isChecked[index].contains(true)?
                              '${widget.lengthTrue[index]}/${widget.item.product_info.addons.addon_category[index].cat_choose_maximum}'
                              :AppLocalization.of(context).translate('choose') +' ${widget.item.product_info.addons.addon_category[index].cat_choose_maximum}' ,
                              style: TextStyle(
                                fontFamily: 'DIN Next LT Arabic',
                                fontSize: 12,
                                color: black1,
                              ),

                            ):Text(
                            '${widget.item.product_info.addons.addon_category[index].cat_choose_maximum}',
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
                      children: List.generate(widget.item.product_info.addons.addon_category[index].addons.length, (index1) {
                        return Row(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Checkbox(
                                  activeColor: black,
                                  value: widget.isChecked[index][index1], onChanged:(v){
                                    setState(() {
                                      if(widget.lengthTrue[index]!=widget.item.product_info.addons.addon_category[index].cat_choose_maximum){
                                        widget.isChecked[index][index1]=v;
                                      if(widget.isChecked[index][index1])
                                        widget.lengthTrue[index]=widget.lengthTrue[index]+1;
                                      else
                                        widget.lengthTrue[index]--;
                                        print(widget.lengthTrue[index]);
                                      }
                                      else if(widget.isChecked[index][index1]){
                                        widget.isChecked[index][index1]=!widget.isChecked[index][index1];
                                     widget.lengthTrue[index]=widget.lengthTrue[index]-1;
                                     print(widget.lengthTrue[index]);}
                                    });
                              }),
                            ),
                            Text(
                              widget.item.product_info.addons.addon_category[index].addons[index1].addon_name ,
                              style: TextStyle(
                                fontFamily: 'DIN Next LT Arabic',
                                fontSize: 15,
                                color:black1,
                              ),
                            ),
                            Spacer(),
                            widget.item.product_info.addons.addon_category[index].addons[index1].addon_price.toString().trim()=="0.0"?  SizedBox.shrink():Padding(
                              padding: const EdgeInsetsDirectional.only(end:8.0),
                              child: Text(
                                '${widget.item.product_info.addons.addon_category[index].addons[index1].addon_price}' +' '+AppLocalization.of(context).translate("sr"),
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


