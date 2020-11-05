import 'package:EduMap/core/strings/strings.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/core/utils/input_validator.dart';
import 'package:EduMap/core/widgets/text_input.dart';
import 'package:division/division.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final usernameController;
  final passwordController;

  LoginForm({
    this.usernameController,
    this.passwordController,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: AppThemes.pagePaddingStyle,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormInput(
              hint: AppStrings.USERNAME_HINT,
              icon: EvaIcons.person,
              controller: widget.usernameController,
              validator: (value) => InputValidator.validateUsername(value),
            ),
            TextFormInputPassword(
              hint: AppStrings.PASSWORD_HINT,
              icon: EvaIcons.unlock,
              controller: widget.passwordController,
              validator: (value) => InputValidator.validatePassword(value),
            ),
          ],
        ),
      ),
    );
  }
}
