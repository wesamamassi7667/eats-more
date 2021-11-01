import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/app_bar_home.dart';
import 'package:eat_more_app/component/custom_progress_dialog.dart';
import 'package:eat_more_app/component/dot.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/component/profile_photo_avatar.dart';
import 'package:eat_more_app/component/restaurent_list.dart';
import 'package:eat_more_app/component/slider_image.dart';
import 'package:eat_more_app/component/tile_drawer.dart';
import 'package:eat_more_app/component/top_sheet.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/home_response.dart';

import 'package:eat_more_app/screens/edit_profile_screen.dart';
import 'package:eat_more_app/screens/faq_screen.dart';
import 'package:eat_more_app/component/header_list_meal.dart';
import 'package:eat_more_app/screens/order_screen.dart';
import 'package:eat_more_app/widgets/drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'contact_us_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey keyHome;
  final Function callBack;

  const HomeScreen({Key key, this.keyHome, this.callBack}) : super(key: key);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<SliderImage> _images;
  List<Restaurant> _restaurant;
  List<SpecSlider> _specSlider;
  List<SliderImage> _ads;
  var _isLoading=false;
  AnimationController _controller;
  Animation<RelativeRect> _animation;
  var _currentIndex = 0;
  CustomProgressDialog pr;


  _change(index, r) {
    setState(() =>_currentIndex = index);
  }


  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000), value: 0.0);
    _images=[];
    _restaurant=[];
    _specSlider=[];
    _ads=[];

    // TODO: implement initState
    super.initState();
    getHomeProduct();
  }

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
        builder: (context,constraints){
          _animation = RelativeRectTween(
            begin: new RelativeRect.fromLTRB(0.0, -constraints.biggest.height,
                0.0, constraints.biggest.height),
            end: new RelativeRect.fromLTRB(
                0.0, 0.0, 0.0, constraints.biggest.height - 220.0),
          ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
          return Stack(
            children: [
              Scaffold(
                key: _scaffoldKey,
                appBar: AppBarWidget(
                  key1: _scaffoldKey,
                ),
                drawer: DrawerWidget(callBack:widget.callBack),
                body: _isLoading?MyProgressIndicator():SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                   _images.isEmpty?SizedBox.shrink():  SliderWidget(
                        sliders: _images,
                        change: _change,
                      ),
                      SizedBox(
                        height: 3.16,
                      ),
                      _images.isEmpty?SizedBox.shrink():  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: map<Widget>(_images, _handler),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      RestaurantsList(
                        list:_restaurant,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: _specSlider.length,
                          itemBuilder: (context,index){
                            return  HeaderListMeal(
                                item:_specSlider[index],
                                controller:_controller,
                                ads:_ads
                            );
                          }
                          )
                    ],
                  ),
                ),
              ),
              PositionedTransition(
                rect: _animation,
                child: TopSheet(
                    pressContinuo: () {
                      setState(() {
                        _controller.fling(velocity: -1.0);
                      });
                    },
                  ),

                ),

            ],
          );
        },
    );
  }

  List<T> map<T>(List<SliderImage> images, Function handler) {
    List<T> result = [];
    for (var i = 0; i < _images.length; i++) {
      result.add(handler(i));
    }
    return result;
  }

  _handler(index) {
    return _currentIndex == index ? ActiveDot() : UnActiveDotHome();
  }

  void getHomeProduct() async{
    setState(() => _isLoading=true);
    await ScopedModel.of<RestaurantsApiModel>(context).listHome().then((value) {
      if(value.status.status){
        setState(() {
          _specSlider.addAll(value.data.spes_slider);
          _images.addAll(value.data.slider??[]);
          _restaurant.addAll(value.data.Vendor);
          if(value.data.ads!=null)
          _ads.addAll(value.data.ads);
          _isLoading=false;
        });
      }
    });
  }

  // void _logOut() async{
  //   pr.showDialog();
  //   await ScopedModel.of<RestaurantsApiModel>(context).logout().whenComplete(() => pr.hideDialog()).then((value){
  //     UtilSharedPreferences.clear();
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (_) => LoginScreen()),
  //             (route) => false);
  //   });
  // }
}

