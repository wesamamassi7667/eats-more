import 'package:eat_more_app/component/ads_image.dart';
import 'package:eat_more_app/component/list_meal_height.dart';
import 'package:eat_more_app/component/list_width.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:eat_more_app/screens/item_detail_screen.dart';
import 'package:flutter/material.dart';

class HeaderListMeal extends StatefulWidget {
  final SpecSlider item;
  final List<SliderImage> ads;
  final AnimationController controller;

  const HeaderListMeal({Key key, this.item, this.ads, this.controller})
      : super(key: key);

  @override
  _HeaderListMealState createState() => _HeaderListMealState();
}

class _HeaderListMealState extends State<HeaderListMeal>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsetsDirectional.only(start: 23),
          child: Text(
            widget.item.sliderName,
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 22,
              color: Helper.convertColor(widget.item.color),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height:widget.item.viewType.isEmpty?0: 15,
        ),
        Container(
          height: widget.item.viewType.isEmpty?260: 354.5,
          child: ListView.builder(
              itemCount: widget.item.product.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                AnimationController ctrl = AnimationController(
                    duration: Duration(milliseconds: 1500), vsync: this);
                Animation scaleAnimation =
                    Tween(begin: 1.0, end: 0.7).animate(ctrl);
                selectItem(bool forward) =>
                    forward ? ctrl.forward() : ctrl.reverse();
                return ScaleTransition(
                  scale: scaleAnimation,
                  child: GestureDetector(
                    // onTapUp: (d)=>selectItem(false),
                    onTapDown: (d) => selectItem(true),
                    onTapCancel: () => selectItem(false),
                    onTap: () =>
                        selectItem(true).then((value) => selectItem(false).then(
                              (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemDetailsScreen(
                                          id: widget
                                              .item.product[index].product_id,
                                          logo: widget
                                              .item.product[index].vendor.logo,
                                          vendorId: widget.item.product[index]
                                              .vendor.vendor_id))),
                            )),
                    child: widget.item.viewType.isEmpty?
                    ListMealWidth(
                      item:widget.item,
                      controller:widget.controller,
                      index: index,
                    ):
                    ListMealHeight(
                        index: index,
                        controller: widget.controller,
                       item: widget.item,
                    ),
                  ),
                );
              }),
        ),
        widget.ads.isEmpty
            ? SizedBox.shrink()
            : AdsImageComponent(
                ads: widget.ads,
                item: widget.item,
              )
      ],
    );
  }
}
