import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomClips extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    final path = Path();
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(size.width / 1, size.height-40, //point #3
        size.width / 2, size.height-20);
    var secondControlPoint =
    Offset(size.width - size.width/6, size.height); //#point #5
    var secondEndPoint = Offset(size.width, size.height-30); //point #6
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height); //move to top right #7
    path.lineTo(size.width, 0.0); //and back to the origin, could not be necessary #1
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
class CustomClips1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    final path = Path();
    path.lineTo(size.width-100, size.height-100);
    path.quadraticBezierTo(size.width+100, size.height+300, //point #3
        size.width+100 , size.height+10);
    var secondControlPoint =
    Offset(size.width - size.width/4, size.height+200); //#point #5
    var secondEndPoint = Offset(size.width, size.height-100); //point #6
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height+100); //move to top right #7
    path.lineTo(size.width, 0.0); //and back to the origin, could not be necessary #1
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
class OvalLeftBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(40, 0);
    path.quadraticBezierTo(0, size.height / 4, 0, size.height / 2);
    path.quadraticBezierTo(0, size.height - (size.height / 4), 40, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
class HeaderClipper extends CustomClipper<Path> {
  ///The value is - 1 ~ 1.0
  double moveFlag = 0;

  // HeaderClipper(this.moveFlag);

  @override
  Path getClip(Size size) {
    //Create Path
    Path path = Path();
    //Move to point P0, which is also the starting point of the curve
    path.lineTo( size.height*2.1, size.height * 2.5);
    //Calculate the coordinates of control point P1

    double yCenter = size.height * 0.1 + 45 * cos(moveFlag*pi);
    //Construction of second order Bessel curve
    path.quadraticBezierTo(20, yCenter-20, size.width*0.7, size.height * 0.0001);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    //Refresh
    return true;

  }
}

class StarClipper extends CustomClipper<Path> {
  StarClipper(this.numberOfPoints);

  /// The number of points of the star
  final int numberOfPoints;

  @override
  Path getClip(Size size) {
    double width = size.width;

    double halfWidth = width / 2;

    double bigRadius = halfWidth;

    double radius = halfWidth / 2;

    double degreesPerStep = _degToRad(360 / numberOfPoints);

    double halfDegreesPerStep = degreesPerStep / 2;

    var path = Path();

    double max = 2 * math.pi;

    path.moveTo(width, halfWidth);

    for (double step = 0; step < max; step += degreesPerStep) {
      path.lineTo(halfWidth + bigRadius * math.cos(step),
          halfWidth + bigRadius * math.sin(step));
      path.lineTo(halfWidth + radius * math.cos(step + halfDegreesPerStep),
          halfWidth + radius * math.sin(step + halfDegreesPerStep));
    }

    path.close();
    return path;
  }

  num _degToRad(num deg) => deg * (math.pi / 180.0);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    StarClipper oldie = oldClipper as StarClipper;
    return numberOfPoints != oldie.numberOfPoints;
  }
}