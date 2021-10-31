import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/app_bar.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/component/second_header_component.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/faq_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';

class FAQScreen extends StatefulWidget {
  final String title;

  const FAQScreen({Key key, this.title}) : super(key: key);
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  var _isLoading = false;
  List<Question> faqs;
  List<bool> _isExpanded;
  @override
  void initState() {
    // TODO: implement initState
    faqs = [];
    _isExpanded=[];
    super.initState();
    _getFAQs();
  }

  @override
  Widget build(BuildContext context) {
    return SecondHeaderComponent(
      title: widget.title,
      child:_isLoading?MyProgressIndicator(): Padding(
        padding: const EdgeInsetsDirectional.only(top:30.0, start: 16,end: 16),
        child: ListView.builder(
            itemCount: faqs.length,
            itemBuilder:(context,index){
              return  ExpansionPanelList(
                // key: UniqueKey(),
                elevation: 1,
                dividerColor: red,
                animationDuration: Duration(milliseconds: 1000),
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          faqs[index].ques,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: black5,),
                        ),
                      );

                    },
                    body:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(start: 10,end: 10,bottom: 10),
                            child: Text(
                              faqs[index].answer.trim(),
                              maxLines: 3 ,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: black,
                                  letterSpacing: 0.3,
                                  height: 1.3,
                                  fontFamily: 'DIN Next LT Arabic'),
                            ),
                          ),
                        ),
                      ],
                    ),

                    isExpanded: _isExpanded[index],
                  ),
                ],
                expansionCallback: (int item, bool status) {
                  setState(() {
                    _isExpanded[index]=!_isExpanded[index];
                  });
                },
              );
            }
        ),
      ),
    );
  }

  void _getFAQs() async {
    setState(() {
      _isLoading = true;
    });
    await ScopedModel.of<RestaurantsApiModel>(context).getFAQs().then((value) {
      if (value.status.status) {
        faqs.addAll(value.data.faq);
        for(int i=0;i<=faqs.length;i++){
          _isExpanded.add(false);
        }
      }
      setState(() {
        _isLoading = false;
      });
    });
  }
}
