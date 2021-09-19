import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/yes_no_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_text_field.dart';

class SchedulingOrderSheet extends StatefulWidget {
  final String start;
  final String end;

  const SchedulingOrderSheet({Key key, this.start, this.end}) : super(key: key);
  @override
  _SchedulingOrderSheetState createState() => _SchedulingOrderSheetState();
}

class _SchedulingOrderSheetState extends State<SchedulingOrderSheet> {
  var _showSecond = false;
  var one;
  var dateOpen;
  var dateClose;
  var two;
  var format;
  String _selectedTime = ' ';
  List<String> _times;
  int _selectedTimeIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    _times = [];
    super.initState();
    var now = DateTime.now();
    var nextDay = DateTime.now().add(Duration(days: 1));
    print(DateTime.now().add(Duration(days: 1)));
    format = DateFormat("HH:mm");
    one = format.parse(widget.start);
    two = format.parse(widget.end);
    dateOpen = DateTime(now.year, now.month, now.day, one.hour, one.minute);
    dateClose = DateTime(
        nextDay.year, nextDay.month, nextDay.day, two.hour, two.minute);
    print(dateOpen);
    print(dateClose);
    print(dateClose.difference(dateOpen).inHours);
    for (int i = 0; i <= dateClose.difference(dateOpen).inHours; i++) {
      _times.add(
          dateOpen.add(Duration(hours: i)).toString().replaceAll('.000', ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      child: AnimatedCrossFade(
        crossFadeState:
            _showSecond ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 400),
        firstChild: WillPopScope(
          onWillPop: (){
          _pop();

         },
          child: Container(
            height: 235,
            padding: EdgeInsetsDirectional.only(top: 30, bottom: 40),
            child: Column(
              children: [
                Text(
                  'المطعم مغلق حاليا',
                  style: TextStyle(
                    fontFamily: 'DIN Next LT Arabic',
                    fontSize: 24,
                    color: black1,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'هل ترغب بجدوله طلبك لاحقا',
                  style: TextStyle(
                    fontFamily: 'DIN Next LT Arabic',
                    fontSize: 19,
                    color: black5,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                YesNoButtons(
                  tap: () {
                    setState(() {
                      _showSecond = true;
                    });
                  },
                  pressNo: (){
                  _pop();
                  },
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ],
            ),
          ),
        ),
        secondChild: Container(
          height: 250,
          padding: EdgeInsets.only(top: 27),
          child: Column(
            children: [
              Text(
                'جدوله الطلب',
                style: TextStyle(
                  fontFamily: 'DIN Next LT Arabic',
                  fontSize: 24,
                  color: black1,
                ),
              ),
           _selectedTime.trim().isEmpty?SizedBox.shrink(): Padding(
                padding: const EdgeInsetsDirectional.only(start: 16,end: 16,top: 17),
                child: Row(
                  children: [
                    Text(
                      'سيتم جدوله طلبك لتاريخ ',
                      style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 19,
                        color: black5,
                      ),
                    ),
                   Spacer(),
                    Text(
                      '$_selectedTime',
                      style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 19,
                        color: black5,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16,end: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
                          builder: (context){
                            return GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                setState(() {
                                  _selectedTime=_times[_selectedTimeIndex];
                                });
                              },
                              child: Container(
                                height: 120,
                                color: background,
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                      initialItem: _selectedTimeIndex),
                                  backgroundColor: Colors.white,
                                  itemExtent: 30,
                                  squeeze: 1,
                                  children: List.generate(_times.length, (index) {
                                    return Text(_times[index],
                                      style: TextStyle(
                                        fontSize: 15,),
                                    );
                                  }),
                                  onSelectedItemChanged: (index) {
                                    setState(() {
                                      _selectedTime=_times[index];
                                      _selectedTimeIndex = index;
                                    });
                                  },
                                ),
                              ),
                            );
                          }
                        );},
                      child: Container(
                        height: 34,
                        width: MediaQuery.of(context).size.width * 0.448,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: grey9.withOpacity(0.31),
                        ),
                        child: APPTextField(
                          hintText: 'اختر الوقت',
                          isEnabled: false,
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                          ) ,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      // height: 33,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context,[_selectedTime]);

                        },
                        child: Text(
                          'ارسال',
                          style: TextStyle(
                            fontFamily: 'DIN Next LT Arabic',
                            fontSize: 16,
                            color: background,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: primaryIconColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pop() {
    var _count=0;
    Navigator.popUntil(context,
            (Route<dynamic> route) => _count++==2);
  }
}
