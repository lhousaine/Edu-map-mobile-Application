import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/features/users/presentation/widgets/button_widget.dart';
import 'package:EduMap/features/users/presentation/widgets/header_widget.dart';
import 'package:division/division.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final subjectController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Parent(
        style: AppThemes.pagePaddingStyle.clone(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60.0,
              ),
              HeaderWidget(
                bigTitle: "Contactez nous si vous avez des questions?",
                smallDescription:
                    "Veuillez spécifier le sujet de votre message ainsi que décvrivez votre question en details, merci.",
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: subjectController,
                onChanged: (v) => subjectController.text = v,
                decoration: InputDecoration(
                  labelText: 'Sujet du message',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                controller: contentController,
                onChanged: (v) => contentController.text = v,
                decoration: InputDecoration(
                  labelText: 'Contenu du message',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              AppButton(
                isSmall: false,
                isActive: true,
                buttonTitle: 'Envoyer',
                onPressedFunction: () {},
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar buildAppBar(
  BuildContext context,
) {
  return AppBar(
    title: Txt(
      'Contactez Nous',
      style: TxtStyle()
        ..bold()
        ..fontSize(20.0)
        ..textColor(Colors.white)
        ..fontFamily('Raleway'),
    ),
    leading: Parent(
      style: ParentStyle()..scale(1.5),
      child: InkWell(
        onTap: () {
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
