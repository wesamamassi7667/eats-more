
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/branch_response.dart';
import 'package:eat_more_app/model/order_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../color.dart';
import 'check_out_tile.dart';
import 'container_component.dart';
class AddressCheckOutWidget extends StatelessWidget {
  const AddressCheckOutWidget({
    Key key, this.branch, this.isOrder=false, this.address,
  }) : super(key: key);
  final String address;
  final Branch branch;
  final bool isOrder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleCheckOut(
          title: AppLocalization.of(context).translate("delivery_address"),
        ),
        SecondContainerComponent(
          radius: const BorderRadius.all(Radius.circular(5)),
          child: Row(
            children: [
              Flexible(
                child: ListTile(
                  isThreeLine: true,
                  subtitle:
                 address==null||address.trim().isEmpty?Text(
                          '${branch.branch_address}\n'" ${branch.distance} ${branch.distance_type}",
                          maxLines: 2,
                          style: TextStyle(
                            fontFamily:
                            'DIN Next LT Arabic',
                            fontSize: 14,
                            color: black1
                                .withOpacity(0.76),
                            
                            fontWeight:
                            FontWeight.w300,
                          ),
                      ):SizedBox.shrink(),


                  title: Text(
                    address==null||address.trim().isEmpty? "${branch.branch_name}":'$address',
                    style: TextStyle(
                      fontFamily:
                      'DIN Next LT Arabic',
                      fontSize: 16,
                      color: black1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Spacer(),
             !isOrder? IconButton(
                  icon: SvgPicture.asset(
                      'assets/images/edit.svg'),
                  onPressed: () {}):SizedBox.shrink()
            ],
          ),
        ),
      ],
    );
  }
}
