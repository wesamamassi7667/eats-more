import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:eat_more_app/component/common/common.dart';
import 'package:eat_more_app/component/floating_cart_button.dart';
import 'package:eat_more_app/model/arguments/check_out_argument.dart';
import 'package:eat_more_app/model/arguments/item_detail_argument.dart';
import 'package:eat_more_app/model/arguments/restaurent_argument.dart';
import 'package:eat_more_app/widgets/category_item.dart';
import 'package:eat_more_app/widgets/category_product_item.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/component/scheduling_order_sheet.dart';
import 'package:eat_more_app/widgets/vendor_info_column.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/cart_response.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import '../color.dart';
import '../helper/helper.dart';

class RestaurantScreen extends StatefulWidget {
  final RestaurantArgument arguments;
  RestaurantScreen(this.arguments);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  var _selectedIndex = 0;
  var _isLoading = false;
  Restaurant restaurant;
  List<ProductInfo> _products;
  var _isLoading1 = false;
  String _selectedTime;
  List<ProductCart> _productCart;
  double _totalCart;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  String categoryType = Helper.constants.category_type;
  RestaurantArgument arguments;
  RestaurantsApiModel _model;

  @override
  void initState() {
    _products = [];
    _productCart = [];
    arguments = widget.arguments;
    _model = ScopedModel.of<RestaurantsApiModel>(context);

    // TODO: implement initState
    super.initState();
    _getVendorInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _back();
        return;
      },
      child: Scaffold(
        floatingActionButton: _productCart.isNotEmpty
            ? FloatingButton(
                text: _productCart.length.toString(),
                press: () => _navigateToCheckOutScreen(),
              )
            : SizedBox.shrink(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 310.0,
                floating: false,
                pinned: false,
                leading: CloseButton(
                    color: _isLoading ? black : background,
                    onPressed: () => _back()),
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
                                      restaurant.vendor_cover_img),
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
                                              shape: BoxShape
                                                  .circle, // to make border circle
                                              border: Border.all(
                                                color: black,
                                                width: 0.4,
                                              )),
                                          child: ClipOval(
                                            child: CachedNetworkImageComponent(
                                              url: restaurant.vendor_image,
                                              height: 100,
                                              width: 100,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        restaurant.vendor_desc,
                                        style: TextStyle(
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
                                                start: 12, end: 12, top: 19),
                                            padding: EdgeInsetsDirectional.only(
                                              start: 19.4,
                                              end: 14,
                                              top: 16,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: background,
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
                                                        '${restaurant.minimum_charge} ' +
                                                            AppLocalization.of(
                                                                    context)
                                                                .translate(
                                                                    "sr"),
                                                    title1: AppLocalization.of(
                                                            context)
                                                        .translate("minimum"),
                                                    icon:
                                                        'assets/images/card.svg',
                                                  ),
                                                  ColumnComponent(
                                                    title:
                                                        '${restaurant.delivery_cost} ' +
                                                            AppLocalization.of(
                                                                    context)
                                                                .translate(
                                                                    "sr"),
                                                    title1: AppLocalization.of(
                                                            context)
                                                        .translate("delivery"),
                                                    icon:
                                                        'assets/images/bicycle.svg',
                                                  ),
                                                  ColumnComponent(
                                                    title:
                                                        '${restaurant.delivery_time}',
                                                    title1: AppLocalization.of(
                                                            context)
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
                                            start: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.36533333333,
                                            end: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.36533333333,
                                            child: Container(
                                              height: 38,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                color: restaurant.status_open ==
                                                        'open'
                                                    ? green1
                                                    : restaurant.status_open ==
                                                            'close'
                                                        ? red
                                                        : const Color(
                                                            0xfff3bd53),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  restaurant.status_open,
                                                  style: TextStyle(
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
              ? MyProgressIndicator()
              : Container(
                  color: Colors.transparent,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          height: categoryType.contains('text') ? 50 : 94,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurant.menu_categories.length,
                              itemBuilder: (context, index) {
                                return CategoryItem(
                                  index: index,
                                  restaurant: restaurant,
                                  selectedIndex: _selectedIndex,
                                  type: categoryType,
                                  tap: () {
                                    if (index == _selectedIndex) {
                                      return;
                                    }
                                    setState(() => _selectedIndex = index);
                                    _getMenuProduct(restaurant
                                        .menu_categories[index].category_id);
                                  },
                                );
                              }),
                        ),
                        _isLoading1
                            ? Expanded(child: MyProgressIndicator())
                            : Flexible(
                                child: AnimatedList(
                                    key: _listKey,
                                    physics: ClampingScrollPhysics(), // <----
                                    itemBuilder: (context, index1, animation) {
                                      return CategoryProductItem(
                                        product: _products[index1],
                                        index: index1,
                                        animation: animation,
                                        tap: () =>
                                            _navigateToDetailsScreen(index1),
                                      );
                                    }),
                              ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void _getVendorInfo() async {
    setState(() => _isLoading = true);
    if (_model.isLoggedIn()) {
      _getCart();
    }
    await _model.viewVendorInfo(arguments.id).then((value) {
      if (value.status.status) {
        restaurant = value.data;
        _getMenuProduct(restaurant.menu_categories[0].category_id);
        if (restaurant.status_open != 'open') if (mounted)
          Common.showModalBottom(
                  context,
                  SchedulingOrderSheet(
                      start: restaurant.wt_start_at, end: restaurant.wt_end_at),
                  isDrag: false)
              .then((value) {
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
    _products.clear();
    setState(() => _isLoading1 = true);
    await _model.viewMenuProduct(menuId).then((value) {
      _loadItem(value?.data?.products_menu ?? []);
      setState(() => _isLoading1 = false);
    });
  }

  void _back() {
    var _count = 0;
    Navigator.popUntil(context, (Route<dynamic> route) => _count++ == 3);
  }

  Future<void> _loadItem(List<ProductInfo> data) async {
    for (ProductInfo item in data) {
      await Future.delayed(Duration(milliseconds: 300));
      _products.add(item);
      _listKey.currentState.insertItem(_products.length - 1);
    }
  }

  _navigateToDetailsScreen(int index) async {
    ItemDetailsArgument _arguments = ItemDetailsArgument(
        _products[index].product_id,
        _totalCart,
        restaurant.vendor_image,
        arguments.id);
    _navigate(_arguments, '/productDetail');
  }

  _navigate(dynamic arguments, String route) async {
    final values =
        await Navigator.pushNamed(context, '$route', arguments: arguments)
            as AddCart;
    if (values != null) {
      setState(() {
        _totalCart = values.total;
        _productCart = values.carts;
      });
    }
  }

  _navigateToCheckOutScreen() async {
    CheckOutArgument _arguments = CheckOutArgument(
        arguments.id,
        arguments.branch,
        arguments.idWay == 2 ? 0 : restaurant.delivery_cost,
        arguments.idWay,
        restaurant.vat_percentage,
        _selectedTime,
        _productCart,
        _totalCart,
        arguments.address,
        restaurant.minimum_charge,
        arguments.lat,
        arguments.lng,
        restaurant.VAT_NO);
    _navigate(_arguments, '/checkOut');
  }

  void _getCart() async {
    final response = await AppApi.cartClient.listCart(arguments.id);
    if (response != null) {
      _productCart.addAll(response.products);
      _totalCart = response.products_price;
    }
  }
}
