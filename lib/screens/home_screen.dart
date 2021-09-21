import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/app_bar_home.dart';
import 'package:eat_more_app/component/custom_progress_dialog.dart';
import 'package:eat_more_app/component/dot.dart';
import 'package:eat_more_app/component/list_meal_height.dart';
import 'package:eat_more_app/component/list_width.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'contact_us_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<SliderImage> _images;
  List<Restaurant> _resturant;
  List<SpecSlider> _specSlider;
  List<SliderImage> _ads;
  var _isLoading=false;
  AnimationController _controller;
  Animation<RelativeRect> _animation;
  var _currentIndex = 0;
  CustomProgressDialog pr;
  var _lang;


  _change(index, r) {
    setState(() {
      _currentIndex = index;
    });
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
    _resturant=[];
    _specSlider=[];
    _ads=[];

    // TODO: implement initState
    super.initState();
    _getHomeProduct();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RestaurantsApiModel>(
      builder:(context,child,model)=> LayoutBuilder(
        builder: (context,constraints){
          if(model.language==1)
            _lang="English";
          else
            _lang='العربية';
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
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SafeArea(
                        child: Container(
                            margin: EdgeInsetsDirectional.only(bottom: 30, top: 30),

                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(start:16.0),
                              child: Row(
                                children: [
                                  ProfileAvatar(),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          toBeginningOfSentenceCase(
                                              model.loggedUser?.fname ?? AppLocalization.of(context).translate("no_username") ) + toBeginningOfSentenceCase(
                                              model.loggedUser?.last_name ?? ''),
                                          style: TextStyle(
                                            fontFamily: 'DIN Next LT Arabic',
                                            fontSize: 15,
                                            color: black3,
                                          ),
                                        ),
                                     Text(
                                          'الرياض' + '\n' + 'النقاط',
                                          style: TextStyle(
                                            fontFamily: 'DIN Next LT Arabic',
                                            fontSize: 15,
                                            color: black2,
                                          ),
                                        ),


                                    ],
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                      Divider(),
                      TileDrawer(
                        name:  AppLocalization.of(context).translate("home"),
                        icon: Icons.home,
                        tap: (){
                          Navigator.pop(context);
                        },

                      ),
                      TileDrawer(
                        name: AppLocalization.of(context).translate("profile"),
                        icon: Icons.person,
                        tap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen(

                          )));
                        } ,
                      ),
                      TileDrawer(
                        name: AppLocalization.of(context).translate("orders"),
                        icon: Icons.assignment,
                        tap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderScreen()));
                        },
                      ),
                      TileDrawer(
                        name: AppLocalization.of(context).translate("call"),
                        icon: Icons.email,
                        tap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUsScreen()));
                        },
                      ),
                      TileDrawer(
                        name: AppLocalization.of(context).translate("faq"),
                        icon: Icons.question_answer,
                        tap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQScreen()));
                        },
                      ),
                      TileDrawer(
                        name: _lang,
                        icon: Icons.language,
                        tap: () {
                          if(_lang=='English'){
                            model.change(0);
                            UtilSharedPreferences.setInt('lang', 0);
                            _lang='العربية';
                          }
                          else{
                            model.change(1);
                            UtilSharedPreferences.setInt('lang', 1);
                            _lang='English';
                          }

                        }
                      ),
                      TileDrawer(
                        name:AppLocalization.of(context).translate("share_app") ,
                        icon: Icons.share,
                      ),
                      TileDrawer(
                        name: AppLocalization.of(context).translate("logout"),
                        icon: Icons.logout,
                        tap: (){
                          Helper.showAlertDialog(context, AppLocalization.of(context).translate('sure_log_out'), AppLocalization.of(context).translate("logout"),(){
                            pr = CustomProgressDialog(
                                context,
                                AppLocalization.of(context).translate("logout..") ,
                                    () {});
                            _logOut();
                          });

                        },
                      ),

                      Divider(),
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('assets/images/instagram.svg'),
                            SvgPicture.asset('assets/images/youtube.svg'),
                            SvgPicture.string(
                              '<svg viewBox="0.0 0.0 25.9 25.9" ><path transform="translate(-10.0, -10.0)" d="M 22.93228149414063 35.86456298828125 C 15.79049301147461 35.86456298828125 10 30.07407188415527 10 22.93228149414063 C 10 15.79049301147461 15.79049301147461 10 22.93228149414063 10 C 30.07407188415527 10 35.86456298828125 15.79049301147461 35.86456298828125 22.93228149414063 C 35.86456298828125 30.07407188415527 30.07407188415527 35.86456298828125 22.93228149414063 35.86456298828125 Z M 33.74789047241211 27.01518821716309 L 30.52273750305176 27.01518821716309 C 29.50399208068848 30.27201271057129 27.19729232788086 32.94292831420898 24.20175552368164 34.41825485229492 C 28.59345436096191 33.93791580200195 32.23825073242188 31.00835990905762 33.74789047241211 27.01518821716309 Z M 29.7388858795166 23.27274513244629 C 29.7388858795166 22.23816299438477 29.59900856018066 21.20885467529297 29.35091209411621 20.20858383178711 L 23.61320495605469 20.20858383178711 L 23.61320495605469 25.65333938598633 L 29.49079322814941 25.65333938598633 C 29.6491527557373 24.88531875610352 29.7388858795166 24.09090995788574 29.7388858795166 23.27274513244629 Z M 22.25135612487793 27.01518821716309 L 16.87786102294922 27.01518821716309 C 17.87285614013672 29.64123344421387 19.81269454956055 32.10628509521484 22.26719284057617 33.41798782348633 L 22.25135612487793 27.01518821716309 Z M 22.25135612487793 25.65597724914551 L 22.25135612487793 20.20858383178711 L 16.43446922302246 20.20858383178711 C 16.23388481140137 21.10064697265625 16.12567520141602 22.01382446289063 16.12567520141602 22.93228149414063 C 16.12567520141602 23.87185096740723 16.23916435241699 24.78238868713379 16.45030403137207 25.65597724914551 L 22.25135612487793 25.65597724914551 Z M 22.25135612487793 18.84937477111816 L 22.25135612487793 12.26446533203125 C 19.75463104248047 13.67910003662109 17.80951499938965 15.99371528625488 16.82771492004395 18.84673500061035 L 22.25135612487793 18.84673500061035 Z M 28.93655586242676 18.84937477111816 C 27.92572593688965 16.080810546875 26.02547264099121 13.67910003662109 23.61320495605469 12.29613876342773 L 23.61320495605469 18.84937477111816 L 28.93655586242676 18.84937477111816 Z M 23.61320495605469 27.01518821716309 L 23.61320495605469 33.5921745300293 C 26.1891040802002 32.19866180419922 28.18173408508301 29.85236930847168 29.12922096252441 27.01518821716309 L 23.61320495605469 27.01518821716309 Z M 22.25135612487793 34.47632217407227 L 22.25135612487793 34.2255973815918 L 22.25135612487793 34.47632217407227 C 19.09745979309082 33.14350891113281 16.6165771484375 30.2614574432373 15.46586799621582 27.01518821716309 L 12.11666870117188 27.01518821716309 C 13.69229698181152 31.18519020080566 17.59837341308594 34.20448303222656 22.25135612487793 34.47632217407227 Z M 11.70758819580078 20.16635513305664 C 11.48061370849609 21.0689754486084 11.35920906066895 21.95839881896973 11.35920906066895 22.93228149414063 C 11.35920906066895 23.87185096740723 11.48325347900391 24.77974891662598 11.69439125061035 25.65597724914551 L 15.07526016235352 25.65597724914551 C 14.87467575073242 24.77974891662598 14.76118659973145 23.87185096740723 14.76118659973145 22.93228149414063 C 14.76118659973145 22.01382446289063 14.87203788757324 21.10328483581543 15.06469917297363 20.20858383178711 L 12.04277038574219 20.20858383178711 C 11.92400550842285 20.20858383178711 11.80523872375488 20.22177886962891 11.70758819580078 20.16635513305664 Z M 12.11666870117188 18.84937477111816 L 15.42627906799316 18.84937477111816 C 16.44238662719727 15.74298477172852 18.88104438781738 12.96914482116699 21.60737800598145 11.41463279724121 C 17.38459587097168 12.01638031005859 13.58144760131836 14.96969032287598 12.11666870117188 18.84937477111816 Z M 24.13049507141113 11.43838500976563 C 26.98615646362305 12.91371917724609 29.22423362731934 15.66116905212402 30.33271217346191 18.84937477111816 L 33.74789047241211 18.84937477111816 C 32.23033142089844 14.83509063720703 28.55386543273926 11.89497375488281 24.13049507141113 11.43838500976563 Z M 30.73651695251465 20.20858383178711 C 30.97404670715332 21.20885467529297 31.10073280334473 22.23551940917969 31.10073280334473 23.27274513244629 C 31.10073280334473 24.08826446533203 31.01363945007324 24.88267707824707 30.86584281921387 25.65597724914551 L 34.16753005981445 25.65597724914551 C 34.37866973876953 24.78238868713379 34.50271224975586 23.87448883056641 34.50271224975586 22.93227577209473 C 34.50271224975586 21.99271011352539 34.37866973876953 21.08481216430664 34.16753005981445 20.20858001708984 L 30.73651695251465 20.20858001708984 Z" fill="#0068b0" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                body: _isLoading?Center(child: CupertinoActivityIndicator()):SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SliderWidget(
                        sliders: _images,
                        change: _change,
                      ),
                      SizedBox(
                        height: 3.16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: map<Widget>(_images, _handler),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      RestaurantsList(
                        list:_resturant,
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
      ),
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

  void _getHomeProduct() async{
    setState(() {
      _isLoading=true;
    });
    await ScopedModel.of<RestaurantsApiModel>(context).listHome().then((value) {
      if(value.status.status){
        setState(() {
          _specSlider.addAll(value.data.spes_slider);
          _images.addAll(value.data.slider);
          _resturant.addAll(value.data.Vendor);
          if(value.data.ads!=null)
          _ads.addAll(value.data.ads);
          _isLoading=false;
        });
      }
    });
  }

  void _logOut() async{
    pr.showDialog();
    await ScopedModel.of<RestaurantsApiModel>(context).logout().whenComplete(() => pr.hideDialog()).then((value){
      UtilSharedPreferences.clear();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false);
    });
  }
}

