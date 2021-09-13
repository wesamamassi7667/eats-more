import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/branch_widget.dart';
import 'package:eat_more_app/component/header_component.dart';
import 'package:eat_more_app/component/list_address_sheet.dart';
import 'package:eat_more_app/component/map_widget.dart';
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

  BranchScreen({Key key, this.id, this.idWay}) : super(key: key);

  @override
  _BranchScreenState createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  List<Branch> _branches;
  var _isLoading = false;
  GoogleMapController mapController;
  double lat, lng;
  Address _address;
  var _covered = 'Not Covered';
  BitmapDescriptor customIcon;
  var _isLoading1 = false;
  Position pos;

  @override
  void initState() {
    _branches = [];
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(50, 50)), 'assets/images/marker.png')
        .then((icon) {
      customIcon = icon;
    });
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
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
                  ? MapWidget(
                      onMapCreated: _onMapCreated,
                      markers: model.marker,
                      id: widget.id,
                      address: _address,
                      loading: _isLoading,
                      branches: _branches,
                      lat: lat,
                      lng: lng,
                      covered: _covered,
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
                            mapController:mapController
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }

   _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _setMapPins();
  }

  void _getBranches(String lat, String lng, type) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await ScopedModel.of<RestaurantsApiModel>(context)
          .listBranch(widget.id, lng, lat, type)
          .then((value) {
        if (value.status.status) {
          _branches.clear();
          if (widget.idWay == 0) {
            ScopedModel.of<RestaurantsApiModel>(context).clearMarks();
            _setMapPins();
          }
          _branches.addAll(value.data.branches);
          if (widget.idWay == 0) if (_branches.isNotEmpty) {
            _covered = "Covered";
            ScopedModel.of<RestaurantsApiModel>(context).clearMarks();
            _setMapPins();
            for (var index = 0; index < _branches.length; index++) {
              setState(() {
                ScopedModel.of<RestaurantsApiModel>(context).addToMarker(Marker(
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
          } else {
            _covered = 'Not Covered';
          }
        } else {
          AppDialog.showMe(context, value.status.HTTP_response);
        }
        setState(() {
          _isLoading = false;
        });
      });
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      AppDialog.showMe(context, err.toString());
      return;
    }
  }

  void _setMapPins() {
    setState(() {
      ScopedModel.of<RestaurantsApiModel>(context).addToMarker(
        Marker(
            onTap: () {
              print('Tapped');
            },
            draggable: true,
            markerId: MarkerId('Marker'),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(pos.latitude, pos.longitude),
            onDragEnd: ((newPosition) async {
              setState(() {
                lat = newPosition.latitude;
                lng = newPosition.longitude;
              });
              _getBranches('$lat', '$lng ', 'delivery');
              _getAddressFromLatAndLng(lat, lng);
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

  void _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      print(position.longitude);
      setState(() {
        pos = position;
        lat = pos?.latitude ?? 0.0;
        lng = pos?.longitude ?? 0.0;
      });
      if (widget.idWay == 1)
        _getBranches(lat.toString(), lng.toString(), "pickup");
      else {
        setState(() {
          _isLoading = false;
        });
        _getAddressFromLatAndLng(lat, lng);
        _getAddress();
      }
    }).catchError((e) {
      print(e);
    });
  }

  void _getAddressFromLatAndLng(double lat, double lng) async {
    final coordinates = new Coordinates(lat, lng);
    await Geocoder.local
        .findAddressesFromCoordinates(coordinates)
        .then((value) {
      setState(() {
        _address = value != null && value.isNotEmpty ? value[0] : null;
        print("locity" + _address.locality ?? '');
        print("featureName" + _address.featureName);
        print("line" + _address.addressLine);
        print('country' + _address.countryName);
      });
    });
  }
}
