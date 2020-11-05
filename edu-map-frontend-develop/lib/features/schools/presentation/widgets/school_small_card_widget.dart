import 'package:EduMap/core/entities/enums.dart';
import 'package:EduMap/core/entities/router.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_comment/comments_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_comment/comments_event.dart';
import 'package:EduMap/features/schools/presentation/pages/detail_page.dart';
import 'package:EduMap/features/schools/presentation/widgets/education_cycle_tag_widget.dart';
import 'package:EduMap/features/schools/presentation/widgets/star_bar_widget.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmallSchoolCard extends StatefulWidget {
  final School school;
  final User user;

  SmallSchoolCard({
    this.school,
    this.user,
  });

  @override
  _SmallSchoolCardState createState() => _SmallSchoolCardState();
}

class _SmallSchoolCardState extends State<SmallSchoolCard> {
  @override
  Widget build(BuildContext context) {
    return Parent(
      style: AppThemes.smallCardStyle.clone()..margin(all: 8.0),
      child: InkWell(
        onTap: () {
          BlocProvider.of<CommentsBloc>(context).add(
            GetCommentsEvent(
              idSchool: widget.school.id,
            ),
          );
          Navigator.of(context).pushNamed(Router.detailRoute,
              arguments: DetailPageArgs(
                school: widget.school,
                user: widget.user
              ));
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Txt(
                'École : ',
                style: AppThemes.smallBoldTextStyle.clone()
                  ..textAlign.start()
                  ..width(double.infinity),
              ),
              Txt(
                widget.school.name.toUpperCase(),
                style: AppThemes.schoolTitleStyle.clone()
                  ..textAlign.start()
                  ..width(double.infinity),
              ),
              SizedBox(
                height: 8.0,
              ),
              Txt(
                'Niveaux scolaire : ',
                style: AppThemes.smallBoldTextStyle.clone()
                  ..textAlign.start()
                  ..width(double.infinity)
                  ..margin(bottom: 4.0),
              ),
              Container(
                height: 28.0,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children:
                      getEducationCycleTags(widget.school.educationCycles),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Txt(
                'Description : ',
                style: AppThemes.smallBoldTextStyle.clone()
                  ..textAlign.start()
                  ..width(double.infinity),
              ),
              AutoSizeText(
                widget.school.description.length >= 150
                    ? widget.school.description.substring(0, 150) + ' ...'
                    : widget.school.description + ' ...',
                style: TextStyle(fontSize: 12.0),
                maxLines: 2,
              ),
              SizedBox(
                height: 12.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getScoringStarsWidget(widget.school.rating),
                    Txt(
                      widget.school.rating.toString(),
                      style: AppThemes.ratingStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getEducationCycleTags(
    List<EducationCycleEnum> list,
  ) {
    List<Widget> resultList = [];
    list.forEach((valueEnum) {
      resultList.add(EducationCycleTag(
        educationCycleEnum: valueEnum,
      ));
    });
    return resultList;
  }

  Widget getScoringStarsWidget(double rating) {
    return StarRating(
      color: AppThemes.yellowColor,
      rating: rating,
      onRatingChanged: null,
    );
  }
}
