import 'package:flutter/material.dart';

import '../color.dart';
class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({Key key, this.color=grey4}) : super(key: key);
   final Color color;
  @override
  Widget build(BuildContext context) {
    return Divider(
      color:color.withOpacity(0.24),
      thickness:  1,
    );
  }
}
