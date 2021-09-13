import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/yes_no_buttons.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/branch_response.dart';
import 'package:eat_more_app/screens/restuerant_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:scoped_model/scoped_model.dart';


class SaveAddressSheet extends StatefulWidget {
  final Address address;
  final String lat,lng;
  final List<Branch> branches;
  final int id;

  const SaveAddressSheet({Key key, this.address, this.lat, this.lng, this.branches, this.id}) : super(key: key);
  @override
  _SaveAddressSheetState createState() => _SaveAddressSheetState();
}

class _SaveAddressSheetState extends State<SaveAddressSheet> {
  var _isLoading = false;
  String _address='';
 @override
  void initState() {
    // TODO: implement initState
   if(widget.address!=null){
   print(widget.address.featureName);//repeat
   print(widget.address.addressLine);//Enough
   print(widget.address.postalCode);
   print(widget.address.adminArea);
   if(widget.address.addressLine!=null)
     _address=widget.address.addressLine;
   if(widget.address.adminArea!=null)
     if(widget.address.addressLine!=null)
       _address +=", "+widget.address.adminArea;
     else
       _address=widget.address.adminArea;

   }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      padding: EdgeInsets.only(top: 15.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalization.of(context).translate("want_save_address"),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 18,
              color: black3,
            ),
          ),
          SizedBox(
            height: 46.8,
          ),
         YesNoButtons(isLoading: _isLoading,tap:(){_saveAddress();},width: MediaQuery.of(context).size.width * 0.4,
           pressNo: (){
             navigateToVendorScreen();
           },
         )
        ],
      ),
    );
  }

  void _saveAddress() async {
    setState(() {
      _isLoading = true;
    });
    var _body = {
      "address": widget.address==null?"UNKNOWN":_address,
      "address_label":"kk",
      "storey_number":"12345",
      "apartment_number":"1233",
      "lat": widget.lat,
      "long": widget.lng,
    };
    await ScopedModel.of<RestaurantsApiModel>(context).postAddress(_body).then((value){
          if(value.status.status)
            _getAllAddresses();
          else
            AppDialog.showMe(context, value.status.HTTP_response);

    });
  }

  void _getAllAddresses() async{
    await ScopedModel.of<RestaurantsApiModel>(context).getAddress().then((value){
      if(value.status.status)
      ScopedModel.of<RestaurantsApiModel>(context).addAllToAddress(value.data?.addresses??[]);
      if(mounted)
        setState(() {
          _isLoading=false;
        });
        navigateToVendorScreen();
    });

  }

  void navigateToVendorScreen() {
    var _count = 0;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ResturantScreen(
        idWay: 0,
        branch: widget.branches[0],
        address:_address,
        id: widget.id,
        lat :widget.lat,
        lng:widget.lng
    )), (route) => _count++ == 1);
  }
}
