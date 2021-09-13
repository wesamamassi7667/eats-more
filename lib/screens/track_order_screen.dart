import 'dart:async';

import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/app_bar.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/track_order.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/order_response.dart';
import 'package:eat_more_app/repositories/map_repository.dart';
import 'package:eat_more_app/utils/map_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';

class TrackOrderScreen extends StatefulWidget {
  final int id;
  final bool isOrder;

  const TrackOrderScreen({Key key, this.id, this.isOrder = false})
      : super(key: key);
  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  final _icons = [
    Icons.location_pin,
    'assets/images/store.png',
    Icons.restaurant,
    Icons.delivery_dining,
    Icons.check,
  ];
  String googleAPIKey = "AIzaSyD2MyWfbpjmffhNTuImegIvrdgEC1t1J4E";
  BitmapDescriptor driverIcon;
  BitmapDescriptor branchIcon;
  BitmapDescriptor _recipientIcon;
  PolylinePoints polylinePoints = PolylinePoints();
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polyline = {};
  List<LatLng> polylineCoordinates = [];
  var _status;
  var _isLoading = false;
  TrackOrder _orderStatus;
  var _currentPage = 0;
  double lat;
  double lng;
  LatLng driverLatLng;
  LatLng branchLatLng;
  LatLng _recipientLatLng;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_currentPage == 0) _trackOrder();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _status = [
      AppLocalization.of(context).translate("order_received"),
      AppLocalization.of(context).translate("preparing"),
      AppLocalization.of(context).translate("cooking"),
      AppLocalization.of(context).translate("arriving"),
      AppLocalization.of(context).translate("delivered"),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _back();
      },
      child: Scaffold(
        backgroundColor: primaryIconColor,
        appBar: AppBarWidget(
          title: AppLocalization.of(context).translate("track_order"),
        ),
        body: Stack(
          children: [
            PositionedDirectional(
              start: 0,
              end: 0,
              bottom: 0,
              top: 10,
              child: _isLoading
                  ? ContainerComponent(
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    )
                  : ContainerComponent(
                      child: Column(
                        children: [
                          Flexible(
                            child: _currentPage == 0
                                ? Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      top: 30,
                                      start: 30,
                                      end: 30,
                                    ),
                                    child: TrackWidget(
                                        orderStatus: _orderStatus,
                                        icons: _icons,
                                        status: _status))
                                : ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(44.0),
                                      topRight: Radius.circular(44.0),
                                    ),
                                    child: GoogleMap(
                                      myLocationEnabled: true,
                                      compassEnabled: true,
                                      tiltGesturesEnabled: false,
                                      markers: _markers,
                                      polylines: _polyline,
                                      mapType: MapType.normal,
                                      scrollGesturesEnabled: true,
                                      zoomGesturesEnabled: true,
                                      initialCameraPosition: CameraPosition(
                                          target: branchLatLng, zoom: 11),
                                      onMapCreated: _onMapCreated,
                                    ),
                                  ),
                          ),
                          _currentPage == 0
                              ? SafeArea(
                                  child: Align(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    child: Container(
                                      color: grey14,
                                      height: 83,
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 22),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InputChip(
                                            onPressed: () {
                                              setState(() {
                                                _currentPage = 1;
                                              });
                                              setSourceAndDestinationIcons();
                                            },
                                            label: Container(
                                              child: Text(AppLocalization.of(
                                                      context)
                                                  .translate("track_order")),
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                            ),
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontFamily:
                                                    'DIN Next LT Arabic'),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            backgroundColor: primaryIconColor,
                                          ),
                                          ButtonTheme(
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: OutlineButton(
                                              onPressed: () {},
                                              child: Text(
                                                  AppLocalization.of(context)
                                                      .translate(
                                                          "cancel_order"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: primaryIconColor,
                                                      fontFamily:
                                                          'DIN Next LT Arabic')),
                                              shape: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: BorderSide(
                                                    color: Color(0xffD6D6D6),
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _trackOrder() async {
    setState(() {
      _isLoading = true;
    });
    await ScopedModel.of<RestaurantsApiModel>(context)
        .trackOrder(widget.id)
        .then((value) async {
      if (value.status.status) {
        _orderStatus = value.data;
        if (value.data.track == null) {
          setState(() {
            lng = double.parse(value.data.branch.branch.branch_long);
            lat = double.parse(value.data.branch.branch.branch_lat);

            branchLatLng = LatLng(
                double.parse(value.data.branch.branch.branch_lat),
                double.parse(value.data.branch.branch.branch_long));
          });
          await _getCurrentLocation().then((value) {
            setState(() {
              _recipientLatLng = LatLng(value.latitude, value.longitude);
            });
          });
        } else {
          setState(() {
            lng = double.parse(value.data.track.data.jobs[0].job_longitude);
            lat = double.parse(value.data.track.data.jobs[0].job_latitude);
            branchLatLng = LatLng(
                double.parse(value.data.track.data.jobs[0].job_latitude),
                double.parse(value.data.track.data.jobs[0].job_longitude));
            _recipientLatLng = LatLng(
                double.parse(value.data.track.data.jobs[1].job_latitude),
                double.parse(value.data.track.data.jobs[1].job_longitude));
          });
        }
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  void setSourceAndDestinationIcons() async {
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(60, 60)), 'assets/images/driver.png')
        .then((icon) {
      driverIcon = icon;
    });
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(40, 40)), 'assets/images/marker.png')
        .then((icon) {
      branchIcon = icon;
      // _getPolyline();
    });
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(40, 40)),
            'assets/images/recipient.png')
        .then((icon) {
      _recipientIcon = icon;
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    _setMapPins();
    _addPolyLines();
  }

  void _setMapPins() {
    _markers.clear();
    setState(() {
      // _markers.add(Marker(
      //     markerId: MarkerId('driverPin'),
      //     position: driverLatLng,
      //     icon: driverIcon
      // ));
      _markers.add(Marker(
        markerId: MarkerId('branchPin'),
        position: branchLatLng,
        icon: branchIcon,
        infoWindow: InfoWindow(
          title: _orderStatus.branch?.branch?.branch_name ?? "",
        ),
      ));
      _markers.add(Marker(
          markerId: MarkerId('recipientPin'),
          position: _recipientLatLng,
          icon: _recipientIcon));
    });
  }

  _addPolyLines() {
    setState(() {
      lat = (branchLatLng.latitude + _recipientLatLng.latitude) / 2;
      lng = (branchLatLng.longitude + _recipientLatLng.longitude) / 2;
      _moveCamera(13.0);
      _setPolyLine();
    });
  }

  _moveCamera(double zoom) async {
    final CameraPosition myPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: zoom ?? 14.4746,
    );
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(myPosition));
  }

  _setPolyLine() async {
    final result = await MapRepository()
        .getRouteCoordinates(branchLatLng, _recipientLatLng, googleAPIKey);
    if (result.success) {
      final route = result.data["routes"][0]["overview_polyline"]["points"];
      setState(() {
        _polyline.add(Polyline(
            polylineId: PolylineId("tripRoute"),
            //pass any string here
            width: 3,
            geodesic: true,
            points: MapUtils.convertToLatLng(MapUtils.decodePoly(route)),
            color: primaryIconColor));
      });
    }
  }
  void _back() {
    if (!widget.isOrder)
      Navigator.pop(context);
    else {
      var _count = 0;
      Navigator.popUntil(context, (Route<dynamic> route) => _count++ == 5);
    }
  }
  Future<Position> _getCurrentLocation() {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
