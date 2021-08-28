
import 'package:flutter/material.dart';

import '../color.dart';
class TitleCheckOut extends StatelessWidget {
  final String title;
  final String type;
  const TitleCheckOut({
    Key key,
    this.title, this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 16,end: 16),
          child: Row(
            children: [
              Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'DIN Next LT Arabic',
                    fontSize: 18,
                    color: black3,
                  ),
              ),
              Spacer(),
              type!=null?Text(type,
                style: TextStyle(
                  fontFamily: 'DIN Next LT Arabic',
                  fontSize: 15,
                  color: black3,
                ),
                ):SizedBox.shrink(),
            ],
          ),
        ),
        SizedBox(height: 4,),
      ],
    );
  }
}