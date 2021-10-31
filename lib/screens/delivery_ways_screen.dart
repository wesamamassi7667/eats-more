import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/api/clients/service_client.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/cached_network_image_component.dart';
import 'package:eat_more_app/component/header_component.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/service_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eat_more_app/api/clients/service_client.dart';
class DeliveryMethodsScreen extends StatefulWidget {
  final int id;

  const DeliveryMethodsScreen({Key key, this.id}) : super(key: key);
  @override
  _DeliveryMethodsScreenState createState() => _DeliveryMethodsScreenState();
}

class _DeliveryMethodsScreenState extends State<DeliveryMethodsScreen> {

  var _isLoading=false;
  List<Services> services;


  @override
  void initState() {
    // TODO: implement initState
    services=[];
    super.initState();
    _getServices();
  }
  @override
  Widget build(BuildContext context) {
    return HeaderComponent(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top:43,bottom:20),
        child: Column(
          children: [
            Text(
              AppLocalization.of(context).translate("select_method_delivery"),
              style: TextStyle(
                fontSize: 18,
                color: black4,
                fontWeight: FontWeight.w500,

              ),
            ),
            SizedBox(height:40 ,),
           _isLoading?MyProgressIndicator(): Wrap(
              runSpacing: 16,
              spacing: 15,
              children: List.generate(services.length, (index){
                Services s=services[index];
                return InkWell(
                  onTap: ()=> Navigator.pushNamed(context, '/branch',arguments: {"id":widget.id,"idWay":s.service}),
                  child: Container(
                    width: 136,
                    height: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      border: Border.all(width: 1.0, color: primaryIconColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImageComponent(url: s.image,),
                        Text(
                           '${s.name}',
                          style: TextStyle(
                            fontSize: 18,
                            color: black3,
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
  void _getServices() async{
    setState(() =>_isLoading=true);
   services=await AppApi.serviceClient.listService(widget.id);
   setState(() =>_isLoading=false);
  }
}

