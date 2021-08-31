import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/branch_widget.dart';
import 'package:eat_more_app/component/header_component.dart';
import 'package:eat_more_app/component/list_address_sheet.dart';
import 'package:eat_more_app/component/save_address_sheet.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/branch_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class BranchScreen extends StatefulWidget {
  final int id;
  final int idWay;
  Position pos;

  BranchScreen({Key key, this.id, this.idWay, this.pos}) : super(key: key);

  @override
  _BranchScreenState createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  List<Branch> _branches;
  var _isLoading = false;
  GoogleMapController mapController;
  double lat, lng;
  // String _currentAddress;
  Address _address;
  var _covered = 'Not Covered';
  var _color = red;
  BitmapDescriptor customIcon;
  var _isLoading1 = false;
  Set<Marker> _markers = Set<Marker>();

  @override
  void initState() {
    _branches = [];
    lat = widget.pos?.latitude ?? 0.0;
    lng = widget.pos?.longitude ?? 0.0;
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(50, 50)), 'assets/images/marker.png')
        .then((icon) {
      customIcon = icon;
    });
    // TODO: implement initState

    super.initState();
    if (widget.idWay == 1)
      _getBranches(null, null, 'pickup');
    else
      _getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ScopedModelDescendant<RestaurantsApiModel>(
        builder: (context, child, model) => Stack(
          children: [
            HeaderComponent(
              id: widget.idWay,
              title: widget.idWay == 0 ? "العنوان" : 'عنوان الفرع',
              child: widget.idWay == 0
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: GoogleMap(
                            markers: _markers,
                            onMapCreated: _onMapCreated,
                            myLocationEnabled: true,
                            tiltGesturesEnabled: true,
                            compassEnabled: true,
                            zoomControlsEnabled: false,
                            scrollGesturesEnabled: true,
                            zoomGesturesEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(lat, lng),
                              zoom: 15.0,
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          top: 23,
                          start: 20,
                          end: 20,
                          child: Container(
                            height: _address == null ? 50 : null,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11.0),
                              color: background.withOpacity(0.95),
                            ),
                            child: _address == null
                                ? Center(child: Text('UNKNOWN'))
                                : Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        top: 10,
                                        start: 11,
                                        end: 11,
                                        bottom: 10),
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: _address.addressLine == null
                                              ? ""
                                              : _address.adminArea != null
                                                  ? _address.addressLine + ", "
                                                  : _address.addressLine,
                                          style: TextStyle(
                                            fontFamily: 'DIN Next LT Arabic',
                                            fontSize: 15,
                                            color: black4.withOpacity(0.68),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: _address.adminArea == null
                                              ? ""
                                              : _address.adminArea,
                                          style: TextStyle(
                                            fontFamily: 'DIN Next LT Arabic',
                                            fontSize: 15,
                                            color: black4.withOpacity(0.68),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ]),
                                    )),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 70),
                            child: _isLoading
                                ? CupertinoActivityIndicator()
                                : Text(
                                    _covered,
                                    style: TextStyle(
                                      fontFamily: 'DIN Next LT Arabic',
                                      fontSize: 18,
                                      color: _color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        PositionedDirectional(
                          bottom: 10,
                          start: 60,
                          end: 60,
                          child: AbsorbPointer(
                            absorbing: _branches.isEmpty ? true : false,
                            child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    enableDrag: true,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                      ),
                                    ),
                                    builder: (context) {
                                      return SaveAddressSheet(
                                        address: _address,
                                        lat: lat.toString(),
                                        lng: lng.toString(),
                                        branches: _branches,
                                        id: widget.id,
                                      );
                                    }).then((value) => Navigator.pop(context));
                              },
                              child: Text(
                                AppLocalization.of(context)
                                    .translate("address_confirmation"),
                                style: TextStyle(
                                  fontFamily: 'DIN Next LT Arabic',
                                  color: _branches.isEmpty ? grey2 : background,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: primaryIconColor,
                              ),
                            ),
                          ),
                        ),
                        //
                      ],
                    )
                  : BranchWidget(
                      isLoading: _isLoading,
                      branches: _branches,
                      id: widget.id,
                      idWay: widget.idWay,
                    ),
            ),
            widget.idWay == 1
                ? SizedBox.shrink()
                : SizedBox.expand(
                    child: DraggableScrollableSheet(
                        expand: false,
                        minChildSize: 0.03,
                        initialChildSize: 0.06,
                        maxChildSize: 0.45,
                        builder: (context, controller) {
                          return ListAddressSheet(
                            controller: controller,
                            loading: _isLoading1,
                            list: model.address,
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _setMapPins();
  }

  void _getBranches(String lat, String lng, type) async {
    print(widget.id);
    try{
      setState(() {
        _isLoading = true;
      });
      await ScopedModel.of<RestaurantsApiModel>(context)
          .listBranch(widget.id, lng, lat, type)
          .then((value) {
        if (value.status.status) {
          _branches.clear();
          _branches.addAll(value.data.branches);
          if (widget.idWay == 0) if (_branches.isNotEmpty) {
            _covered = "Covered";
            _color = green1;
            for (var index = 0; index < _branches.length; index++) {
              setState(() {
                _markers.add(Marker(
                  markerId: MarkerId(_branches[index].branch_id.toString()),
                  icon: customIcon,
                  position: LatLng(
                    double.parse(_branches[index].latitude),
                    double.parse(_branches[index].longitude),
                  ),
                  infoWindow: InfoWindow(
                    title: _branches[index].branch_name,
                    snippet: _branches[index].branch_address,
                  ),
                ));
              });
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(double.parse(_branches[index].latitude),
                          double.parse(_branches[index].longitude)),
                      zoom: 10.0)));
            }
          }
        } else {
          AppDialog.showMe(context, value.status.HTTP_response);
        }
        setState(() {
          _isLoading = false;
        });
      });
    }
    catch(err){
      setState(() {
        _isLoading=false;
      });
      AppDialog.showMe(context, err.toString());
      return;
    }
  }

  void _setMapPins() {
    setState(() {
      _markers.add(
        Marker(
            onTap: () {
              print('Tapped');
            },
            draggable: true,
            markerId: MarkerId('Marker'),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(widget.pos.latitude, widget.pos.longitude),
            onDragEnd: ((newPosition) async {
              print(newPosition.latitude);
              print(newPosition.longitude);
              setState(() {
                lat = newPosition.latitude;
                lng = newPosition.longitude;
              });
              print(lat);
              print(lng);
              _getBranches('$lat', '$lng ', 'delivery');
              final coordinates = new Coordinates(lat, lng);
              await Geocoder.local
                  .findAddressesFromCoordinates(coordinates)
                  .then((value) {
                setState(() {
                  // _currentAddress =
                  //     value != null && value.isNotEmpty
                  //         ? value[0].toString()
                  //         : "Unknown";
                  _address =
                      value != null && value.isNotEmpty ? value[0] : null;
                  print("locity" + _address.locality ?? '');
                  print("featureName" + _address.featureName);
                  print("line" + _address.addressLine);
                  print('country' + _address.countryName);
                });
              });
            })),
      );
    });
  }

  void _getAddress() async {
    setState(() {
      _isLoading1 = true;
    });
    await ScopedModel.of<RestaurantsApiModel>(context)
        .getAddress()
        .then((value) {
      if (value.status.status)
        ScopedModel.of<RestaurantsApiModel>(context)
            .addAllToAddress(value.data?.addresses ?? []);
      setState(() {
        _isLoading1 = false;
      });
    });
  }
}
