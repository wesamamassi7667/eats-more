import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/dot.dart';
import 'package:eat_more_app/component/outline_button.dart';
import 'package:eat_more_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelComeScreen extends StatefulWidget {
  @override
  _WelComeScreenState createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> {
  int _currentIndex = 0;
  double _height=40.0;
  var _image='assets/images/welcome.png';
  double _height2=19.0;
  double _height3=78.0;
  var _title="اختر مطعمك";
  var _subTitle="مطاعمك المفضلة في مكان واحد";
  var _width=0.0;
 @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
   _width=MediaQuery.of(context).size.width*0.685;

   super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WelcomeComponent(
              image: _image,
              title: _title,
              subTitle: _subTitle,
              height:_height,
              height2: _height2,
              height3:_height3,
              width: _width,

            ),
            OutLineButton(
              tap: (){
                if (_currentIndex == 0)
                  setState(() {
                    _currentIndex = 1;
                    _height=10;
                    _image='assets/images/welcome1.png';
                    _height2=28.0;
                    _height3=64;
                    _title='اختر وجبتك';
                    _subTitle='طلبl الأكل صار أسهل';
                    _width=MediaQuery.of(context).size.width*0.704;

                  });
                else
                  setState(() {
                    _currentIndex = 2;
                    _height=54;
                    _image='assets/images/welcome2.png';
                    _height2=10;
                    _height3=96;
                    _title='توصيل اونلاين';
                    _subTitle='دقائق والاكل بكون بين أيديك';
                    _width=MediaQuery.of(context).size.width*0.76;
                  });
              },
              // child: Text('التالي',
              //     style: TextStyle(
              //       fontFamily: 'DIN Next LT Arabic',
              //       fontSize: 18,
              //       color: primaryIconColor,
              //     )),
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            SizedBox(height: 13.8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginScreen()));
                  },
                  child: Text(
                    'تخطي',
                    style: TextStyle(
                      fontFamily: 'DIN Next LT Arabic',
                      fontSize: 15,
                      color: grey2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 57),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(3, _handler),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_currentIndex == 2)
                      setState(() {
                        _currentIndex = 1;
                        _height=10;
                        _image='assets/images/welcome1.png';
                        _height2=28.0;
                        _height3=64;
                        _title='اختر وجبتك';
                        _subTitle='طلب الأكل صار أسهل';
                        _width=MediaQuery.of(context).size.width*0.704;
                      });
                    else
                      setState(() {
                        _currentIndex = 0;

                        _height=40;
                        _image='assets/images/welcome.png';
                        _height2=19.0;
                        _height3=78;
                         _title="اختر مطعمك";
                         _subTitle="مطاعمك المفضلة في مكان واحد";
                        _width=MediaQuery.of(context).size.width*0.685;
                      });
                  },
                  child: Text(
                    'السابق',
                    style: TextStyle(
                      fontFamily: 'DIN Next LT Arabic',
                      fontSize: 15,
                      color: grey2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }

  List<T> map<T>(int length, Function handler) {
    List<T> result = [];
    for (var i = 0; i < 3; i++) {
      result.add(handler(i));
    }
    return result;
  }

  _handler(index) {
    return _currentIndex == index ? ActiveDot() : UnActiveDot();
  }


}

class WelcomeComponent extends StatelessWidget {
  const WelcomeComponent({
    Key key,
    this.image,
    this.height2,
    this.title,
    this.subTitle,
    this.height3,
    this.handler, this.height, this.width,
  }) : super(key: key);
  final String image;
  final String title;
  final String subTitle;
  final Function handler;
  final double height;
  final double height2;
  final double height3;
  final double width;
  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image,width: width,),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: height,
            child: SizedBox(

            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 28,
              color: black3,
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: height2,
            child: SizedBox(

            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 14,
              color: grey3,
            ),
          ),
         AnimatedContainer(
           duration: Duration(milliseconds: 300),

           height: height3,
           child: SizedBox(

           ),
         )
        ],

    );
  }
}
