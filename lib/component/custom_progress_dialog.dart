
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomProgressDialog {
final BuildContext context;
ProgressDialog pr;
final String message;
final Function didHide;

CustomProgressDialog(this.context, this.message, this.didHide,      ) {
  pr = ProgressDialog(context, isDismissible: false,type:  ProgressDialogType.Normal);
  setupDialog();
}

void setupDialog() {
  pr.style(
    message: message,
    textAlign:UtilSharedPreferences.getInt("lang")!=0||ScopedModel.of<RestaurantsApiModel>(context).language==1? TextAlign.right:TextAlign.left,
    backgroundColor: Colors.white,
    progressTextStyle: TextStyle(fontWeight:FontWeight.w400,fontSize: 16,color: Colors.black,fontFamily:'DIN Next LT Arabic'),
    messageTextStyle: TextStyle(fontWeight:FontWeight.w400, fontSize:16,color:Colors.black,fontFamily: 'DIN Next LT Arabic' ),);
}

void showDialog() async {
  await pr.show();

}
void updateDialog(String message) async{
  await pr.update(message: message);
}
void hideDialog() async {
  await pr.hide();
}
}