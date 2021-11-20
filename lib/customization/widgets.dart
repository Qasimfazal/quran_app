import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/customization/textStyles.dart';

Widget appBar(context, {leading, title, actions,color,centretitl}){
  return AppBar(
    backgroundColor: color??Theme.of(context).backgroundColor,
    elevation: 0,
      title: Text(title??'Al-Quran',style: heading(),),
    centerTitle: centretitl==null?true:false,
    leading:InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Icon( CupertinoIcons.back,color: Theme.of(context).primaryColorDark,)));
}