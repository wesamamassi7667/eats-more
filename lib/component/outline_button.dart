import 'package:flutter/material.dart';

class OutLineButton extends StatelessWidget {
  final Function tap;
  final Widget child;
  final double width;

  const OutLineButton({Key key, this.tap, this.width, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ButtonTheme(
      minWidth: width,
      child: OutlineButton(
        onPressed: tap,
        child: child,
        borderSide: BorderSide(
          width: 1.0,
          color: const Color(0xff0068b0),
          style: BorderStyle.solid,
        ),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }
}

