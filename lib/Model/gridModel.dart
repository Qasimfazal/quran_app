import 'package:flutter/cupertino.dart';

class GridModel{
  Color topColor,bottomColor;
  var image,name;
  var pageRoute;
  var layers;
  bool isAdd;

  GridModel(
      {this.topColor,
      this.bottomColor,
      this.image,
      this.name,
      this.pageRoute,
      this.layers,
      this.isAdd
      });
}