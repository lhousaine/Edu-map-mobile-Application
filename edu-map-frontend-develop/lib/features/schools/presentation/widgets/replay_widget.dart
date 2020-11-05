import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/schools/presentation/bloc/comment_replay/bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/comment_replay/comment_replay_bloc.dart';
import 'package:EduMap/features/schools/presentation/widgets/star_bar_widget.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplayWidget extends StatefulWidget {
  final ReplayComment replayComment;

  ReplayWidget({
    @required this.replayComment,
  });

  @override
  _ReplayWidgetState createState() => _ReplayWidgetState();
}

class _ReplayWidgetState extends State<ReplayWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: AppThemes.pagePaddingStyle.clone(),
      child: Column(
        children: <Widget>[
          getCommentAvatar(widget.replayComment.owner),
          getCommentContent(widget.replayComment.content),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget getCommentAvatar(String owner) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Colors.orange,
                Colors.deepOrange,
              ])),
          child: CircleAvatar(
            radius: 30,
            child: Text(
              owner.substring(0, 1).toUpperCase(),
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getCommentContent(String content) {
    return Parent(
      style: ParentStyle()
        ..padding(all: 8.0)
        ..alignmentContent.centerLeft()
        ..margin(top: 12.0, bottom: 6.0),
      child: AutoSizeText(
        content,
        style: TextStyle(
          fontSize: 12.0,
          fontFamily: 'Raleway',
          color: AppThemes.blueColor,
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: AppThemes.blueColor,
    );
  }
}
