import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class Loader extends StatefulWidget {
  const Loader({Key key}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset("assets/2.json",),
    );
  }
}
class LoadingShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: Colors.transparent,
      highlightColor: Theme.of(context).primaryColorDark,
      enabled: true,
      loop: 6,
      child: Container(
        // width: width,
        // height: height,
        color: Colors.transparent,
        padding: EdgeInsets.all(8.0),
        child: Image.asset('assets/logo.png', height: height * 0.3),
      ),
    );
  }
}
