import 'package:EduMap/core/strings/strings.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:division/division.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class RememberMeAndPwdForgottenWidget extends StatefulWidget {
  final bool rememberMe;

  RememberMeAndPwdForgottenWidget({this.rememberMe});

  @override
  _RememberMeAndPwdForgottenWidgetState createState() =>
      _RememberMeAndPwdForgottenWidgetState(rememberMe);
}

class _RememberMeAndPwdForgottenWidgetState
    extends State<RememberMeAndPwdForgottenWidget> {
  bool rememberMe;

  _RememberMeAndPwdForgottenWidgetState(this.rememberMe);

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: AppThemes.pagePaddingStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              InkWell(
                child: !rememberMe
                    ? Icon(
                        EvaIcons.checkmarkCircle2Outline,
                        color: AppThemes.blueColor,
                      )
                    : Icon(
                        EvaIcons.checkmarkCircle2,
                        color: Colors.green,
                      ),
                onTap: () {
                  setState(() {
                    rememberMe = !rememberMe;
                  });
                },
              ),
              Txt(
                AppStrings.REMEMBER_ME,
                style: AppThemes.smallTextStyle.clone()..margin(left: 6.0)..fontSize(12.0)..bold(false),
              ),
            ],
          ),
          InkWell(
            onTap: handleForgottenPassword,
            child: Txt(
              AppStrings.PASSWORD_FORGOTTEN,
              style: AppThemes.smallTextStyle.clone()..margin(left: 6.0)..fontSize(12.0)..bold(false)
                ..textColor(
                  Colors.orange,
                ),
            ),
          ),
        ],
      ),
    );
  }

  void handleForgottenPassword() {}
}
