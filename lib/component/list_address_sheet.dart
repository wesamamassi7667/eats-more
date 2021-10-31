
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/address_response.dart';
import 'package:eat_more_app/screens/restuerant_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class ListAddressSheet extends StatefulWidget {
  final ScrollController controller;
  final bool loading;
  final Function press;
  final GoogleMapController mapController;

  const ListAddressSheet({Key key, this.controller, this.loading,this.press, this.mapController}) : super(key: key);
  @override
  _ListAddressSheetState createState() => _ListAddressSheetState();
}

class _ListAddressSheetState extends State<ListAddressSheet> {
  var _isLoading=false;
  var _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return  ScopedModelDescendant<RestaurantsApiModel>(
      builder:(context,child,model)=> ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: SingleChildScrollView(
          controller: widget.controller,
          child: Container(
            decoration: BoxDecoration(
              color: primaryIconColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            padding: EdgeInsetsDirectional.only(start: 16,end: 16,bottom: 16),
            child: Column(
              children: [
                Icon(
                  Icons.keyboard_arrow_up_sharp,
                  color: background,
                ),
                Material(
                  type: MaterialType.transparency,
                  child: Text(
                    AppLocalization.of(context).translate("my_addresses"),
                    style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 18,
                        color: background,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: background
                  ),
                  child:widget.loading?Center(child: CupertinoActivityIndicator(),):model.address==null||model.address.isEmpty?
                   Center(child: Material(
                       type: MaterialType.transparency,
                       child: Text(AppLocalization.of(context).translate('no_address'),style: TextStyle(
                         fontFamily: 'DIN Next LT Arabic',
                         fontSize: 18,
                         color: black4,
                           fontWeight: FontWeight.bold
                       ),),
                   ),)
                  :ListView.separated(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap:() async {
                            if(_selectedIndex==index)
                              return;
                            setState(() {
                              _selectedIndex=index;
                              model.clearMarks();
                              model.addToMarker(Marker(
                                draggable: false,
                                markerId: MarkerId('Marker'),
                                icon: BitmapDescriptor.defaultMarker,
                                position: LatLng(
                                  double.parse(model.address[_selectedIndex].lat),
                                  double.parse(model.address[_selectedIndex].long),
                                ),
                              ));
                            });
                           await  widget.mapController.animateCamera(CameraUpdate.newCameraPosition(
                                CameraPosition(
                                    target: LatLng(double.parse(model.address[_selectedIndex].lat),
                                      double.parse(model.address[_selectedIndex].long),
                                    ),
                                    zoom: 10.0))).then((value) {
                                      model.clearMarks();
                                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>RestaurantScreen()));
                            });
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 16),
                            child: Row(
                              children: [
                                Image.asset('assets/images/marker.png',width: 40,height: 40,),
                                SizedBox(width: 4,),
                                Container(
                                  width: MediaQuery.of(context).size.width-150,
                                  child: Material(
                                      type: MaterialType.transparency,
                                      //remove yellow line under text
                                      child: Text(model.address[index].address,
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontFamily: 'DIN Next LT Arabic',
                                            fontSize: 14,
                                            color: black4,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                ),
                                ButtonTheme(
                                  minWidth: 24,
                                  height: 24,
                                  child: OutlineButton(
                                      onPressed: (){
                                         setState(() {
                                           _selectedIndex=index;
                                         });
                                        _deleteAddress(model.address[_selectedIndex].id,_selectedIndex);
                                      },
                                      shape: CircleBorder(),
                                      borderSide:
                                      BorderSide(color: Colors.red, width: 0.5),
                                      child: _isLoading&&index==_selectedIndex?CupertinoActivityIndicator():Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 15,
                                      )),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context,index){
                        return Divider(
                          color: grey4.withOpacity(0.24),
                        );
                      }, itemCount:model.address.length),
                ),

              ],
            ),

          ),
        ),
      ),
    );
  }

  void _deleteAddress(int id,int index) async {
    setState(() {
      _isLoading=true;
    });
    await ScopedModel.of<RestaurantsApiModel>(context).deleteAddress(id).then((value) {
      if(value.status.status)
        ScopedModel.of<RestaurantsApiModel>(context).removeFromAddress(index);
      else
        AppDialog.showMe(context, value.status.HTTP_response);
      setState(() {
        _isLoading=false;
      });
    });
  }

}

