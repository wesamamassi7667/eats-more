import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/arguments/restaurent_argument.dart';
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
        ? MyProgressIndicator()
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
                          Branch _branch = _branches[index];
                          return InkWell(
                            onTap: () {
                              RestaurantArgument _argument = RestaurantArgument(
                                  id: id, idWay: idWay, branch: _branch);
                              Navigator.pushNamed(context, '/restaurant',
                                  arguments: _argument);
                            },
                            child: SecondContainerComponent(
                              start: 13,
                              end: 13,
                              top: index == 35 ? 0 : 12,
                              startP: 8,
                              endP: 4,
                              topP: 5,
                              bottomP: 5,
                              radius: BorderRadius.circular(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        _branch.branch_name,
                                        style: TextStyle(
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
                                          _branch.branch_address ?? "",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: black1,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    _branch.distance +
                                        " " +
                                        _branch.distance_type,
                                    style: TextStyle(
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
