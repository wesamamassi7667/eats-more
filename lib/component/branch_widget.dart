import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/branch_response.dart';
import 'package:eat_more_app/screens/restuerant_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class BranchWidget extends StatelessWidget {
  final int id;
  final int idWay;
  const BranchWidget({
    Key key,
    @required bool isLoading,
    @required List<Branch> branches,
    this.id,
    this.idWay,
  })  : _isLoading = isLoading,
        _branches = branches,
        super(key: key);

  final bool _isLoading;
  final List<Branch> _branches;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CupertinoActivityIndicator())
        : ClipRRect(
            borderRadius: BorderRadius.circular(40.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.only(top: 43, bottom: 20),
                child: Column(
                  children: [
                    Text(
                      AppLocalization.of(context).translate("select_branch"),
                      style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontSize: 20,
                        color: black4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListView.builder(
                        itemCount: _branches.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RestaurantScreen(
                                            id: id,
                                            branch: _branches[index],
                                            idWay: idWay,
                                          )
                                  )
                              );
                            },
                            child: SecondContainerComponent(
                                start: 13, end: 13, top: index == 35 ? 0 : 12,
                                startP: 8, endP: 4, topP: 5, bottomP: 5,
                                 radius: BorderRadius.circular(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        _branches[index].branch_name,
                                        style: TextStyle(
                                          fontFamily: 'DIN Next LT Arabic',
                                          fontSize: 20,
                                          color: black1,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: black1,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  _branches[index].branch_address == null
                                      ? SizedBox.shrink()
                                      : Text(
                                          _branches[index].branch_address ?? "",
                                          style: TextStyle(
                                            fontFamily: 'DIN Next LT Arabic',
                                            fontSize: 16,
                                            color: black1,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    _branches[index].distance +
                                        " " +
                                        _branches[index].distance_type,
                                    style: TextStyle(
                                      fontFamily: 'DIN Next LT Arabic',
                                      fontSize: 16,
                                      color: black1,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
  }
}
