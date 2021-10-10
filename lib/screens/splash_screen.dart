import 'dart:async';


import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/setting_response.dart';
import 'package:eat_more_app/screens/home_screen.dart';
import 'package:eat_more_app/screens/login_screen.dart';
import 'package:eat_more_app/screens/restuerant_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  Animation<double> _animation;
  AnimationController _controller;
  var _isLoading1=false;
  // Image _image ;
  final Completer<void> completer = Completer<void>();
  String gif;
  DecorationImage _image;

  @override
  initState() {
    // TODO: implement initState
    _controller=AnimationController(vsync: this,duration: Duration(seconds:1),lowerBound: 0.5,upperBound: 1)..repeat(reverse: true);
    _animation=CurvedAnimation(parent: _controller, curve:Curves.linear);
    super.initState();
     gif=UtilSharedPreferences.getString('gif');
    String newGif= UtilSharedPreferences.getString('newGif');
    if ( gif== null)
      _getConstant();
    else if(newGif!=null&&gif !=newGif ){
      setState(() => gif=newGif);
      // _imageLoad();
    }
    _delay(6);


  }

  DecorationImage decorationImage() {
    return DecorationImage(
        image: new Image.network(
          gif??"",
        ).image,
        fit: BoxFit.cover,
      );
  }
 @override
  void dispose() {
   _controller.dispose();

   // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        // backgroundColor: background,
        body: _isLoading1?Center(child: buildScaleTransition()):Container(

          child: CachedNetworkImage(
            imageUrl:gif,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return   Center(child: buildScaleTransition());},
            errorWidget:
                (BuildContext context, String url, Object error) {
              print(error);
              return const Icon(Icons.error);
            },
          ),
        ),
    );
  }

  ScaleTransition buildScaleTransition() {
    return ScaleTransition(
                scale: _animation,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                ),
              );
  }

  void _getConstant() async {
    setState(() => _isLoading1 = true);
    await ScopedModel.of<RestaurantsApiModel>(context)
        .listConstants()
        .then((value) {
      if (value.status.status) {
        UtilSharedPreferences.setString('gif', value.data.gif);
        gif=UtilSharedPreferences.getString('gif');
        Helper.constants=value.data;
        setState(() =>_image =decorationImage());
        // _imageLoad();
      }
      setState(()=>_isLoading1=false);});
  }

  void _delay(second) {
    Future.delayed(Duration(seconds: second),(){
      if(UtilSharedPreferences.getString("token")==null)
        Navigator.of(context,rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
      else{
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>RestaurantScreen(id: 18,idWay: 1,)));
        print('token'+UtilSharedPreferences.getString("token") );
      }
    }
    );
  }

  // void _imageLoad() async{
  //   setState(()=>_isLoading1=true);
  //   _image.image.resolve(ImageConfiguration.empty).addListener(
  //     ImageStreamListener(
  //             (ImageInfo info, bool syncCall) {
  //               if(!completer.isCompleted)
  //               completer.complete();}
  //     )
  //   );
  //   await completer.future;
  //   setState(() => _isLoading1=false);
  //   _delay(3);
  // }
}
