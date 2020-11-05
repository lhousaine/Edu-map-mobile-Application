import 'package:EduMap/core/theme/app_theme.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String bigTitle;
  final String smallDescription;

  HeaderWidget({this.bigTitle, this.smallDescription});

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: AppThemes.pagePaddingStyle,
      child: Column(
        children: <Widget>[
          Parent(
            style: AppThemes.smallImageStyle
            ..margin(bottom: 24.0),
            child: Image.asset("assets/img/logo.png"),
          ),
          Txt(
            bigTitle,
            style: AppThemes.largeTextStyle.clone()
            ..fontSize(24.0)
            ..textAlign.start()
            ..width(double.infinity)
            ..bold(),
          ),
          SizedBox(
            height: 8.0,
          ),
          Txt(
            smallDescription,
            style: AppThemes.smallTextStyle.clone()
              ..fontSize(12.0)
              ..textAlign.start()
              ..width(double.infinity),
          ),
        ],
      ),
    );
  }
}
