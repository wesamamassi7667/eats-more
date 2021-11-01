import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:eat_more_app/model/branch_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../color.dart';
import 'container_component.dart';

class AddressCheckOutWidget extends StatelessWidget {
  final String address;
  final Branch branch;
  final bool isOrder;
  const AddressCheckOutWidget({
    Key key,
    this.branch,
    this.isOrder = false,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SecondContainerComponent(
      width: double.infinity,
      topP: 15,
      bottomP: 14,
      startP: 15,
      endP: 15,
      radius: const BorderRadius.all(Radius.circular(5)),
      child: Row(
        children: [
           Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                decoration: BoxDecoration(
                  color: primaryIconColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  AppLocalization.of(context)
                      .translate(address != null ? "deliver_to" : "pickup_from"),
                  style: TextStyle(color: background, fontSize: 13),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: MediaQuery.of(context).size.width-150,
                child: Text(
                  address == null || address.trim().isEmpty
                      ? "${branch.branch_name}"
                      : '$address',
                  // maxLines: 3,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              address == null || address.trim().isEmpty
                  ? Text(
                      '${branch.branch_address}\n'
                      " ${branch.distance} ${branch.distance_type}",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        color: black.withOpacity(0.76),
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  : SizedBox.shrink(),
            ]),

          isOrder?SizedBox():Spacer(),
        isOrder?SizedBox.shrink():OutlinedButton(
            onPressed: () {},
            child: Text(
              AppLocalization.of(context).translate('change'),
            ),
            style: AppThemeData.buttonStyle(borderRadius: 6),
          ),
        ],
      ),
    );
  }
}
