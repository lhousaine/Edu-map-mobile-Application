import 'dart:async';

import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/features/schools/presentation/widgets/school_small_card_widget.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:division/division.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final List<School> schools;
  final User user;

  MapPage({this.schools, this.user});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Map<String, double> userLocation = new Map();
  StreamSubscription<Map<String, double>> locationSubscription;
  Location location = new Location();
  String error;
  List<Marker> markers = [];

  @override
  void initState() {
    markers = initMarkersFromSchoolList(widget.schools);
    //Default variable set is Marrakesh coordinate
    userLocation['latitude'] = 31.669746;
    userLocation['longitude'] = -7.973328;
    initPlatformState();
    locationSubscription =
        location.onLocationChanged().listen((Map<String, double> result) {
      userLocation = result;
    });
    super.initState();
  }

  void initPlatformState() async {
    Map<String, double> myLocation;
    try {
      myLocation = await location.getLocation();
      error = "";
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED')
        error = 'PERMISSION DENIED';
      else if (e.code == 'PERMISSION_DENIED_NEVER_ASK')
        error =
            'Permission denied - please enable location for the app to work properly.';
      myLocation = null;
    }
    setState(() {
      userLocation = myLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: <Widget>[
          FlutterMap(
            options: MapOptions(
              center: LatLng(
                userLocation['latitude'],
                userLocation['longitude'],
              ),
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://api.tiles.mapbox.com/v4/"
                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1Ijoic2V0dGFuaTIiLCJhIjoiY2szN3ZhODB2MDAyNTNscDJ6ODl3ZHVsYyJ9.MKt3oitOHYiPYey1WkJ1Rg',
                  'id': 'mapbox.streets',
                },
              ),
              MarkerLayerOptions(
                markers: markers,
              ),
            ],
          ),
          Align(
            child: buildTrendingSchoolsRowList(widget.schools, widget.user),
            alignment: FractionalOffset.bottomCenter,
          ),
        ],
      ),
    );
  }
}

Widget buildTrendingSchoolsRowList(List<School> schools, User user) {
  return Container(
    height: 200,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: schools.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return SmallSchoolCard(
          school: schools[index],
          user: user,
        );
      },
    ),
  );
}

List<Marker> initMarkersFromSchoolList(List<School> schools) {
  List<Marker> markers = [];
  schools.forEach((school) {
    markers.add(
      Marker(
        width: 100.0,
        height: 100.0,
        point: LatLng(
          school.coordinates.latitude,
          school.coordinates.longitude,
        ),
        builder: (context) => Container(
          child: Column(
            children: <Widget>[
              Txt(
                school.name,
                style: AppThemes.smallTextStyle.clone()..fontSize(8.0),
              ),
              IconButton(
                icon: Icon(
                  EvaIcons.pin,
                  color: AppThemes.yellowColor,
                  size: 45.0,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return Container(
                        child: Txt('Nom École : ' + school.name),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  });
  return markers;
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Txt(
      'Carte des Écoles',
      style: TxtStyle()
        ..bold()
        ..fontSize(20.0)
        ..textColor(Colors.white)
        ..fontFamily('Raleway'),
    ),
    leading: Parent(
      style: ParentStyle()..scale(1.5),
      child: InkWell(
        child: Icon(
          EvaIcons.arrowBack,
          color: Colors.white,
        ),
        onTap: (){
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}

class MapPageParams {
  List<School> schools;
  User user;

  MapPageParams({
    this.schools,
    this.user,
  });
}
