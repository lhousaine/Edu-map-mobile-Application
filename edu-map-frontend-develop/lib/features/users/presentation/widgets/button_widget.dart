import 'package:EduMap/core/theme/app_theme.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final onPressedFunction;
  final buttonTitle;
  final isActive;
  final isSmall;

  AppButton({
    @required this.onPressedFunction,
    @required this.buttonTitle,
    @required this.isActive,
    @required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Txt(buttonTitle,
        style: getButtonStyle(isActive, isSmall),
        gesture: GestureClass()..onTap(onPressedFunction));
  }

  TxtStyle getButtonStyle(bool isActive, bool isSmall){
    if(isActive){
      if(isSmall){
        return AppThemes.enabledSmallButtonStyle;
      }else{
        return AppThemes.enabledButtonStyle;
      }
    }else{
      if(isSmall){
        return AppThemes.subEnabledSmallButtonStyle;
      }else{
        return AppThemes.subEnabledButtonStyle;
      }
    }
  }
}
