import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:eat_more_app/component/cart_button.dart';
import 'package:eat_more_app/component/container_component.dart';
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

class ResturantScreen extends StatefulWidget {
  final int id;
  final Branch branch;
  final int idWay;
  final String address;
  final String lat, lng;

  const ResturantScreen(
      {Key key,
      this.id,
      this.branch,
      this.idWay,
      this.address,
      this.lat,
      this.lng})
      : super(key: key);

  @override
  _ResturantScreenState createState() => _ResturantScreenState();
}

class _ResturantScreenState extends State<ResturantScreen> {
  var _selectedIndex = 0;
  var _isLoading = false;
  Restaurant resturant;
  List<ProductInfo> _products;
  var _isLoading1 = false;
  String _selectedTime;
  List<ProductCart> _productCart;
  double productsTotalPrice;

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
                  expandedHeight: 356.0,
                  floating: false,
                  pinned: false,
                  leading: CloseButton(
                    color: _isLoading ? black : background,
                    onPressed: () {
                      _back();
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: _isLoading
                        ? Center(
                            child: CupertinoActivityIndicator(),
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
                                    color: const Color(0xcc0068b0),
                                    border: Border.all(
                                        width: 1.0,
                                        color: const Color(0xcc707070)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 100),
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
                                                height: 180,
                                                width: 180,
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
                                              margin: EdgeInsetsDirectional.only(
                                                      start: 12,
                                                      end: 12,
                                                      top: 19),
                                              padding: EdgeInsetsDirectional.only(
                                                start: 19.4,
                                                end: 14,
                                                top: 16,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: const Color(0xffffffff),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0x17000000),
                                                    offset: Offset(
                                                        -9.056514739990234,
                                                        7.872708320617676),
                                                    blurRadius: 30,
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ColumnComponent(
                                                      title:
                                                          '${resturant.minimum_charge} ' +
                                                              AppLocalization.of(
                                                                      context)
                                                                  .translate(
                                                                      "sr"),
                                                      title1: AppLocalization
                                                              .of(context)
                                                          .translate("minimum"),
                                                      icon:
                                                          'assets/images/card.svg',
                                                    ),
                                                    ColumnComponent(
                                                      title:
                                                          '${resturant.delivery_cost} ' +
                                                              AppLocalization.of(
                                                                      context)
                                                                  .translate(
                                                                      "sr"),
                                                      title1:
                                                          AppLocalization.of(
                                                                  context)
                                                              .translate(
                                                                  "delivery"),
                                                      icon:
                                                          'assets/images/bicycle.svg',
                                                    ),
                                                    ColumnComponent(
                                                      title:
                                                          '${resturant.delivery_time}',
                                                      title1: AppLocalization
                                                              .of(context)
                                                          .translate(
                                                              "delivery_time"),
                                                      icon:
                                                          'assets/images/timer.svg',
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
                                                  color: resturant
                                                              .status_open ==
                                                          'open'
                                                      ? green1
                                                      : resturant.status_open ==
                                                              'close'
                                                          ? red
                                                          : const Color(
                                                              0xfff3bd53),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    resturant.status_open,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'DIN Next LT Arabic',
                                                      fontSize: 15,
                                                      color: const Color(
                                                          0xffffffff),
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
                    child: CupertinoActivityIndicator(),
                  )
                : SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   height: 0,
                        // ),
                        Container(
                          height: 94,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: resturant.menu_categories.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (index == _selectedIndex) return;
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                    _getMenuProduct(resturant
                                        .menu_categories[index].category_id);
                                  },
                                  child: SecondContainerComponent(
                                    start: index == 0 ? 16 : 18,
                                    end: index == resturant.menu_categories.length - 1 ? 16 : 0,
                                    topP: 10, startP: 5, endP: 5,
                                    height: 94.0,
                                    radius:BorderRadius.circular(
                                        index == _selectedIndex ? 5 : 0),
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(
                                    //       index == _selectedIndex ? 5 : 0),
                                    //   color: index == _selectedIndex
                                    //       ? Color(0xff0068B0)
                                    //       : Colors.transparent,
                                    //   boxShadow: [
                                    //     BoxShadow(
                                    //         color: index == _selectedIndex
                                    //             ? black.withOpacity(0.16)
                                    //             : Colors.transparent,
                                    //         blurRadius: 6,
                                    //         offset: Offset(0, 3)),
                                    //   ],
                                    // ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          padding: EdgeInsets.all(2),
                                          child: CachedNetworkImage(
                                            imageUrl: resturant
                                                .menu_categories[index]
                                                .category_image,
                                            progressIndicatorBuilder: (context,
                                                url, downloadProgress) =>
                                                CupertinoActivityIndicator(),
                                            errorWidget: (BuildContext context,
                                                String url, Object error) {
                                              print(error);
                                              return const Icon(Icons.error);
                                            },
                                            // color: index == _selectedIndex
                                            //     ? Color(0xff0068B0)
                                            //     : background,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          resturant.menu_categories[index]
                                              .category_name,
                                          style: TextStyle(
                                            fontFamily: 'DIN Next LT Arabic',
                                            fontSize: 16,
                                            color: index == _selectedIndex
                                                ? background.withOpacity(0.98)
                                                : black1.withOpacity(0.98),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _isLoading1
                            ? Expanded(child: CupertinoActivityIndicator())
                            : Expanded(
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: _products.length,
                                    physics: ClampingScrollPhysics(),
                                    separatorBuilder: (context, index1) {
                                      return SizedBox(
                                        height: 17,
                                      );
                                    },
                                    itemBuilder: (context, index1) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemDetailsScreen(
                                                          id: _products[index1]
                                                              .product_id,
                                                          total:
                                                              productsTotalPrice,
                                                          logo: resturant
                                                              .vendor_image,
                                                          vendorId:
                                                              widget.id))).then(
                                              (value) {
                                            if (value != null) {
                                              setState(() {
                                                productsTotalPrice =
                                                    value.total;
                                                _productCart = value.carts;
                                              });
                                            }
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 11,
                                              top: 6,
                                              bottom: 14,
                                              end: 27),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: BoxDecoration(
                                              color: background,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xff9E9C9C)
                                                      .withOpacity(0.16),
                                                  blurRadius: 6,
                                                  offset: Offset(0, 3),
                                                )
                                              ]),
                                          child: Row(
                                            children: [
                                              Card(
                                                clipBehavior: Clip.antiAlias,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18)),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      _products[index1].image,
                                                  width: 96,
                                                  height: 96,
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CupertinoActivityIndicator(),
                                                  errorWidget:
                                                      (BuildContext context,
                                                          String url,
                                                          Object error) {
                                                    print(error);
                                                    return const Icon(
                                                        Icons.error);
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _products[index1]
                                                          .product_name,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'DIN Next LT Arabic',
                                                        fontSize: 18,
                                                        color: const Color(
                                                            0xff141414),
                                                      ),
                                                    ),
                                                    Text(
                                                      _products[index1]
                                                              .product_desc ??
                                                          "",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'DIN Next LT Arabic',
                                                        fontSize: 13,
                                                        color: const Color(
                                                            0xc7707070),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          _products[index1]
                                                                  .product_price +
                                                              " " +
                                                              AppLocalization.of(
                                                                      context)
                                                                  .translate(
                                                                      "sr"),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'DIN Next LT Arabic',
                                                            fontSize: 14,
                                                            color: const Color(
                                                                0xff0068b0),
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 14,
                                                        ),
                                                        _products[index1]
                                                                    .product_calories ==
                                                                null
                                                            ? SizedBox.shrink()
                                                            : Text(
                                                                _products[index1]
                                                                        .product_calories +
                                                                    " " +
                                                                    AppLocalization.of(
                                                                            context)
                                                                        .translate(
                                                                            'calorie'),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'DIN Next LT Arabic',
                                                                  fontSize: 14,
                                                                  color: const Color(
                                                                      0xff9d5000),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              // Spacer(),

                                              CupertinoButton(
                                                onPressed: () {
                                                  Helper.showProductSheet(
                                                          context,
                                                          _products[index1]
                                                              .product_id,
                                                          null,
                                                          widget.id,
                                                          null,
                                                          null)
                                                      .then((value) {
                                                    if (value != null)
                                                      setState(() {
                                                        productsTotalPrice =
                                                            value.total;
                                                        _productCart =
                                                            value.carts;
                                                      });
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.add_box_rounded,
                                                  size: 30,
                                                  color: primaryIconColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
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
                                        text: AppLocalization.of(context)
                                            .translate("view_cart"),
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
                                                          lng: widget.lng)));
                                          // showDialog(
                                          //     context: context,
                                          //     builder: (BuildContext context) =>
                                          //         CartDialog(
                                          //           id: widget.id,
                                          //           branch: widget.branch,
                                          //           deliveryCost:
                                          //           resturant.delivery_cost,
                                          //           idWay: widget.idWay,
                                          //           vat: resturant.vat_percentage,
                                          //           time: _selectedTime,
                                          //           carts:_productCart,
                                          //           total:productsTotalPrice,
                                          //            address:widget.address,
                                          //           minimum:resturant.minimum_charge,
                                          //           lat:widget.lat,
                                          //           lng:widget.lng
                                          //         ));
                                        })),
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
        .getCart(widget.id)
        .then((value) {
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
          showModalBottomSheet(
              context: context,
              enableDrag: false,
              isDismissible: false,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                  side: BorderSide(width: 1, color: grey4)),
              builder: (context) {
                return SchedulingOrderSheet(
                    start: resturant.wt_start_at, end: resturant.wt_end_at);
              }).then((value) {
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
    if (mounted)
      setState(() {
        _isLoading1 = true;
        _products.clear();
      });
    if (mounted)
      await ScopedModel.of<RestaurantsApiModel>(context)
          .viewMenuProduct(menuId)
          .then((value) {
        if (mounted)
          setState(() {
            _products.addAll(value.data.products_menu);
            _isLoading1 = false;
          });
      });
  }

  void _back() {
    var _count = 0;
    Navigator.popUntil(context, (Route<dynamic> route) => _count++ == 3);
  }
}
