import 'package:EduMap/core/theme/app_theme.dart';
import 'package:division/division.dart';
import 'package:eva_icons_flutter/icon_data.dart';
import 'package:flutter/material.dart';

class TextFormInput extends StatefulWidget {
  final EvaIconData icon;
  final String hint;
  final TextEditingController controller;
  final Function validator;

  TextFormInput({
    this.icon,
    this.hint,
    this.controller,
    this.validator,
  });

  @override
  _TextFormInputState createState() => _TextFormInputState();
}

class _TextFormInputState extends State<TextFormInput> {
  bool isValidated = false;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: AppThemes.inputStyle.clone(),
      child: TextFormField(
        controller: widget.controller,
        style: TextStyle(
          fontFamily: 'Raleway',
        ),
        decoration: InputDecoration(
          labelText: widget.hint,
          prefixIcon: Icon(
            widget.icon != null ? widget.icon : Icons.assignment_ind,
            size: AppThemes.inputIconSize,
            color: AppThemes.blueColor,
          ),
          errorText: widget.validator(widget.controller.text),
        ),
      ),
    );
  }
}

class TextFormInputPassword extends StatefulWidget {
  final EvaIconData icon;
  final String hint;
  final TextEditingController controller;
  final Function validator;

  TextFormInputPassword({
    this.icon,
    this.hint,
    this.controller,
    this.validator,
  });

  @override
  _TextFormInputPasswordState createState() => _TextFormInputPasswordState();
}

class _TextFormInputPasswordState extends State<TextFormInputPassword> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: AppThemes.inputStyle.clone(),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isObscureText,
        decoration: InputDecoration(
          labelText: widget.hint,
          suffixIcon: InkWell(
            child: Icon(
              Icons.remove_red_eye,
              size: AppThemes.smallInputIconSize,
              color: AppThemes.blueColor,
            ),
            onTap: () {
              setState(() {
                isObscureText = !isObscureText;
              });
            },
          ),
          prefixIcon: Icon(
            widget.icon,
            size: AppThemes.inputIconSize,
            color: AppThemes.blueColor,
          ),
          errorText: widget.validator(widget.controller.text),
        ),
      ),
    );
  }
}
