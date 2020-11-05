import 'package:EduMap/core/entities/router.dart';
import 'package:EduMap/core/strings/strings.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_school/bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_school/schools_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/city_schools/city_schools_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/city_schools/city_schools_event.dart';
import 'package:EduMap/features/schools/presentation/bloc/trending_schools/bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/trending_schools/trending_schools_bloc.dart';
import 'package:EduMap/features/schools/presentation/pages/home_page.dart';
import 'package:EduMap/features/users/presentation/bloc/user/bloc.dart';
import 'package:EduMap/features/users/presentation/bloc/user/user_bloc.dart';
import 'package:EduMap/features/users/presentation/bloc/user/user_state.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'button_widget.dart';

class LoginControlsWidget extends StatefulWidget {
  final usernameController;
  final passwordController;

  LoginControlsWidget({
    this.usernameController,
    this.passwordController,
  });

  @override
  _LoginControlsWidgetState createState() => _LoginControlsWidgetState();
}

class _LoginControlsWidgetState extends State<LoginControlsWidget> {
  @override
  Widget build(BuildContext context) {
    return Parent(
      style: AppThemes.pagePaddingStyle,
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoadedState) {
            BlocProvider.of<TrendingSchoolsBloc>(context).add(
              GetTrendingSchoolsEvent(),
            );
            BlocProvider.of<SchoolsBloc>(context).add(
              GetSchoolsEvent(),
            );
            BlocProvider.of<CitySchoolsBloc>(context).add(
              GetSchoolsByCityEvent(state.user.address.city),
            );
            Navigator.of(context).pushNamed(
              Router.homeRoute,
              arguments: HomePageParams(user: state.user),
            );
            return Container();
          } else
            return Container();
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserInitialState) {
              return buildInitialWidget();
            } else if (state is UserLoadingState) {
              return buildLoadingWidget();
            } else if (state is UserErrorState) {
              return buildErrorDisplayWidget(state.message);
            } else
              return Container();
          },
        ),
      ),
    );
  }

  Widget buildInitialWidget() {
    return Column(
      children: <Widget>[
        AppButton(
          buttonTitle: AppStrings.LOGIN_BUTTON,
          onPressedFunction: dispatchLoginEvent,
          isActive: true,
          isSmall: false,
        ),
        SizedBox(
          height: 8.0,
        ),
        AppButton(
          buttonTitle: AppStrings.CREATE_ACCOUNT_BUTTON,
          onPressedFunction: dispatchRegisterEvent,
          isActive: false,
          isSmall: false,
        ),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }

  Widget buildLoadingWidget() {
    return Parent(
      style: AppThemes.circularProgressIndicatorStyle,
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorDisplayWidget(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Txt(
          message,
          style: AppThemes.failureTextStyle,
        ),
        SizedBox(
          height: 8.0,
        ),
        AppButton(
          buttonTitle: AppStrings.LOGIN_BUTTON,
          onPressedFunction: dispatchLoginEvent,
          isActive: true,
          isSmall: false,
        ),
        SizedBox(
          height: 8.0,
        ),
        AppButton(
          buttonTitle: AppStrings.CREATE_ACCOUNT_BUTTON,
          onPressedFunction: dispatchRegisterEvent,
          isActive: false,
          isSmall: false,
        ),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }

  void dispatchLoginEvent() {
    if (widget.usernameController.text.isNotEmpty &&
        widget.passwordController.text.isNotEmpty)
      BlocProvider.of<UserBloc>(context).add(
        UserLoginEvent(
          widget.usernameController.text,
          widget.passwordController.text,
        ),
      );
  }

  void dispatchRegisterEvent() {
    Navigator.of(context).pushNamed(Router.registerRoute);
  }
}
