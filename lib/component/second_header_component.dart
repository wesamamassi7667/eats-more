
import 'package:eat_more_app/component/container_component.dart';
import 'package:flutter/material.dart';

import '../color.dart';
import 'app_bar.dart';
class SecondHeaderComponent extends StatelessWidget {
  const SecondHeaderComponent({Key key, this.title, this.child}) : super(key: key);
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryIconColor,
      appBar: AppBarWidget(
        title: title,
      ),
      body: Stack(
        children: [
          PositionedDirectional(
              start: 0,
              end: 0,
              bottom: 0,
              top: 10,
              child: ContainerComponent(
                child:child ,
              )
          )
        ],
      ),
    );
  }
}
