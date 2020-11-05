import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_comment_replay/all_comment_replay_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_comment_replay/all_comment_replay_state.dart';
import 'package:EduMap/features/schools/presentation/widgets/comment_widget.dart';
import 'package:EduMap/features/schools/presentation/widgets/replay_widget.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:division/division.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplayPage extends StatefulWidget {
  final Comment comment;
  final User user;
  final String idSchool;

  ReplayPage({
    @required this.comment,
    @required this.user,
    @required this.idSchool,
  });

  @override
  _ReplayPageState createState() => _ReplayPageState();
}

class _ReplayPageState extends State<ReplayPage> {
  final TextEditingController replayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Parent(
          style: AppThemes.pagePaddingStyle,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 18.0,
              ),
              getCommentForm(),
              BlocBuilder<CommentRepliesBloc, AllCommentReplayState>(
                builder: (context, state) {
                  if (state is AllCommentReplayLoadingState) {
                    return buildLoadingWidget();
                  } else if (state is AllCommentReplayLoadedState) {
                    return getRepliesColumn(state.commentReplies);
                  } else if (state is AllCommentReplayErrorState) {
                    return buildErrorDisplayWidget(state.message);
                  } else
                    return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCommentForm() {
    return CommentWidget(
      comment: widget.comment,
      user: widget.user,
      idSchool: widget.idSchool,
    );
  }

  Widget getRepliesColumn(List<ReplayComment> replies) {
    List<Widget> replayWidgets = [];
    replies.forEach((replay) {
      replayWidgets.add(
        ReplayWidget(
          replayComment: replay,
        ),
      );
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: replayWidgets,
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

AppBar buildAppBar() {
  return AppBar(
    title: Txt(
      'Les Réponces',
      style: TxtStyle()
        ..bold()
        ..fontSize(20.0)
        ..textColor(Colors.white)
        ..fontFamily('Raleway'),
    ),
    leading: Parent(
      style: ParentStyle()..scale(1.5),
      child: Icon(
        EvaIcons.arrowBack,
        color: Colors.white,
      ),
    ),
  );
}

class ReplayPageParams {
  Comment comment;
  String idSchool;
  User user;

  ReplayPageParams({
    this.comment,
    this.idSchool,
    this.user,
  });
}
