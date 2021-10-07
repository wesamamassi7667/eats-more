import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../color.dart';
class HeaderComponent extends StatelessWidget {
  final Widget child;
  final String title;
  final int id;


  const HeaderComponent({Key key, this.child, this.title='', this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: black,
        ),
        // PositionedDirectional(
        //   start: -150,
        //   end: -150,
        //   top: -450,
        //   child: SvgPicture.string(
        //     '<svg viewBox="-189.0 -521.0 787.0 787.0" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff2e4f92"  /><stop offset="0.154669" stop-color="#ff2d4f91"  /><stop offset="0.724269" stop-color="#ff274f8e"  /><stop offset="1.0" stop-color="#ffa9d8f2"  /></linearGradient></defs><path transform="translate(-189.0, -521.0)" d="M 393.5 0 C 610.8240356445313 0 787 176.1759643554688 787 393.5 C 787 610.8240356445313 610.8240356445313 787 393.5 787 C 176.1759643554688 787 0 610.8240356445313 0 393.5 C 0 176.1759643554688 176.1759643554688 0 393.5 0 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
        //     allowDrawingOutsideViewBox: true,
        //     fit: BoxFit.fill,
        //   ),
        // ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'DIN Next LT Arabic',
                fontSize: 20,
                color:background,
                fontWeight: FontWeight.w400,
              ),
            ),
            centerTitle: true,
            leading: BackButton(
              color: background,
            ),


          ),
          body: Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsetsDirectional.only(top: 40,bottom:id==0? 70:39,start: 20,end:20),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(40.0),
              //   color: background,
              //   boxShadow: [
              //     BoxShadow(
              //       color: black.withOpacity(0.12),
              //       offset: Offset(0, 3),
              //       blurRadius: 4,
              //     ),
              //   ],
              // ),
              child:child,
          ),
        ),
      ],
    );
  }
}
