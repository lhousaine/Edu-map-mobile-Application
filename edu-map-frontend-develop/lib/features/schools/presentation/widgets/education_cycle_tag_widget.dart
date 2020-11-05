import 'package:EduMap/core/entities/enums.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class EducationCycleTag extends StatefulWidget {
  final EducationCycleEnum educationCycleEnum;

  EducationCycleTag({this.educationCycleEnum});

  @override
  _EducationCycleTagState createState() => _EducationCycleTagState();
}

class _EducationCycleTagState extends State<EducationCycleTag> {
  @override
  Widget build(BuildContext context) {
    return Parent(
      style: getBackgroundColor(widget.educationCycleEnum.name),
      child: Txt(getDisplayName(widget.educationCycleEnum.name),
          style: TxtStyle()
            ..fontSize(12.0)
            ..padding(all: 6.0)
            ..textColor(Colors.white)
            ..textAlign.center()
            ..fontFamily('Raleway')),
    );
  }

  ParentStyle getBackgroundColor(String name) {
    switch (name) {
      case "college":
        return AppThemes.tagStyle.clone()..background.color(Color.fromARGB(255, 227, 100, 20));
      case "high_school":
        return AppThemes.tagStyle.clone()..background.color(Color.fromARGB(255, 95, 15, 64));
      case "other_cycle":
        return AppThemes.tagStyle.clone()..background.color(Color.fromARGB(255, 15, 76, 92));
      default:
        return AppThemes.tagStyle.clone()..background.color(AppThemes.yellowColor);
    }
  }

  String getDisplayName(String enumStr){
    switch (enumStr){
      case 'college':
        return 'Collège';
      case 'high_school':
        return 'Lycée';
      case 'other_cycle':
        return 'Autres Niveaux';
      default:
        return 'Erreur';
    }
  }
}
