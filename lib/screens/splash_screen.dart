import 'dart:async';


import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/setting_response.dart';
import 'package:eat_more_app/screens/home_screen.dart';
import 'package:eat_more_app/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  var _isLoading = false;
  Animation<double> _animation;
  AnimationController _controller;
  var _isLoading1=false;
  Image _image ;
  final Completer<void> completer = Completer<void>();

  @override
  initState() {
    // TODO: implement initState
    _controller=AnimationController(vsync: this,duration: Duration(seconds:1),lowerBound: 0.5,upperBound: 1)..repeat(reverse: true);
    _animation=CurvedAnimation(parent: _controller, curve:Curves.linear);
    super.initState();
    if (UtilSharedPreferences.getObj('constant') == null){
      _getConstant();

    }
    else{

      Helper.setting=Setting.fromJson(UtilSharedPreferences.getObj('constant'));
      setState(() {
        _image=new Image.network(
          Helper.setting.gif??"",
          fit: BoxFit.fill,
        );
      });
      _imageLoad();
    }
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
        body: _isLoading
            ?Center(child: CupertinoActivityIndicator(),):_isLoading1? Center(
                child:ScaleTransition(
                  scale: _animation,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: CachedNetworkImage(
                      imageUrl:Helper.setting.enterprise_image,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                      progressIndicatorBuilder: (context, url, downloadProgress) {
                     return   UtilSharedPreferences.getObj('constant') == null?  LimitedBox(maxHeight: 40,maxWidth: 40,child: CupertinoActivityIndicator()):SizedBox.shrink();},
                      errorWidget:
                          (BuildContext context, String url, Object error) {
                        print(error);
                        return const Icon(Icons.error);
                        },
                    ),
                  ),
                ) ,
              )
             :  Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _image.image,
                fit:  BoxFit.cover
              ),

            ),
        ),
    );
  }

  void _getConstant() async {
    setState(() {
      _isLoading = true;
    });
    await ScopedModel.of<RestaurantsApiModel>(context)
        .listConstants()
        .then((value) {
      if (value.status.status) {
        UtilSharedPreferences.setObj('constant', value.data);
        Helper.setting=Setting.fromJson(UtilSharedPreferences.getObj('constant'));
        setState(() {
          _image = new Image.network(
            value.data.gif,
            fit: BoxFit.cover,
          );
        });
        _imageLoad();
      }
      setState(() {
        _isLoading=false;
      });
        });
  }

  void _delay(second) {
    Future.delayed(Duration(seconds: second),(){
      if(UtilSharedPreferences.getString("token")==null)
        Navigator.of(context,rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen(

        )));
      else{
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>HomeScreen()));
        print('token'+UtilSharedPreferences.getString("token") );
        // print('constant'+UtilSharedPreferences.getObj("constant").toString() );
      }
    }
    );
  }

  void _imageLoad() async{
    setState(() {
      _isLoading1=true;
    });
    _image.image.resolve(ImageConfiguration.empty).addListener(
      ImageStreamListener(
              (ImageInfo info, bool syncCall) {
                if(!completer.isCompleted)
                completer.complete();}
      )
    );
    await completer.future;
    setState(() {
      _isLoading1=false;
    });
    _delay(5);
  }
}
