import 'dart:async';

import 'package:EduMap/core/entities/router.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_comment/bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_school/bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/comment/bloc.dart';
import 'package:EduMap/features/users/presentation/bloc/user/bloc.dart';
import 'package:division/division.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:EduMap/core/strings/strings.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'features/schools/presentation/bloc/all_comment_replay/all_comment_replay_bloc.dart';
import 'features/schools/presentation/bloc/city_schools/city_schools_bloc.dart';
import 'features/schools/presentation/bloc/comment_replay/comment_replay_bloc.dart';
import 'features/schools/presentation/bloc/single_school/school_bloc.dart';
import 'features/schools/presentation/bloc/trending_schools/trending_schools_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(AppThemes.darkBlueColor);
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          builder: (BuildContext context) => sl<UserBloc>(),
        ),
        BlocProvider<SchoolBloc>(
          builder: (BuildContext context) => sl<SchoolBloc>(),
        ),
        BlocProvider<SchoolsBloc>(
          builder: (BuildContext context) => sl<SchoolsBloc>(),
        ),
        BlocProvider<TrendingSchoolsBloc>(
          builder: (BuildContext context) => sl<TrendingSchoolsBloc>(),
        ),
        BlocProvider<CitySchoolsBloc>(
          builder: (BuildContext context) => sl<CitySchoolsBloc>(),
        ),
        BlocProvider<CommentsBloc>(
          builder: (BuildContext context) => sl<CommentsBloc>(),
        ),
        BlocProvider<CommentBloc>(
          builder: (BuildContext context) => sl<CommentBloc>(),
        ),
        BlocProvider<CommentReplayBloc>(
          builder: (BuildContext context) => sl<CommentReplayBloc>(),
        ),
        BlocProvider<CommentRepliesBloc>(
          builder: (BuildContext context) => sl<CommentRepliesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'EDU MAP',
        theme: AppThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Router.generateRoute,
        initialRoute: '/splash',
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  static const SPLASH_SCREEN_TIME = 2000;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Parent(
        style: AppThemes.centerAll.clone(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Parent(
              style: AppThemes.smallImageStyle.clone(),
              child: Image.asset(
                "assets/img/logo.png",
              ),
            ),
            Parent(
              style: AppThemes.smallImageStyle.clone(),
              child: Image.asset(
                "assets/img/eduMapTitle.PNG",
              ),
            ),
            Parent(
              child: Txt(
                AppStrings.SPLASH_TITLE,
                style: AppThemes.smallTextStyle.clone(),
              ),
            ),
            Parent(
              style: AppThemes.circularProgressIndicatorStyle.clone(),
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Timer> loadData() async {
    return new Timer(
      Duration(milliseconds: SplashScreen.SPLASH_SCREEN_TIME),
      onDoneLoading,
    );
  }

  onDoneLoading() async {
    Navigator.of(context).pushNamed('/request');
  }
}
