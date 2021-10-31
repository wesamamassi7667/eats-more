
import 'package:eat_more_app/component/container_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class CountCartWidget extends StatelessWidget {
  final  Function pressMines,pressPlus;
  final int quantity;
  final bool isCart;

  const CountCartWidget({Key key, this.pressMines, this.pressPlus, this.quantity, this.isCart=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

          Container(
            width: isCart?30:null,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: pressPlus,
              child: Icon(
                Icons.add_box_rounded,
                size:isCart?15: 20,
                color: primaryIconColor,
              ),
            ),
          ),

        Text(
          '$quantity',
          style: TextStyle(
            fontSize: isCart?15:23,
            fontWeight: FontWeight.w500,
          ),

        ),
        Container(
          width: isCart?30:null,
          child: CupertinoButton(
                 padding:EdgeInsets.zero,
                onPressed: pressMines ,
                child: Icon(
                  Icons.indeterminate_check_box_rounded,
                  size:isCart? 15:20,
                  color: primaryIconColor,
                ),
              ),
        ),


      ],
    );
  }
}
