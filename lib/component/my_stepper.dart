
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/model/order_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MyStepper extends StatelessWidget {
  // final double width;
  final List<dynamic> icons;
  final List<String> titles;
  final int curStep;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeColorLine;
  final Color inactiveBorderColor;
  final Color inactiveColorLine;
  final double lineWidth;
  final List<String> status;
  final List<StatusOrder> statusOrder;


  const MyStepper({Key key, @required this.icons,
    this.titles, this.curStep, this.activeColor, this.inactiveColor, this.lineWidth=1.0, this.activeColorLine, this.inactiveColorLine, this.inactiveBorderColor, this.status, this.statusOrder,
  }) : assert(curStep > 0 == true && curStep <= icons.length+1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
           children: _IconView()
        ),
        SizedBox(width: 20,),
         Padding(
           padding: const EdgeInsets.only(top: 15),
           child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: _textView(),
            ),
         ),

      ],
    );
  }


  List<Widget> _textView(){
    var list = <Widget>[];
    status.asMap().forEach((i, value) {
      if (i != status.length - 1)
      list.add(
        Container(
          height: 110,
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status[i],
                    style: TextStyle(
                      fontFamily: 'DIN Next LT Arabic'
                    ),
                  ),

                  statusOrder!=null&&statusOrder.length>i?Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      statusOrder[i].status_time
                    ),
                  ):SizedBox.shrink()
                ],
              ),
        )
      );
      if(i==status.length - 1)
        list.add(
          Text(
            status[i],
            style: TextStyle(
                fontFamily: 'DIN Next LT Arabic'
            ),
          ),
        );

    });


    return list;
  }
  List<Widget> _IconView() {
    var list = <Widget>[];
    icons.asMap().forEach((i, icon) {

      //colors according to state
      var circleColor = (i == 0 || curStep >= i + 1)
          ? activeColor
          : inactiveColor;

      var lineColor = curStep >= i + 1
          ? activeColorLine
          : inactiveColorLine;


      list.add(

            Container(
              width: 60.0,
              height: 60.0,
              padding:EdgeInsets.all(7),
              child: i!=1?Icon(icon, color:_iconColor(i),size: 30.0,):Image.asset(icon,color: _iconColor(i),),
              decoration: new BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
                border: new Border.all(
                  color:_borderColor(i)??Colors.transparent,
                  width: 0.5,
                ),
              ),
            ),


      );

      //line between icons
      if (i != icons.length - 1) {
        list.add(
                   Container( color: lineColor,width: 1.5,height: 50,),

        );
      }
    });

    return list;
  }

  Color _iconColor(int i) {
    if(i==0||curStep>=i+1)
      return inactiveColor;
    else if(i==1||curStep>=i+2)
      return activeColor;
    return inactiveBorderColor;
  }

  Color _borderColor(int i) {
    if(i==0||curStep>=i+1)
      return null;
    else if(i==1||curStep>=i+2)
      return primaryIconColor;
    return inactiveBorderColor;
  }


}
