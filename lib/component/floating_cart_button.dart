import 'package:flutter/material.dart';

import '../color.dart';
class FloatingButton extends StatelessWidget {

  const FloatingButton({Key key, this.text, this.press}) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        height: 80,
        width: 70,
        child: FloatingActionButton(
          tooltip: 'cart',
          elevation: 4,
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Icon(Icons.shopping_cart,size: 35,),
              Container(

                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: red
                ),
                child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text('$text',style: TextStyle(fontSize: 8),)),
              )
            ],
          ),
          onPressed: press,
        ),
      ),

    );
  }


}
