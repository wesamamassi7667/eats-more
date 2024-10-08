
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/app_bar.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/app_text_field.dart';
import 'package:eat_more_app/component/common/common.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/component/pick_date_widget.dart';
import 'package:eat_more_app/component/profile_photo_avatar.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/login_response.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scoped_model/scoped_model.dart';

class EditProfileScreen extends StatefulWidget {
  final String title;

  const EditProfileScreen({Key key, this.title}) : super(key: key);
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
  bool _isMale = true;
  bool _iSFemale = false;
  var _isEnable=false;
  List<PlatformFile> _paths=[];
  String _filePath;
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryIconColor,
      appBar: AppBarWidget(
        title: widget.title,
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
                      child: MyProgressIndicator(),
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
                                          ProfileAvatar(filePath:_filePath),
                                      !_isEnable?SizedBox.shrink(): TextButton(
                                            style: AppThemeData.textButtonStyle(backgroundColor: Colors.transparent,primary: black4),
                                            onPressed: ()=>_pickProfileImage(),
                                            child: Text(
                                              AppLocalization.of(context).translate("choose_image_profile"),
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
    setState(() =>_isLoading = true);
    ProfileResponse response= await ScopedModel.of<RestaurantsApiModel>(context)
        .getProfileInfo("auth/info", {});
      if (response.status.status) {
        _initializeUserInformation(response);
      }
      setState(() =>_isLoading = false);
  }

  void _updateProfile() async {
    Common.showSingleAnimationDialog(context);
   ProfileResponse response= await ScopedModel.of<RestaurantsApiModel>(context)
        .updateProfileInfo(
            _filePath,
            _displayNameController.text.trim(),
            _familyNameController.text.trim(),
            _isMale && !_iSFemale ? 'male' : 'female',
            _emailController.text.trim(),
            _birthdayController.text.trim());
      Navigator.pop(context);
      if (!response.status.status)
        AppDialog.showMe(context, response.status.HTTP_response);
      else {
        user=response.data;
        ScopedModel.of<RestaurantsApiModel>(context).changeUser(user);
        UtilSharedPreferences.setObj('user',user );
        setState(() => _isEnable=false);
        AppDialog.showMe(context, response.status.HTTP_response, isError: false);
      }

  }

  _pickProfileImage() async{
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
    setState(() {
    if(_paths.isNotEmpty){
    _filePath = _paths != null
    ? _paths.map((e) => e.path).toString()
        : '...';
    _filePath = _filePath.substring(
    1, _filePath.length - 1);}
    });
  }

  void _initializeUserInformation(ProfileResponse response) {
    user=response.data;
    ScopedModel.of<RestaurantsApiModel>(context).changeUser(user);
    _mobileController.text = user.phone??"";
    _displayNameController.text = user.fname??"";
    _familyNameController.text = user.last_name??"";
    _emailController.text = user.email??"";
    _birthdayController.text=user.birthday?.replaceAll("00:00:00", '')??"";
    UtilSharedPreferences.setObj('user',user );
    if (user.gender == 'male')
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
}
