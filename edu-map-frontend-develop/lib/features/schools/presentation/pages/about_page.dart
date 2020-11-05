import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/users/presentation/widgets/header_widget.dart';
import 'package:division/division.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Parent(
        style: AppThemes.pagePaddingStyle.clone(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            HeaderWidget(
              bigTitle: "Pour un Futur Brillant,",
              smallDescription:
                  "Education Map est une application multiplatforme dédié aux étudiant et au parent voulant choisir et intégré une école! Certainement nous avons tous poser cette question \"Est ce que que cette école est bonne pour moi ( mon enfant )?\" alors la réponce c'est education map!",
            ),
            SizedBox(
              height: 8.0,
            ),
            Txt(
              'Made with 💖 2020-2019\n⚪ Settani Abderrahman\n⚪ Lhoussaine Ouarhou\n⚪ Farid Youssef',
              style: AppThemes.smallTextStyle.clone()
                ..fontSize(12.0)
                ..textAlign.left()
                ..alignmentContent.centerLeft()
                ..padding(left: 12.0, right: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar(
  BuildContext context,
) {
  return AppBar(
    title: Txt(
      'Á Propos l\'Application',
      style: TxtStyle()
        ..bold()
        ..fontSize(20.0)
        ..textColor(Colors.white)
        ..fontFamily('Raleway'),
    ),
    leading: Parent(
      style: ParentStyle()..scale(1.5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          EvaIcons.arrowBack,
          color: Colors.white,
        ),
      ),
    ),
  );
}
