
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class CounterWidget extends StatelessWidget {
  const CounterWidget({Key key, this.press, this.pressMines, this.quantity, this.loading, this.selectedIndex, this.index, this.mines}) : super(key: key);
  final Function press,pressMines;
  final int quantity;
  final bool loading;
  final int selectedIndex;
  final int index;
  final bool mines;
  @override
  Widget build(BuildContext context) {

    return  Container(
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: Color(0xffD8D8D8), width: 1)),
      child: Row(
        children: [
          Container(
              width: 30,
              child: IconButton(
                icon: loading&&selectedIndex==index?CupertinoActivityIndicator():SvgPicture.asset(
                  'assets/images/plus.svg',
                  color: black,
                ),
                onPressed:  press,
                alignment: Alignment.center,
              )),
          Text(
            '$quantity',
            style: TextStyle(fontWeight:FontWeight.w400, fontSize:14,
                color:black, fontFamily:'Poppins')

          ),
          Container(
            width: 30,
            child: IconButton(
              icon: mines&&selectedIndex==index?CupertinoActivityIndicator(): SvgPicture.asset('assets/images/mines.svg'),
              onPressed:pressMines,
            ),
          ),
        ],
      ),
    );
  }
}