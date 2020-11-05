import 'dart:async';

import 'package:EduMap/core/network/network_info.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/users/presentation/widgets/remember_me_forgot_pwd_widget.dart';
import 'package:EduMap/features/users/presentation/widgets/login_controls_widget.dart';
import 'package:EduMap/features/users/presentation/widgets/header_widget.dart';
import 'package:EduMap/features/users/presentation/widgets/login_form.dart';
import 'package:division/division.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:EduMap/core/strings/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = true;

  StreamSubscription _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    NetworkInfoImpl connectionStatus = NetworkInfoImpl.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    print("Connection status changed");
    setState(() {
      isOffline = !hasConnection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            EvaIcons.arrowBack,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Parent(
        style: AppThemes.pagePaddingStyle,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              HeaderWidget(
                bigTitle: AppStrings.STAY_CONNECTED,
                smallDescription: AppStrings.LOGIN_TEXT,
              ),
              LoginForm(
                usernameController: usernameController,
                passwordController: passwordController,
              ),
              SizedBox(
                height: 8.0,
              ),
              RememberMeAndPwdForgottenWidget(
                rememberMe: rememberMe,
              ),
              SizedBox(
                height: 24.0,
              ),
              (isOffline)
                  ? buildErrorDisplayWidget('Vous êtes hors connexion!')
                  : LoginControlsWidget(
                      usernameController: usernameController,
                      passwordController: passwordController,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildErrorDisplayWidget(String message) {
    return Txt(
      message,
      style: AppThemes.failureTextStyle.clone()
        ..margin(
          bottom: 12.0,
        ),
    );
  }
}
