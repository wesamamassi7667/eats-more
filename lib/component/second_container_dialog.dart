
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/screens/track_order_screen.dart';
import 'package:flutter/material.dart';

import '../color.dart';
import 'elevated_button_component.dart';
import 'order_dialog.dart';
class SecondContainerDialog extends StatelessWidget {
  final int orderId;
  const SecondContainerDialog({
        Key key, this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 32),

                child: Icon(
                  Icons.check_circle_rounded,
                  size: 60,
                  color: black3,
                ),
              ),
              SizedBox(height: 15),
              Text(
                AppLocalization.of(context).translate("sent_successfully"),
                style: TextStyle(
                  fontFamily: 'DIN Next LT Arabic',
                  fontSize: 18,
                  color:black1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15,),
              DateOrder(
                  text1:AppLocalization.of(context).translate("order_number"),
                  text2:orderId.toString()
              ),
              DateOrder(
                  text1:AppLocalization.of(context).translate("order_date"),
                  text2:"DD- MM - YYYY"
              ),
              SizedBox(height: 25,),
              Container(
                width: double.infinity,
                margin: EdgeInsetsDirectional.only(start: 60,end: 60),
                child: ElevatedButtonComponent(
                  title: AppLocalization.of(context).translate("track_your_order"),
                  tap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TrackOrderScreen(
                      id:orderId,
                      isOrder:true,
                    )
                    )
                    );

                  },
                ),
              )
            ],


    );
  }
}
