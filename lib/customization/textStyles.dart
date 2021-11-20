import 'package:flutter/material.dart';

TextStyle heading ({fontWeight,color}){
  return TextStyle(color:color?? Color(0xfff1f6266),fontFamily: 'Sen',fontSize: 17,fontWeight: fontWeight??FontWeight.bold);}
TextStyle ayats ({fontWeight,color}){
  return TextStyle(color:color?? Color(0xfff1f6266),fontSize: 22,fontWeight: fontWeight??FontWeight.bold,fontFamily: 'Sen');
}
TextStyle headingWhite ({fontWeight}){
  return TextStyle(color: Colors.white,fontFamily: 'Sen',fontSize: 18,fontWeight: fontWeight??FontWeight.bold);
}
TextStyle normalText ({color}){
  return TextStyle(color: color??Color(0xfff1f6266),fontFamily: 'Sen',fontSize: 15);}
TextStyle smallText ({color}){
  return TextStyle(color: color??Color(0xfff1f6266),fontFamily: 'Sen',fontSize: 12);
}
TextStyle smallerText ({color}){
  return TextStyle(color: color??Color(0xfff1f6266),fontFamily: 'Sen',fontSize: 10);
}
TextStyle boldText ({color}){
  return TextStyle(color: color??Color(0xfff1f6266),fontFamily: 'Sen',fontSize: 15,fontWeight: FontWeight.bold);
}