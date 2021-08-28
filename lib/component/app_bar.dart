
import 'package:flutter/material.dart';

import '../color.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double total;
  final bool isProfile;
  final Function press;
  const AppBarWidget({
    Key key, this.title, this.total, this.isProfile=false, this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: primaryIconColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'DIN Next LT Arabic',
          fontSize: 20,
          color: background,
        ),
      ),
      leading: CloseButton(
        color: Colors.white,
        onPressed: (){
          Navigator.pop(context,total);
        },
      ),
      actions:isProfile? [
        IconButton(
          onPressed:press,
          icon: Icon(
            Icons.edit,
            color: background,
          ),
        ),

        SizedBox(width: 15,),
      ]:null,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>AppBar().preferredSize;
}