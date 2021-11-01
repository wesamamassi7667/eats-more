
import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/app_bar.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/app_text_field.dart';
import 'package:eat_more_app/component/contact_component.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/component/second_header_component.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/model/contact_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';
class ContactUsScreen extends StatefulWidget {
  final String title;

  const ContactUsScreen({Key key, this.title}) : super(key: key);
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  FocusNode _nameFocusNode = new FocusNode();
  TextEditingController _name = new TextEditingController();
  FocusNode _emailFocusNode = new FocusNode();
  TextEditingController _email = new TextEditingController();
  FocusNode _detailFocusNode = new FocusNode();
  TextEditingController _detail = new TextEditingController();
  FocusNode _titleFocusNode = new FocusNode();
  TextEditingController _title = new TextEditingController();
  var _isLoading = false;
  var _isLoading1=false;
  final _formKey = GlobalKey<FormState>();
  SocialMedia _socialMedia;
  @override
  void initState() {
    // TODO: implement initState
    //to open url add permission to manifest QUERY_ALL_PACKAGES
    super.initState();
    _getSocialMediaLinks();
  }
  @override
  Widget build(BuildContext context) {
    return SecondHeaderComponent(
      title: widget.title,
      child: _isLoading1?MyProgressIndicator():
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.center,
          children: [
            SizedBox(height: 37,),
            SvgPicture.asset('assets/images/contact.svg'),
            SizedBox(height: 23),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: SvgPicture.asset('assets/images/snapchat.svg'),
                  onPressed: () {
                    var url = _socialMedia.snapchat;
                    Helper.openApp(url);
                  },
                ),
                IconButton(
                    onPressed: () async {
                      var url = 'https://www.instagram.com/_u/taxi';
                      Helper.openApp(url);
                    },
                    icon: SvgPicture.asset('assets/images/instgram.svg')),
                IconButton(
                    onPressed: () async {
                      var url = _socialMedia.twitter;
                      Helper.openApp(url);
                    },
                    icon: SvgPicture.asset('assets/images/twitter.svg')),
                IconButton(
                    onPressed: () {
                      var url = _socialMedia.facebook;
                      Helper.openApp(url);
                    },
                    icon: SvgPicture.asset('assets/images/facebook.svg')),
                IconButton(
                    onPressed: () {
                      var url = _socialMedia.youtube;
                      Helper.openApp(url);
                    },
                    icon: SvgPicture.asset('assets/images/youtube1.svg')),
              ],
            ),
            SizedBox(height: 15,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(3, (index) {
                  return GestureDetector(

                      onTap: (){
                        var whatsappUrl =
                            "whatsapp://send?phone=${_socialMedia.whatsapp??""}";
                        var phoneUrl='tel://${_socialMedia.phone??""}';
                        print(phoneUrl);
                        Helper.openApp(index==0?whatsappUrl:phoneUrl);
                      },
                      child: ContactComponent(index: index,));
                })
            ),
            SizedBox(height: 25,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(53.0),
                  topRight: Radius.circular(53.0),
                ),
                color: background,
                boxShadow: [
                  BoxShadow(
                    color: black8.withOpacity(0.1),
                    offset: Offset(
                        -2.723942995071411, 5.346039295196533),
                    blurRadius: 50,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 17, start: 29),
                    child: Text(
                      AppLocalization.of(context).translate("fast_contact"),
                      style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 20,
                        color: const Color(0xff161515),
                      ),

                    ),
                  ),
                  SizedBox(height: 16,),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16),
                      child: Column(
                        children: [
                          APPTextField(
                            hintText: AppLocalization.of(context).translate("name"),
                            focusNode: _nameFocusNode,
                            nextFocus: _emailFocusNode,
                            textEditingController: _name,
                            textType: TextInputType.name,
                          ),
                          SizedBox(height: 14,),
                          APPTextField(
                            hintText: AppLocalization.of(context).translate("email"),
                            focusNode: _emailFocusNode,
                            nextFocus: _titleFocusNode,
                            textEditingController: _email,
                            textType: TextInputType.emailAddress,
                            errMessage: AppLocalization.of(context).translate("email_required"),
                          ),
                          SizedBox(height: 14,),
                          APPTextField(
                            hintText: AppLocalization.of(context).translate("title"),
                            focusNode: _titleFocusNode,
                            textEditingController: _title,
                            textType: TextInputType.text,
                            errMessage: AppLocalization.of(context).translate("title_required"),
                            nextFocus: _detailFocusNode,
                          ),
                          SizedBox(height: 14,),
                          APPTextField(
                            hintText: AppLocalization.of(context).translate("message"),
                            focusNode: _detailFocusNode,
                            textEditingController: _detail,
                            textType: TextInputType.multiline,
                            errMessage: AppLocalization.of(context).translate("message_required"),
                            isMultiLine: true,
                          ),
                          SizedBox(height: 24,),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: _isLoading?CupertinoActivityIndicator():Text(AppLocalization.of(context).translate("send")),
                              onPressed: () {
                                _contactUs();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )


                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  void _contactUs() async {
   try{
     FocusScope.of(context).unfocus();
     if (_formKey.currentState.validate()) {
       _formKey.currentState.save();
       var _body = {
         "msg_title": _title.text.trim(),
         "email": _email.text.trim(),
         "msg_details": _detail.text.trim()
       };
       setState(() => _isLoading = true);
       String response=await  AppApi.configureClient.contact(_body);
       setState(() =>_isLoading=false);
       AppDialog.showMe(context, response);
     }
   }
   catch(err){
     setState(() =>_isLoading=false);
     AppDialog.showMe(context,err.toString());
   }
  }

  void _getSocialMediaLinks() async {
    setState(() =>_isLoading1=true);
    final response=await AppApi.configureClient.getSocialMedia();
    _socialMedia=response;
    setState(() =>_isLoading1=false);

  }
}

