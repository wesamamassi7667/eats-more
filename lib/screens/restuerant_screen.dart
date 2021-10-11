import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:eat_more_app/component/cart_button.dart';
import 'package:eat_more_app/component/category_item.dart';
import 'package:eat_more_app/component/category_product_item.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/component/scheduling_order_sheet.dart';
import 'package:eat_more_app/component/vendor_info_column.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/branch_response.dart';
import 'package:eat_more_app/model/cart_response.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/screens/item_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';
import '../helper/helper.dart';
import 'check_out_screen.dart';

class RestaurantScreen extends StatefulWidget {
  final int id;
  final Branch branch;
  final int idWay;
  final String address;
  final String lat, lng;

  const RestaurantScreen(
      {Key key,
      this.id,
      this.branch,
      this.idWay,
      this.address,
      this.lat,
      this.lng})
      : super(key: key);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  var _selectedIndex = 0;
  var _isLoading = false;
  Restaurant resturant;
  List<ProductInfo> _products;
  var _isLoading1 = false;
  String _selectedTime;
  List<ProductCart> _productCart;
  double productsTotalPrice;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  String categoryType=Helper.constants.category_type;

  @override
  void initState() {
    _products = [];
    _productCart = [];
    // TODO: implement initState
    super.initState();
    _getVendorInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _back();
      },
      child: Scaffold(
        backgroundColor: background,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 310.0,
                  floating: false,
                  pinned: false,
                  leading: CloseButton(
                    color: _isLoading ? black : background,
                    onPressed: () => _back()

                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: _isLoading
                        ? Center(
                            child: MyProgressIndicator(),
                          )
                        : Stack(
                            children: [
                              Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: Helper.buildCachedNetworkImageProvider(
                                        resturant.vendor_cover_img),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                  height: 268,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                  color: primaryIconColor.withOpacity(0.8),

                                    border: Border.all(
                                        width: 1.0,
                                        color: const Color(0xcc707070)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 50),
                                      decoration: BoxDecoration(
                                          color: background,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: black.withOpacity(0.1),
                                                blurRadius: 32,
                                                offset: Offset(8, -16)),
                                          ]),
                                    ),
                                    Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: black,
                                                  width: 0.4,
                                                )),
                                            child: ClipOval(
                                              child: CachedNetworkImageComponent(
                                                url: resturant.vendor_image,
                                                height: 100,
                                                width: 100,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          resturant.vendor_desc,
                                          style: TextStyle(
                                            fontFamily: 'DIN Next LT Arabic',
                                            fontSize: 12,
                                            color: const Color(0xe0242424),
                                            fontWeight: FontWeight.w300,
                                            height: 1.6666666666666667,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 13,
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              height: 67,
                                              margin: EdgeInsetsDirectional.only(start: 12, end: 12, top: 19),
                                              padding: EdgeInsetsDirectional.only(start: 19.4, end: 14, top: 16,),
                                              decoration: BoxDecoration(
                                                borderRadius:BorderRadius.circular(10.0),
                                                color: background,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                    const Color(0x17000000),
                                                    offset: Offset(-9.056514739990234, 7.872708320617676),
                                                    blurRadius: 30,
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 4.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    ColumnComponent(
                                                      title: '${resturant.minimum_charge} ' + AppLocalization.of(context).translate("sr"),
                                                      title1: AppLocalization.of(context).translate("minimum"),
                                                      icon: 'assets/images/card.svg',
                                                    ),
                                                    ColumnComponent(
                                                      title: '${resturant.delivery_cost} ' + AppLocalization.of(context).translate("sr"),
                                                      title1: AppLocalization.of(context).translate("delivery"),
                                                      icon: 'assets/images/bicycle.svg',
                                                    ),
                                                    ColumnComponent(
                                                      title: '${resturant.delivery_time}',
                                                      title1: AppLocalization.of(context).translate("delivery_time"),
                                                      icon: 'assets/images/timer.svg',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            PositionedDirectional(
                                              top: 0,
                                              start: MediaQuery.of(context).size.width * 0.36533333333,
                                              end: MediaQuery.of(context).size.width * 0.36533333333,
                                              child: Container(
                                                height: 38,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  color: resturant.status_open == 'open' ? green1
                                                      : resturant.status_open == 'close' ? red : const Color(0xfff3bd53),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    resturant.status_open,
                                                    style: TextStyle(
                                                      fontFamily: 'DIN Next LT Arabic',
                                                      fontSize: 15,
                                                      color: background,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ];
            },
            body: _isLoading
                ? Center(
                    child: MyProgressIndicator(),
                  )
                : SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height:categoryType.contains('text')?50: 94,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: resturant.menu_categories.length,
                              itemBuilder: (context, index) {
                                return CategoryItem(
                                    index: index,
                                    restaurant: resturant,
                                    selectedIndex: _selectedIndex,
                                    type:categoryType,
                                    tap: (){
                                      if (index == _selectedIndex){
                                        return;
                                      }
                                      setState(()=> _selectedIndex = index);
                                      _getMenuProduct(resturant
                                          .menu_categories[index].category_id);
                                    },
                                );
                              }),
                        ),
                        _isLoading1
                            ? Expanded(child:MyProgressIndicator())
                            : Expanded(
                                child:  AnimatedList(
                                    key: _listKey,
                                    itemBuilder: (context, index1,animation){
                                      return CategoryProductItem(
                                        product: _products[index1],
                                        index: index1,
                                        animation:animation,
                                        tap:() => _navigateToDetailsScreen(index1),
                                      );
                                    }
                                )
                              ),
                        _productCart.isNotEmpty
                            ? SafeArea(
                                top: false,
                                child: Container(
                                    // height: 56.33,
                                    margin: EdgeInsetsDirectional.only(
                                        bottom: 30, start: 30, end: 30),
                                    width: double.maxFinite,
                                    child: CartButton(
                                        total: productsTotalPrice,
                                        text: AppLocalization.of(context).translate("view_cart"),
                                        color: primaryIconColor,
                                        tap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CheckOutScreen(
                                                          id: widget.id,
                                                          branch: widget.branch,
                                                          deliveryCost: resturant
                                                              .delivery_cost,
                                                          idWay: widget.idWay,
                                                          vat: resturant
                                                              .vat_percentage,
                                                          time: _selectedTime,
                                                          carts: _productCart,
                                                          total:
                                                              productsTotalPrice,
                                                          address:
                                                              widget.address,
                                                          minimum: resturant
                                                              .minimum_charge,
                                                          lat: widget.lat,
                                                          lng: widget.lng)
                                              )
                                          );
                                        }
                                        )
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  )),
      ),
    );
  }


  void _getVendorInfo() async {
    setState(() {
      _isLoading = true;
    });
    await ScopedModel.of<RestaurantsApiModel>(context)
        .getCart(widget.id).then((value) {
      if (value.status.status) if (value.data != null) {
        _productCart.addAll(value.data.products);
        productsTotalPrice = value.data.products_price;
      }
    });
    await ScopedModel.of<RestaurantsApiModel>(context)
        .viewVendorInfo(widget.id)
        .then((value) {
      if (value.status.status) {
        resturant = value.data;
        _getMenuProduct(resturant.menu_categories[0].category_id);
        if (resturant.status_open != 'open') if (mounted)
          Helper.showModalBottom(context,SchedulingOrderSheet(
              start: resturant.wt_start_at, end: resturant.wt_end_at),isDrag: false).then((value) {
            if (value != null && value[0] != null) _selectedTime = value[0];
          });
      }
      if (mounted)
        setState(() {
          _isLoading = false;
        });
    });
  }


  void _getMenuProduct(int menuId) async {
    print(menuId);
    _products.clear();
    setState(() =>_isLoading1 = true);
      await ScopedModel.of<RestaurantsApiModel>(context)
          .viewMenuProduct(menuId).then((value) {
           _loadItem(value.data.products_menu);
          setState(() => _isLoading1 = false);
      });
  }

  void _back() {
    var _count = 0;
    Navigator.popUntil(context, (Route<dynamic> route) => _count++ == 3);
  }

  Future<void> _loadItem(List<ProductInfo> data) async {
    for(ProductInfo item in data){
      await Future.delayed(Duration(milliseconds: 300));
      _products.add(item);
      _listKey.currentState.insertItem(_products.length - 1);
    }
  }

  _navigateToDetailsScreen(int index) {
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) =>
                ItemDetailsScreen(
                    id: _products[index].product_id,
                    total: productsTotalPrice,
                    logo: resturant.vendor_image,
                    vendorId: widget.id))).then((value) {
      if (value != null) {
        setState(() {
          productsTotalPrice = value.total;
          _productCart = value.carts;
        });
      }
    });
  }
}
