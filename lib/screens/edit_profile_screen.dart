import 'dart:io';

import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/app_bar.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/app_text_field.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/pick_date_widget.dart';
import 'package:eat_more_app/component/profile_photo_avatar.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scoped_model/scoped_model.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _familyNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  var _isLoading1 = false;
  bool _isMale = true;
  bool _iSFemale = false;
  var _isEnable=false;
  List<PlatformFile> _paths=[];
  String _filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryIconColor,
      appBar: AppBarWidget(
        title: AppLocalization.of(context).translate("profile"),
        isProfile:true,
        press: (){
          setState(() {
            _isEnable=true;
          });
        },
      ),
      body: Stack (
        children: [
          PositionedDirectional(
            start: 0,
            end: 0,
            bottom: 0,
            top: 10,
            child: _isLoading
                ?  ContainerComponent(
                      child: Center(
                      child: CupertinoActivityIndicator(),
                    )
            )
                :ContainerComponent(
                          child: SingleChildScrollView (
                            child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 23, end: 23, top: 41.9),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                        children: [
                                          _filePath != null
                                              ? ClipOval(
                                                  child: Image.file(
                                                    File(_filePath),
                                                    fit: BoxFit.cover,
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                )
                                              : ProfileAvatar(),
                                      !_isEnable?SizedBox.shrink(): TextButton(
                                            onPressed: () async {
                                              FocusScope.of(context).unfocus();
                                              try {
                                                _paths = (await FilePicker.platform.pickFiles(
                                                  type: FileType.image,
                                                  allowMultiple: false,
                                                  allowCompression: true,
                                                ))
                                                    .files;
                                              } catch (ex) {
                                                print(ex);
                                              }
                                              print(_paths);
                                              setState(() {
                                                if(_paths.isNotEmpty){
                                                _filePath = _paths != null
                                                    ? _paths.map((e) => e.path).toString()
                                                    : '...';
                                                _filePath = _filePath.substring(
                                                    1, _filePath.length - 1);}
                                                print(_filePath);
                                              });
                                            },
                                            child: Text(
                                              AppLocalization.of(context)
                                                  .translate("choose_image_profile"),
                                              style:
                                                  TextStyle(fontFamily: 'DIN Next LT Arabic'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          APPTextField(
                                            hintText: AppLocalization.of(context)
                                                .translate("first_name"),
                                            textEditingController: _displayNameController,
                                            textType: TextInputType.name,
                                            errMessage: AppLocalization.of(context).translate('first_name_required'),
                                            prifexIcon: Icon(CupertinoIcons.person),
                                            isEnabled: _isEnable,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          APPTextField(
                                            hintText: AppLocalization.of(context)
                                                .translate("family_name"),
                                            textEditingController: _familyNameController,
                                            textType: TextInputType.name,
                                            prifexIcon: Icon(CupertinoIcons.person_3),
                                            isEnabled: _isEnable,
                                            errMessage: AppLocalization.of(context).translate('last_name_required'),

                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          APPTextField(
                                            hintText: AppLocalization.of(context)
                                                .translate("email"),
                                            textEditingController: _emailController,
                                            textType: TextInputType.emailAddress,
                                            prifexIcon: Icon(CupertinoIcons.mail),
                                            isEnabled: _isEnable,
                                            errMessage: AppLocalization.of(context).translate('email_required'),

                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                            onTap:!_isEnable?null: () async{
                                              FocusScope.of(context).unfocus();

                                              String date = await showModalBottomSheet(
                                                context: context,
                                                builder: (context) => PickDateWidget(
                                                  maximumDate: DateTime.now(),
                                                ),
                                              );
                                              setState(() {
                                                _birthdayController.text=date;
                                              });
                                            },
                                            child: APPTextField(
                                              hintText: AppLocalization.of(context)
                                                  .translate("birthday"),
                                              textEditingController: _birthdayController,
                                              textType: TextInputType.visiblePassword,
                                              prifexIcon: Icon(CupertinoIcons.calendar),
                                              isEnabled: false,
                                              errMessage:  AppLocalization.of(context).translate('birthday_required'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                         APPTextField(
                                              hintText: AppLocalization.of(context)
                                                  .translate("mobile_number"),
                                              textEditingController: _mobileController,
                                              textType: TextInputType.phone,
                                              prifexIcon: Icon(CupertinoIcons.phone),
                                           isEnabled: _isEnable,
                                           errMessage: AppLocalization.of(context).translate('mobile_number_required'),

                                         ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/images/gender.svg'),
                                                  SizedBox(
                                                    width: 8.5,
                                                  ),
                                                  Text(
                                                    AppLocalization.of(context)
                                                        .translate("gender"),
                                                    style: TextStyle(
                                                      fontFamily: 'DIN Next LT Arabic',
                                                      fontSize: 17,
                                                      color: black1,
                                                      fontWeight: FontWeight.w300,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              Flexible(
                                                flex: 2,
                                                child: _buildListTileTheme(
                                                    AppLocalization.of(context)
                                                        .translate("male"),
                                                    _isMale, !_isEnable?null:(v) {
                                                  setState(() {
                                                    _isMale = true;
                                                    _iSFemale = false;
                                                  });
                                                }),
                                              ),
                                              Flexible(
                                                flex: 2,
                                                child: _buildListTileTheme(
                                                    AppLocalization.of(context)
                                                        .translate("female"),
                                                    _iSFemale, !_isEnable?null:(v) {
                                                  setState(() {
                                                    _isMale = false;
                                                    _iSFemale = true;
                                                  });
                                                }),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                       !_isEnable?  SizedBox.shrink() :Container(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              child:_isLoading?CupertinoActivityIndicator():Text(AppLocalization.of(context)
                                                  .translate("save")),
                                              onPressed: () {
                                                FocusScope.of(context).unfocus();
                                                if (_formKey.currentState.validate()) {
                                                  _formKey.currentState.save();
                                                  if(!_isMale&&!_iSFemale){
                                                    AppDialog.showMe(context, AppLocalization.of(context).translate('gender_required'));
                                                    return;
                                                  }
                                                _updateProfile();}
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                  ),
                                  ),
                          ),
                            ),
                ),
          
        ],
      ),
    );
  }

  ListTileTheme _buildListTileTheme(
      String title, bool value, ValueChanged<bool> onChange) {
    return ListTileTheme(
        contentPadding: EdgeInsets.all(0),
        child: CheckboxListTile(
          value: value,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: onChange,
          title: Transform(
            transform: Matrix4.translationValues(-16, 0.0, 0.0),
            child: Text(
              title,
              maxLines: 1,
              // textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: 'DIN Next LT Arabic',
                fontSize: 14,
                color: black1,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getProfileInfo();
  }

  void _getProfileInfo() async {
    setState(() {
      _isLoading = true;
    });

    await ScopedModel.of<RestaurantsApiModel>(context)
        .getProfileInfo("auth/info", {}).then((value) {
      if (value.status.status) {
        ScopedModel.of<RestaurantsApiModel>(context).changeUser(value.data);
        if (value.data.phone != null) _mobileController.text = value.data.phone;
        if (value.data.fname != null)
          _displayNameController.text = value.data.fname;
        if (value.data.lname != null) if (value.data.lname != null)
          _familyNameController.text = value.data.last_name;
        if (value.data.email != null) if (value.data.email != null)
          _emailController.text = value.data.email;
        if (value.data.gender == 'male')
          setState(() {
            _isMale = true;
            _iSFemale = false;
          });
        else
          setState(() {
            _isMale = false;
            _iSFemale = true;
          });
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _updateProfile() async {
    // if(_filePath==null){
    //   AppDialog.showMe(context, 'ddddd');
    //   return;
    // }
    setState(() {
      _isLoading1 = true;
    });
    await ScopedModel.of<RestaurantsApiModel>(context)
        .updateProfileInfo(
            _filePath,
            _displayNameController.text.trim(),
            _familyNameController.text.trim(),
            _isMale && !_iSFemale ? 'male' : 'female',
            _emailController.text.trim(),
            '')
        .then((value) {
      if (!value.status.status)
        AppDialog.showMe(context, value.status.HTTP_response);
      else {
        ScopedModel.of<RestaurantsApiModel>(context).changeUser(value.data);
        UtilSharedPreferences.setObj('user', value.data);
        setState(() {
          _isEnable=false;
        });
        AppDialog.showMe(context, value.status.HTTP_response, isError: false);
      }
      setState(() {
        _isLoading1 = false;
      });
    });
  }
}
