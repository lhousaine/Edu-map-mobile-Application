import 'dart:convert';

import 'package:EduMap/core/entities/router.dart';
import 'package:EduMap/core/strings/strings.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_school/schools_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_school/schools_event.dart';
import 'package:EduMap/features/schools/presentation/bloc/city_schools/city_schools_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/city_schools/city_schools_event.dart';
import 'package:EduMap/features/schools/presentation/bloc/trending_schools/trending_schools_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/trending_schools/trending_schools_event.dart';
import 'package:EduMap/features/schools/presentation/pages/home_page.dart';
import 'package:EduMap/features/users/data/datasources/user_local_datasource.dart';
import 'package:EduMap/features/users/data/models/user_model.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/features/users/presentation/widgets/button_widget.dart';
import 'package:division/division.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(),
        elevation: 0.0,
        actions: <Widget>[
          Parent(
            child: Icon(EvaIcons.close),
            style: AppThemes.iconStyle.clone()..ripple(true),
            gesture: GestureClass()
              ..onTap(
                () {},
              ),
          ),
        ],
      ),
      body: Parent(
        style: ParentStyle()
          ..margin(
              vertical: AppThemes.verticalMargin,
              horizontal: AppThemes.horizontalMargin)
          ..minWidth(
            MediaQuery.of(context).size.width -
                (2 * AppThemes.horizontalMargin),
          )
          ..minHeight(
            MediaQuery.of(context).size.height - (2 * AppThemes.verticalMargin),
          ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Parent(
                style: AppThemes.mediumImageStyle.clone(),
                child: Image.asset("assets/img/request_pic.png"),
              ),
              Parent(
                style: AppThemes.mediumImageStyle.clone(),
                child: Image.asset("assets/img/educationMapTitle.PNG"),
              ),
              Txt(
                AppStrings.REQUEST_TEXT,
                style: AppThemes.smallTextStyle.clone()
                  ..width(300)
                  ..margin(
                    bottom: 8.0,
                    top: 8.0,
                  ),
              ),
              Txt(
                AppStrings.REQUEST_FREE_TITLE,
                style: AppThemes.mediumTextStyle.clone()
                  ..width(300)
                  ..bold()
                  ..margin(bottom: 16.0),
              ),
              ...requestControls()
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> requestControls() {
    return [
      AppButton(
        buttonTitle: AppStrings.LOGIN_BUTTON,
        onPressedFunction: handleLoginButton,
        isActive: true,
        isSmall: false,
      ),
      SizedBox(
        height: 12.0,
      ),
      AppButton(
        buttonTitle: AppStrings.CREATE_ACCOUNT_BUTTON,
        onPressedFunction: handleCreateAccountButton,
        isActive: false,
        isSmall: false,
      )
    ];
  }

  Future<void> handleLoginButton() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userJson = sharedPreferences.get(CACHED_USER);
    if (userJson != null) {
      BlocProvider.of<TrendingSchoolsBloc>(context).add(
        GetTrendingSchoolsEvent(),
      );
      BlocProvider.of<SchoolsBloc>(context).add(
        GetSchoolsEvent(),
      );
      User user = UserModel.fromJson(json.decode(userJson));
      BlocProvider.of<CitySchoolsBloc>(context).add(
        GetSchoolsByCityEvent(user.address.city),
      );
      return Navigator.pushNamed(
        context,
        Router.homeRoute,
        arguments: HomePageParams(user: user),
      );
    } else
      return Navigator.pushNamed(
        context,
        Router.loginRoute,
      );
  }

  bool userAlreadyLoggedIn() {}

  User getUserFromCache() {}

  void handleCreateAccountButton() => Navigator.pushNamed(
        context,
        Router.registerRoute,
      );
}
