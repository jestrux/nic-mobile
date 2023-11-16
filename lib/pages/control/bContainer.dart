import 'dart:math';

import 'package:flutter/material.dart';

import 'customClipper.dart';

class BezierContainer extends StatelessWidget {
  final Color? customColor;

  const BezierContainer({this.customColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.rotate(
        angle: -pi / 3.5,
        child: ClipPath(
          clipper: ClipPainter(),
          child: Container(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topCenter,
                colors: [
                  Color(0xff66bb6a),
                  this.customColor != null
                      ? this.customColor!
                      : Color(0xff1b5e20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
