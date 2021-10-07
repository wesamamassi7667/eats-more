import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/header_component.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/screens/branch_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class DeliveryMethodsScreen extends StatefulWidget {
  final int id;

  const DeliveryMethodsScreen({Key key, this.id}) : super(key: key);
  @override
  _DeliveryMethodsScreenState createState() => _DeliveryMethodsScreenState();
}

class _DeliveryMethodsScreenState extends State<DeliveryMethodsScreen> {

  Position _currentPosition;
  var _isLoading=false;

  @override
  Widget build(BuildContext context) {
    return HeaderComponent(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top:0,bottom:20),
        child: Column(
          children: [
            Text(
              AppLocalization.of(context).translate("select_method_delivery"),
              style: TextStyle(
                fontFamily: 'DIN Next LT Arabic',
                fontSize: 18,
                color: background,
                fontWeight: FontWeight.w500,

              ),
            ),
            SizedBox(height:40 ,),
            Wrap(
              runSpacing: 16,
              spacing: 15,
              children: List.generate(2, (index){
                return InkWell(
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>BranchScreen(
                        id:widget.id,idWay:index
                    ) ));
                  },
                  child: Container(
                    width: 136,
                    height: 115,
                    padding: EdgeInsetsDirectional.only(top: 21,bottom: 20.8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      border: Border.all(width: 1.0, color: background),
                    ),
                    child: Column(
                      children: [
                      index==0&&_isLoading?CupertinoActivityIndicator(): Icon(
                          Icons.location_on,
                          color: background,
                          size: 30,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          index==0?  'عنوان خريطة':"من الفرع",
                          style: TextStyle(
                            fontFamily: 'DIN Next LT Arabic',
                            fontSize: 18,
                            color: background,
                            height: 1.4444444444444444,
                          ),

                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

}

