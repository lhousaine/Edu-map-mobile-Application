import 'dart:async';

import 'package:EduMap/core/entities/router.dart';
import 'package:EduMap/core/network/network_info.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_school/bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/city_schools/city_schools_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/city_schools/city_schools_state.dart';
import 'package:EduMap/features/schools/presentation/bloc/trending_schools/bloc.dart';
import 'package:EduMap/features/schools/presentation/pages/map_page.dart';
import 'package:EduMap/features/schools/presentation/widgets/oval_right_border_clipper.dart';
import 'package:EduMap/features/schools/presentation/widgets/school_card_widget.dart';
import 'package:EduMap/features/schools/presentation/widgets/school_small_card_widget.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/users/presentation/bloc/user/user_bloc.dart';
import 'package:EduMap/features/users/presentation/bloc/user/user_event.dart';
import 'package:EduMap/features/users/presentation/pages/login_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String morningHeaderMessage = "Bonjour, ";
const String afternoonHeaderMessage = "Bonsoir, ";

class HomeScreen extends StatefulWidget {
  final HomePageParams args;

  HomeScreen({
    this.args,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<School> trendingSchools = [];
  List<School> citySchools = [];
  List<School> allSchools = [];

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
    final HomePageParams args = widget.args;
    return Scaffold(
      body: _buildMainContent(args),
    );
  }

  _buildMainContent(HomePageParams args) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Parent(
          style: AppThemes.pagePaddingStyle,
          child: CustomScrollView(
            slivers: <Widget>[
              buildAppBar(args, context),
              SliverList(
                delegate: SliverChildListDelegate([
                  (!isOffline)
                      ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TitleHeader(icon: '🔥', title: 'Trending'),
                              initBlocTrendingSchools(),
                              getSpacerWidget(),
                              TitleHeader(
                                  icon: '😍',
                                  title: 'Ville - ' +
                                      upperCaseFirstLetter(
                                          args.user.address.city)),
                              initBlocCitySchools(),
                              getSpacerWidget(),
                              TitleHeader(icon: '🌍', title: 'Découvrir'),
                              initBlocDiscoverSchools(),
                              getSpacerWidget(),
                              buildFooterWidget(),
                            ],
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/img/offline.png',
                              width: 400,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            buildErrorDisplayWidget(
                                'Vous êtes hors connexion!'),
                          ],
                        ),
                ]),
              ),
            ],
          ),
        ),
        drawer: buildDrawer(),
      ),
    );
  }

  buildDrawer() {
    String womenPictureUrl = "https://i.ibb.co/98yjjvC/wprofile.jpg";
    String menPictureUrl = "https://i.ibb.co/Fq7mthx/profile.jpg";
    String testPictureUrl = "https://i.ibb.co/JtrRxqV/profile.jpg";
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black45)],
          ),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        BlocProvider.of<UserBloc>(context).add(
                          UserLogoutEvent(),
                        );
                        BlocProvider.of<UserBloc>(context).add(
                          UserInitEvent(),
                        );
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            ModalRoute.withName("/login"));
                      },
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          Colors.orange,
                          Colors.deepOrange,
                        ])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: CachedNetworkImageProvider(
                        widget.args.user.username == 'ouarhou'
                            ? menPictureUrl
                            : womenPictureUrl,
                      ),
                    ),
                  ),
                  Container(
                    child: Txt(
                      upperCaseFirstLetter(widget.args.user.lastName) +
                          ' ' +
                          upperCaseFirstLetter(widget.args.user.firstName),
                      style: AppThemes.smallTextStyle
                        ..fontSize(18.0)
                        ..margin(top: 6.0)
                        ..textColor(AppThemes.blueColor)
                        ..bold(),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _buildRow(
                    Icons.home,
                    "Acceuil",
                    () {
                      Navigator.of(context).pop();
                    },
                  ),
                  _buildDivider(),
                  _buildRow(Icons.person_pin, "Mon Profile", () {
                    Navigator.of(context).pushNamed(
                      Router.profileRoute,
                      arguments: widget.args.user,
                    );
                  }),
                  _buildDivider(),
                  _buildRow(
                    Icons.map,
                    "La Carte",
                    () {
                      Navigator.of(context).pushNamed(Router.mapRoute,
                          arguments: MapPageParams(
                            schools: allSchools,
                            user: widget.args.user,
                          ));
                    },
                  ),
                  _buildDivider(),
                  _buildRow(
                    Icons.email,
                    "Contactez nous",
                    () {
                      Navigator.of(context).pushNamed(Router.contactRoute);
                    },
                  ),
                  _buildDivider(),
                  _buildRow(
                    Icons.info_outline,
                    "Á Propos",
                    () {
                      Navigator.of(context).pushNamed(Router.aboutRoute);
                    },
                  ),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() => Divider(
        color: AppThemes.blueColor,
      );

  Widget _buildRow(IconData icon, String title, Function handleOnClick,
      {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(
        color: AppThemes.blueColor, fontSize: 16.0, fontFamily: 'Raleway');
    return Parent(
      style: ParentStyle()..ripple(true),
      child: InkWell(
        onTap: () => handleOnClick(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(children: [
            Icon(
              icon,
              color: AppThemes.blueColor,
            ),
            SizedBox(width: 10.0),
            Text(
              title,
              style: tStyle,
            ),
            Spacer(),
            if (showBadge)
              Material(
                color: Colors.black,
                elevation: 5.0,
                shadowColor: Colors.red,
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    "10+",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
          ]),
        ),
      ),
    );
  }

  SizedBox getSpacerWidget() => SizedBox(height: 40.0);

  BlocBuilder<SchoolsBloc, SchoolsState> initBlocDiscoverSchools() {
    return BlocBuilder<SchoolsBloc, SchoolsState>(
      builder: (context, state) {
        if (state is SchoolsLoadingState) {
          return buildLoadingWidget();
        } else if (state is SchoolsLoadedState) {
          allSchools = state.schools;
          return buildSchoolsColumn(allSchools);
        } else if (state is SchoolsErrorState) {
          return buildErrorDisplayWidget(state.message);
        } else
          return Container();
      },
    );
  }

  BlocBuilder<CitySchoolsBloc, CitySchoolsState> initBlocCitySchools() {
    return BlocBuilder<CitySchoolsBloc, CitySchoolsState>(
      builder: (context, state) {
        if (state is CitySchoolsLoadingState) {
          return buildLoadingWidget();
        } else if (state is CitySchoolsLoadedState) {
          citySchools = state.schools;
          return buildSchoolsColumn(citySchools);
        } else if (state is CitySchoolsErrorState) {
          return buildErrorDisplayWidget(state.message);
        } else
          return Container();
      },
    );
  }

  BlocBuilder<TrendingSchoolsBloc, TrendingSchoolsState>
      initBlocTrendingSchools() {
    return BlocBuilder<TrendingSchoolsBloc, TrendingSchoolsState>(
      builder: (context, state) {
        if (state is TrendingSchoolsLoadingState) {
          return buildLoadingWidget();
        } else if (state is TrendingSchoolsLoadedState) {
          trendingSchools = state.schools;
          return buildTrendingSchoolsRowList(state.schools);
        } else if (state is TrendingSchoolsErrorState) {
          return buildErrorDisplayWidget(state.message);
        } else
          return Container();
      },
    );
  }

  Widget buildTrendingSchoolsRowList(List<School> schools) {
    return Container(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: schools.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SmallSchoolCard(
            school: schools[index],
            user: widget.args.user,
          );
        },
      ),
    );
  }

  List<Widget> buildSchoolsWidgetList(List<School> schools) {
    List<Widget> resultList = [];
    schools.forEach((school) {
      resultList.add(SchoolCard(
        school: school,
        user: widget.args.user,
      ));
    });
    return resultList;
  }

  Widget buildSchoolsColumn(List<School> schools) {
    List<Widget> schoolsWidget = buildSchoolsWidgetList(schools);
    return Column(
      children: <Widget>[
        ...schoolsWidget,
      ],
    );
  }

  gotoSpecifiedPathWithArgs(String path, RouteSettings argumentClass) {
    Navigator.of(context).pushNamed(
      path,
      arguments: argumentClass,
    );
  }
}

Widget buildErrorDisplayWidget(String message) {
  return Txt(
    message,
    style: AppThemes.failureTextStyle,
  );
}

SliverAppBar buildAppBar(HomePageParams args, BuildContext context) {
  return SliverAppBar(
    expandedHeight: 150.0,
    floating: false,
    pinned: true,
    backgroundColor: Colors.white,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: getHeaderMessage(),
                style: TextStyle(
                  color: AppThemes.blueColor,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                )),
            TextSpan(
                text: upperCaseFirstLetter(args.user.username),
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: AppThemes.yellowColor,
                  fontSize: 20.0,
                )),
          ],
        ),
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          EvaIcons.logOut,
          size: 30.0,
        ),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Confirmation"),
                content: new Text("Voulez vous se déconnecter ?"),
                actions: <Widget>[
                  FlatButton(
                    child: new Text("Oui"),
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context).add(
                        UserLogoutEvent(),
                      );
                      BlocProvider.of<UserBloc>(context).add(
                        UserInitEvent(),
                      );
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          ModalRoute.withName("/login"));
                    },
                  ),
                  FlatButton(
                    child: new Text("Non"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      )
    ],
  );
}

String upperCaseFirstLetter(String str) {
  return str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase();
}

Widget buildLoadingWidget() {
  return Parent(
    style: AppThemes.circularProgressIndicatorStyle.clone()..alignment.center(),
    child: CircularProgressIndicator(),
  );
}

String getHeaderMessage() {
  var nowTime = DateTime.now();
  var hour = nowTime.hour;
  if (hour <= 12)
    return morningHeaderMessage;
  else if (hour > 12)
    return afternoonHeaderMessage;
  else
    return afternoonHeaderMessage;
}

Widget buildFooterWidget() {
  return Txt(
    'Made With ❤️, 2019',
    style: AppThemes.smallTextStyle.clone()
      ..fontSize(12.0)
      ..margin(all: 12.0),
  );
}

class TitleHeader extends StatelessWidget {
  final String icon;
  final String title;

  TitleHeader({
    this.icon,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: AppThemes.pagePaddingStyle.clone()
        ..margin(
          top: 16.0,
          bottom: 8.0,
        ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$icon ',
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            TextSpan(
              text: '$title :',
              style: TextStyle(
                fontSize: 26.0,
                fontFamily: 'Raleway',
                color: AppThemes.blueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageParams {
  final User user;

  HomePageParams({this.user});
}
