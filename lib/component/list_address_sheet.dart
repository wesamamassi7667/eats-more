
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/address_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ListAddressSheet extends StatefulWidget {
  final ScrollController controller;
  final bool loading;
  final Function press;
  final List<Addresses> list;

  const  ListAddressSheet({Key key, this.controller, this.loading,this.list, this.press}) : super(key: key);
  @override
  _ListAddressSheetState createState() => _ListAddressSheetState();
}

class _ListAddressSheetState extends State<ListAddressSheet> {
  var _isLoading=false;
  var _selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
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
                child:widget.loading?Center(child: CupertinoActivityIndicator(),):widget.list==null||widget.list.isEmpty?
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
                      return Padding(
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
                                  child: Text(widget.list[index].address,
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
                                    _deleteAddress(widget.list[_selectedIndex].id,_selectedIndex);
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
                      );
                    },
                    separatorBuilder: (context,index){
                      return Divider(
                        color: grey4.withOpacity(0.24),
                      );
                    }, itemCount:widget.list.length),
              ),

            ],
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

