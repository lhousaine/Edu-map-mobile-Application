import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/core/entities/enums.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_comment/comments_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_comment/comments_state.dart';
import 'package:EduMap/features/schools/presentation/bloc/comment/bloc.dart';
import 'package:EduMap/features/schools/presentation/widgets/comment_widget.dart';
import 'package:EduMap/features/schools/presentation/widgets/star_bar_widget.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/features/users/presentation/bloc/user/bloc.dart';
import 'package:EduMap/features/users/presentation/bloc/user/user_bloc.dart';
import 'package:EduMap/features/users/presentation/widgets/button_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  final DetailPageArgs args;

  DetailPage({
    @required this.args,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController commentContentController =
      TextEditingController();
  List<Comment> comments = [];
  double rating = 1.0;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(
      GetCachedUserEvent(),
    );
    return Scaffold(
      appBar: buildAppBar(widget.args.school, context),
      body: Parent(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildHeaderImages(widget.args.school.images),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: buildLevelAndRatingRow(widget.args.school),
              ),
              buildSchoolDescription(widget.args.school.description),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: buildSchoolAddressAndContactColumn(widget.args.school),
              ),
              SizedBox(height: 8.0),
              Parent(
                style: AppThemes.pagePaddingStyle.clone()
                  ..elevation(2.0)
                  ..padding(all: 10.0)
                  ..margin(left: 12.0, right: 12.0)
                  ..borderRadius(all: 8.0)
                  ..background.color(Colors.white),
                child: Column(
                  children: <Widget>[
                    buildCommentTitle(widget.args.school),
                    SizedBox(height: 4.0),
                    initAndBuildAllComments(),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCommentForm() {
    return Parent(
      style: ParentStyle()
        ..margin(top: 8.0, bottom: 20.0)
        ..padding(left: 12.0, right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          StarRating(
            rating: rating,
            size: 35.0,
            onRatingChanged: (rating) => setState(() => this.rating = rating),
          ),
          AppButton(
            buttonTitle: 'Donnez un\nScore',
            isActive: true,
            isSmall: true,
            onPressedFunction: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildCommentDialog(
                    context,
                    'Entrer votre commentaire ( Partagez votre expérience )',
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildHeaderImages(List<dynamic> images) {
    return Parent(
      style: ParentStyle()..elevation(2.0),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        height: 200,
        width: double.infinity,
        imageUrl: images[0],
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget buildLevelAndRatingRow(School school) {
    double width = MediaQuery.of(context).size.width;
    return Parent(
      style: AppThemes.pagePaddingStyle.clone()
        ..width((width / 50) * 100)
        ..elevation(2.0)
        ..padding(all: 10.0)
        ..borderRadius(all: 8.0)
        ..background.color(Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 95.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Txt(
                  'Niveaux ',
                  style: AppThemes.smallTextStyle.clone()
                    ..bold()
                    ..margin(bottom: 6.0)
                    ..fontSize(18.0),
                ),
                buildSchoolCyclesRow(widget.args.school),
              ],
            ),
          ),
          SizedBox(
            width: 80.0,
          ),
          Container(
            height: 95.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Txt(
                  'Score',
                  style: AppThemes.smallTextStyle.clone()
                    ..bold()
                    ..textAlign.left()
                    ..alignmentContent.centerLeft()
                    ..margin(bottom: 6.0)
                    ..fontSize(18.0),
                ),
                Txt(
                  '${widget.args.school.rating}',
                  style: AppThemes.ratingStyle.clone()..fontSize(30.0),
                ),
                StarRating(
                  rating: widget.args.school.rating,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSchoolDescription(String description) {
    return Parent(
      style: ParentStyle()
        ..width(double.infinity)
        ..padding(all: 12.0)
        ..margin(left: 12.0, right: 12.0)
        ..borderRadius(all: 8.0)
        ..background.color(Colors.white)
        ..elevation(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Txt(
            '⚫ Description de l\'école :',
            style: AppThemes.smallTextStyle.clone()
              ..alignmentContent.centerLeft(),
          ),
          SizedBox(
            height: 10.0,
          ),
          Txt(
            description,
            style: AppThemes.smallTextStyle.clone()
              ..bold(false)
              ..fontSize(14.0)
              ..alignmentContent.centerLeft(),
          ),
        ],
      ),
    );
  }

  Widget buildSchoolAddressAndContactColumn(School school) {
    double width = MediaQuery.of(context).size.width;
    return Parent(
      style: AppThemes.pagePaddingStyle.clone()
        ..width((width / 50) * 100)
        ..elevation(2.0)
        ..padding(all: 10.0)
        ..borderRadius(all: 8.0)
        ..background.color(Colors.white),
      child: Row(
        children: <Widget>[
          Container(
            height: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Txt(
                  'Address ',
                  style: AppThemes.smallTextStyle.clone()
                    ..bold()
                    ..margin(bottom: 6.0)
                    ..fontSize(18.0),
                ),
                buildAddressColumn(widget.args.school),
              ],
            ),
          ),
          SizedBox(
            width: 50.0,
          ),
          Container(
            height: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Txt(
                  'Contact',
                  style: AppThemes.smallTextStyle.clone()
                    ..bold()
                    ..textAlign.left()
                    ..alignmentContent.centerLeft()
                    ..margin(bottom: 6.0)
                    ..fontSize(18.0),
                ),
                buildContactColumn(widget.args.school),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCommentTitle(School school) {
    String titleEmoji = getTitleEmoji(school.rating);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Txt(
          '$titleEmoji Commentaires :',
          style: AppThemes.smallTextStyle.clone()
            ..alignmentContent.centerLeft(),
        ),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }

  Widget buildCommentDialog(BuildContext context, String hint) {
    return AlertDialog(
      title: Text('Partagez avec nous votre expérience 😊:'),
      content: TextField(
        controller: commentContentController,
        decoration: InputDecoration(hintText: hint),
      ),
      actions: <Widget>[
        RaisedButton(
          color: AppThemes.yellowColor,
          child: new Text(
            'Ajouter Le Score!',
            style: TextStyle(
                fontFamily: 'Ralway',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            BlocProvider.of<CommentBloc>(context).add(
              AddCommentEvent(
                comment: Comment(
                    idSchool: widget.args.school.id,
                    content: commentContentController.text,
                    rating: rating,
                    createdAt: DateTime.now().toString(),
                    owner: widget.args.user.username),
              ),
            );
            Navigator.of(context).pop();
          },
        ),
        RaisedButton(
          child: new Text(
            'Annuler',
            style: TextStyle(
              fontFamily: 'Ralway',
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  BlocBuilder<CommentsBloc, CommentsState> initAndBuildAllComments() {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state is CommentsLoadingState) {
          return buildLoadingWidget();
        } else if (state is CommentsLoadedState) {
          comments = state.comments;
          return buildCommentsColumn(state.comments);
        } else if (state is CommentsErrorState) {
          return buildErrorDisplayWidget(state.message);
        } else
          return Container();
      },
    );
  }

  Widget buildCommentsColumn(List<Comment> comments) {
    List<Widget> commentsWidgets = [];
    comments.forEach((comment) {
      commentsWidgets.add(
        CommentWidget(
          idSchool: widget.args.school.id,
          comment: comment,
          user: widget.args.user,
        ),
      );
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        !userAlreadyRated() ? buildCommentForm() : Container(),
        Divider(),
        SizedBox(height: 4.0),
        ...commentsWidgets
      ],
    );
  }

  Widget buildSchoolCyclesRow(School school) {
    List<EducationCycleEnum> cycles = school.educationCycles;
    List<Widget> cyclesWidgets = [];
    cycles.forEach((cycle) {
      cyclesWidgets.add(
        Parent(
          style: ParentStyle()..margin(bottom: 6.0),
          child: Row(
            children: <Widget>[
              Icon(
                EvaIcons.arrowRight,
                size: 16.0,
              ),
              Txt(
                upperCaseFirstLetter(
                    getCycleDisplayName(cycle.name.toString())),
                style: TxtStyle()
                  ..textColor(AppThemes.blueColor)
                  ..fontFamily('Raleway')
                  ..fontSize(16.0),
              ),
            ],
          ),
        ),
      );
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ...cyclesWidgets,
      ],
    );
  }

  bool userAlreadyRated() {
    comments.forEach((comment) {
      if (comment.owner == widget.args.user.username) return true;
    });
    return false;
  }
}

Widget buildErrorDisplayWidget(String message) {
  return Txt(
    message,
    style: AppThemes.failureTextStyle,
  );
}

Widget buildLoadingWidget() {
  return Parent(
    style: AppThemes.circularProgressIndicatorStyle.clone()..alignment.center(),
    child: CircularProgressIndicator(),
  );
}

Widget buildAddressColumn(School school) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '🏠 Address : \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
          TextSpan(
            text: '${school.address.addressLine}',
            style: TextStyle(
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 8.0,
      ),
      RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '📋 Zip code : ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
          TextSpan(
            text: '${school.address.zipCode}',
            style: TextStyle(
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 8.0,
      ),
      RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '🏙️ Ville : ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
          TextSpan(
            text: upperCaseFirstLetter(school.address.city),
            style: TextStyle(
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 8.0,
      ),
      RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '🌍 Pays : ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
          TextSpan(
            text: '${school.address.country}',
            style: TextStyle(
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
        ]),
      ),
    ],
  );
}

Widget buildContactColumn(School school) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '🌐 Site web : \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
          TextSpan(
            text: '${school.contact.website}',
            style: TextStyle(
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 8.0,
      ),
      RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '📧 Email : \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
          TextSpan(
            text: '${school.contact.email}',
            style: TextStyle(
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 8.0,
      ),
      RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '☎️ Phone : \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
          TextSpan(
            text: upperCaseFirstLetter(school.contact.phone),
            style: TextStyle(
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 8.0,
      ),
      RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'Facebook : \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
          TextSpan(
            text: '${school.contact.facebook}',
            style: TextStyle(
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 8.0,
      ),
      RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'Youtube : \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
          TextSpan(
            text: '${school.contact.youtube}',
            style: TextStyle(
              fontFamily: 'Raleway',
              color: AppThemes.blueColor,
              fontSize: 12.0,
            ),
          ),
        ]),
      ),
    ],
  );
}

AppBar buildAppBar(School school, BuildContext context,) {
  return AppBar(
    title: Txt(
      upperCaseFirstLetter(school.name),
      style: TxtStyle()
        ..bold()
        ..fontSize(20.0)
        ..textColor(Colors.white)
        ..fontFamily('Raleway'),
    ),
    leading: Parent(
      style: ParentStyle()..scale(1.5),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Icon(
          EvaIcons.arrowBack,
          color: Colors.white,
        ),
      ),
    ),
  );
}

String getCycleDisplayName(String str) {
  switch (str) {
    case 'college':
      return 'Collège';
    case 'high_school':
      return 'Lycée';
    case 'other_cycles':
      return 'Autres niveaux';
    default:
      return 'Autres niveaux';
  }
}

String upperCaseFirstLetter(String str) {
  return str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase();
}

String getTitleEmoji(double rating) {
  if (rating >= 0 && rating <= 2)
    return '😑';
  else if (rating > 2 && rating <= 3.5)
    return '😄';
  else
    return '😍';
}

class DetailPageArgs {
  final School school;
  final User user;

  DetailPageArgs({this.school, this.user});
}
