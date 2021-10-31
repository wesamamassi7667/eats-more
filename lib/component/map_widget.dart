import 'package:eat_more_app/component/save_address_sheet.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/branch_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../color.dart';
class MapWidget extends StatelessWidget {
  final Function onMapCreated;
  final   Set<Marker> markers;
  final double lat, lng;
 final  Address address;
 final bool loading;
 final List<Branch> branches;
 final String covered;
 final int id;

  const MapWidget({Key key, this.onMapCreated, this.markers, this.lat, this.lng, this.address, this.loading=false, this.branches, this.covered, this.id,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: GoogleMap(
            markers: markers,
            onMapCreated: onMapCreated,
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
            height: address == null ? 50 : null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: background.withOpacity(0.95),
            ),
            child: address == null
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
                      text: address.addressLine == null
                          ? ""
                          : address.adminArea != null
                          ? address.addressLine + ", "
                          : address.addressLine,
                      style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 15,
                        color: black4.withOpacity(0.68),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: address.adminArea == null
                          ? ""
                          : address.adminArea,
                      style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 15,
                        color: black4.withOpacity(0.68),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ]),
                )
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: loading
                ? CupertinoActivityIndicator()
                : Text(
              covered,
              style: TextStyle(
                fontSize: 18,
                color: branches.isEmpty?red:green1,
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
            absorbing: branches.isEmpty ? true : false,
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
                        address: address,
                        lat: lat.toString(),
                        lng: lng.toString(),
                        branches: branches,
                        id:id,
                      );
                    }).then((value) => Navigator.pop(context));
              },
              child: Text(
                AppLocalization.of(context)
                    .translate("address_confirmation"),
                style: TextStyle(
                  color: branches.isEmpty ? grey2 : background,
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
    );
  }
}
