
import 'package:flutter/material.dart';

import '../color.dart';
class TileDrawer extends StatelessWidget {
  final String name;
  final IconData icon;
   final Function tap;
  const TileDrawer({
    Key key, this.name, this.icon, this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      title:Text(
        name,
        style: TextStyle(
          fontFamily: 'DIN Next LT Arabic',
          fontSize: 15,
          color: black1,
        ),
      ),
      leading: Icon(
        icon,
        color: black1.withOpacity(0.8),
      ),
    );
  }
}