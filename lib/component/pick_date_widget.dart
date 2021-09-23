

import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PickDateWidget extends StatefulWidget {
  final DateTime maximumDate;

  PickDateWidget( {this.maximumDate});

  @override
  _PickDateWidgetState createState() => _PickDateWidgetState();
}

class _PickDateWidgetState extends State<PickDateWidget> {
  var date =
  new DateFormat("yyyy-MM-dd", "en").format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsetsDirectional.only(
        start: 16,
        end: 16,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            15,
          ),
          topLeft: Radius.circular(
            15,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image(
              image: AssetImage(
                "assets/images/close.png",
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Center(
            child: Text(
              AppLocalization.of(context).translate("date"),
              style: TextStyle(
                fontWeight:FontWeight.w700,
                fontSize:18,
                color:primaryIconColor,

              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              date,
              style: TextStyle(
                fontWeight:FontWeight.w400,
                fontSize:18,
               color:grey5,
              ),
              textAlign:TextAlign.center,
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Container(
            height: 150,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    fontWeight:FontWeight.w400,
                    fontSize:14,
                    color:grey4,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                onDateTimeChanged: (dateTime) {
                  setState(() {
                    date = new DateFormat("yyyy-MM-dd", "en")
                        .format(dateTime)
                        .toString();
                  });
                },
                mode: CupertinoDatePickerMode.date,
              ),
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Container(
            width: double.maxFinite,
            child: ElevatedButton(
              child:Text(AppLocalization.of(context).translate("continue")),
                  onPressed:()=> Navigator.of(context).pop(date),

            ),
          ),
        ],
      ),
    );
  }
}

