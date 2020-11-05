import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/core/entities/router.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_comment_replay/all_comment_replay_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_comment_replay/all_comment_replay_event.dart';
import 'package:EduMap/features/schools/presentation/bloc/comment_replay/bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/comment_replay/comment_replay_bloc.dart';
import 'package:EduMap/features/schools/presentation/pages/replay_page.dart';
import 'package:EduMap/features/schools/presentation/widgets/star_bar_widget.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  final String idSchool;
  final User user;

  CommentWidget({
    @required this.comment,
    @required this.idSchool,
    @required this.user,
  });

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final TextEditingController replayController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        getCommentAvatar(widget.comment),
        getCommentContent(widget.comment.content),
        getReplayForm(),
        getCommentFooter(widget.comment),
        _buildDivider(),
      ],
    );
  }

  Widget getCommentAvatar(Comment comment) {
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
              comment.owner.substring(0, 1).toUpperCase(),
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 26.0,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Container(
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Txt(
                  comment.owner.substring(0, 1).toUpperCase() +
                      comment.owner.substring(1),
                  style: AppThemes.smallBoldTextStyle.clone()..fontSize(16.0),
                ),
                Txt(
                  'Ajouté le : ' + comment.createdAt,
                  style: TxtStyle()
                    ..fontSize(10.0)
                    ..fontFamily('Raleway')
                    ..italic(),
                ),
                StarRating(
                  rating: comment.rating,
                  size: 12.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getCommentContent(String content) {
    return Parent(
      style: ParentStyle()
        ..padding(all: 12.0)
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

  Widget getReplayForm() {
    return Parent(
      style: ParentStyle()
        ..padding(left: 12.0, right: 12.0)
        ..height(50.0)
        ..margin(left: 12.0, right: 12.0)
        ..borderRadius(all: 20.0)
        ..border(all: 0.5),
      child: TextField(
        controller: replayController,
        decoration: InputDecoration(
          hintText: 'Répondez ici ..',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget getCommentFooter(Comment comment) {
    int totalReplies = comment.totalReplies;
    return Parent(
      style: ParentStyle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            child: Txt(
              '$totalReplies Réponses ' +
                  (totalReplies != 0 ? '(voir tous)' : ''),
              style: TxtStyle()
                ..fontFamily('Ralway')
                ..bold()
                ..textColor(Colors.blueAccent)
                ..fontSize(12.0)
                ..textColor(AppThemes.blueColor),
            ),
            onPressed: () {
              BlocProvider.of<CommentRepliesBloc>(context)
                  .add(GetAllCommentRepliesEvent(comment: comment));
              Navigator.of(context).pushNamed(Router.replayRoute,
                  arguments: ReplayPageParams(
                    comment: comment,
                    user: widget.user,
                    idSchool: widget.idSchool,
                  ));
            },
          ),
          initAndBuildUser(comment),
        ],
      ),
    );
  }

  BlocBuilder<CommentReplayBloc, CommentReplayState> initAndBuildUser(
      Comment comment) {
    return BlocBuilder<CommentReplayBloc, CommentReplayState>(
      builder: (context, state) {
        if (state is CommentReplayInitialState) {
          return getReplayButton(comment);
        } else if (state is CommentReplayLoadingState) {
          return buildLoadingWidget();
        } else if (state is CommentReplayLoadedState) {
          return getReplayButton(comment);
        } else if (state is CommentReplayErrorState) {
          return buildErrorDisplayWidget(state.message);
        } else
          return Container();
      },
    );
  }

  getReplayButton(Comment comment) {
    return FlatButton(
      child: Txt(
        'Répondre',
        style: TxtStyle()
          ..bold()
          ..border(all: 0.5)
          ..padding(all: 8.0)
          ..borderRadius(all: 16.0),
      ),
      onPressed: () {
        BlocProvider.of<CommentReplayBloc>(context).add(AddCommentReplayEvent(
          schoolId: widget.idSchool,
          replayComment: ReplayComment(
            idComment: widget.comment.idComment,
            content: replayController.text,
            createdAt: DateTime.now().toString(),
            owner: widget.user.username,
          ),
        ));
        replayController.clear();
        setState(() {
          comment.totalReplies++;
        });
      },
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: AppThemes.blueColor,
    );
  }

  Widget buildErrorDisplayWidget(String message) {
    return Txt(
      message,
      style: AppThemes.failureTextStyle,
    );
  }

  Widget buildLoadingWidget() {
    return Parent(
      style: AppThemes.circularProgressIndicatorStyle.clone()
        ..alignment.center(),
      child: CircularProgressIndicator(),
    );
  }
}
