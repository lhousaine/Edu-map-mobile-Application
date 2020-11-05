import 'dart:io';

import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage({@required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String womenPictureUrl = "https://i.ibb.co/98yjjvC/wprofile.jpg";
  String menPictureUrl = "https://i.ibb.co/Fq7mthx/profile.jpg";
  String testPictureUrl = "https://i.ibb.co/JtrRxqV/profile.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppThemes.yellowColor,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 330,
                    color: AppThemes.blueColor,
                  ),
                  Positioned(
                    top: 10,
                    right: 30,
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Container(
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
                              widget.user.username == 'ouarhou'
                                  ? menPictureUrl
                                  : womenPictureUrl,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                      ),
                      Text(
                        widget.user.firstName +
                            " " +
                            widget.user.lastName.toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                      ),
                      Text(
                        widget.user.educationLevel.name +
                            ", " +
                            widget.user.speciality.name,
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      UserInfo(user: widget.user),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class UserInfo extends StatelessWidget {
  final User user;

  UserInfo({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Vos Informations :",
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Divider(
                    color: Colors.black38,
                  ),
                  Container(
                      child: Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        leading: Icon(Icons.my_location),
                        title: Text("Ville/Pays"),
                        subtitle: Text(
                          user.address.city + ", " + user.address.country,
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text("Email"),
                        subtitle: Text(user.email,
                            style: TextStyle(fontFamily: 'Raleway')),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text("Téléphone"),
                        subtitle: Text(user.phone,
                            style: TextStyle(fontFamily: 'Raleway')),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          "Date de naissance",
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: Text(user.birthday),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
