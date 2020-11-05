import 'package:division/division.dart';
import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK }

class AppThemes {
  static final double verticalMargin = 12.0;
  static final double horizontalMargin = 12.0;
  static final double inputIconSize = 35.0;
  static final double smallInputIconSize = 26.0;
  static final Color yellowColor = Color(0xFFFFB91F);
  static final Color blueColor = Color(0xFF161149);
  static final Color darkBlueColor = Color(0x88161149);
  static final Color accentColor = Color(0xFFFFB91F);

  static ThemeData lightTheme = ThemeData(
    primaryColor: yellowColor,
    accentColor: accentColor,
    primaryColorDark: darkBlueColor,
    textTheme: TextTheme(
      button: TextStyle(
        fontFamily: 'Raleway',
      ),
      title: TextStyle(
        fontFamily: 'Raleway',
      ),
    ),
  );

  static final paddingAllStyle = ParentStyle()..padding(all: 12.0);
  static final marginAllStyle = ParentStyle()..margin(all: 12.0);
  static final smallImageStyle = ParentStyle()..width(150);
  static final mediumImageStyle = ParentStyle()..width(300);
  static final largeImageStyle = ParentStyle()..width(350);
  static final successTextStyle = TxtStyle()
    ..textColor(Colors.green)
    ..fontSize(12.0)
    ..fontFamily('Raleway')
    ..alignment.center();
  static final failureTextStyle = TxtStyle()
    ..textColor(Colors.red)
    ..fontSize(12.0)
    ..bold()
    ..fontFamily('Raleway')
    ..alignment.center();
  static final centerAll = ParentStyle()
    ..alignment.center()
    ..maxWidth(150);
  static final smallTextStyle = TxtStyle()
    ..textColor(AppThemes.blueColor)
    ..fontSize(12.0)
    ..fontFamily('Raleway')
    ..alignment.center();
  static final schoolTitleStyle = TxtStyle()
    ..textColor(AppThemes.yellowColor)
    ..fontSize(16.0)
    ..bold()
    ..fontFamily('Raleway')
    ..alignment.center();
  static final smallBoldTextStyle = TxtStyle()
    ..textColor(AppThemes.blueColor)
    ..fontSize(12.0)
    ..bold()
    ..fontFamily('Raleway')
    ..alignment.center();
  static final mediumTextStyle = TxtStyle()
    ..textColor(AppThemes.blueColor)
    ..fontSize(14.0)
    ..padding(all: 8.0)
    ..fontFamily('Raleway')
    ..alignment.center();
  static final largeTextStyle = TxtStyle()
    ..textColor(AppThemes.blueColor)
    ..fontSize(18.0)
    ..fontFamily('Raleway')
    ..alignment.center();
  static final iconStyle = ParentStyle()
    ..scale(1.2)
    ..padding(all: 10.0);
  static final circularProgressIndicatorStyle = ParentStyle()
    ..width(40)
    ..margin(all: 8);
  static final pagePaddingStyle = ParentStyle()
    ..padding(
      right: 8.0,
      left: 8.0,
    );
  static final enabledButtonStyle = TxtStyle()
    ..textColor(Colors.white)
    ..bold()
    ..padding(horizontal: 30, vertical: 15)
    ..background.color(yellowColor)
    ..borderRadius(all: 8)
    ..alignment.center()
    ..fontSize(20.0)
    ..minHeight(60)
    ..minWidth(250)
    ..alignmentContent.center()
    ..alignment.center()
    ..fontFamily('Raleway')
    ..ripple(true, splashColor: Colors.white)
    ..elevation(5, color: Colors.grey);
  static final enabledSmallButtonStyle = TxtStyle()
    ..textColor(Colors.white)
    ..bold()
    ..padding(horizontal: 10, vertical: 8)
    ..background.color(yellowColor)
    ..borderRadius(all: 8)
    ..alignment.center()
    ..fontSize(12.0)
    ..height(50)
    ..minWidth(100)
    ..alignmentContent.center()
    ..alignment.center()
    ..fontFamily('Raleway')
    ..ripple(true, splashColor: Colors.white)
    ..elevation(5, color: Colors.grey);
  static final subEnabledButtonStyle = TxtStyle()
    ..textColor(AppThemes.blueColor)
    ..padding(horizontal: 30, vertical: 15)
    ..background.color(Colors.white)
    ..borderRadius(all: 8)
    ..fontSize(14.0)
    ..minHeight(60)
    ..minWidth(250)
    ..alignmentContent.center()
    ..alignmentContent.center()
    ..alignment.center()
    ..fontFamily('Raleway')
    ..ripple(true)
    ..elevation(2, color: Colors.grey);
  static final subEnabledSmallButtonStyle = TxtStyle()
    ..textColor(AppThemes.blueColor)
    ..padding(horizontal: 10, vertical: 8)
    ..background.color(Colors.white)
    ..borderRadius(all: 8)
    ..fontSize(12.0)
    ..height(40)
    ..minWidth(100)
    ..alignmentContent.center()
    ..alignmentContent.center()
    ..alignment.center()
    ..fontFamily('Raleway')
    ..ripple(false)
    ..elevation(2, color: Colors.grey);
  static final disabledButtonStyle = TxtStyle()
    ..textColor(Colors.white)
    ..padding(horizontal: 30, vertical: 15)
    ..background.color(yellowColor)
    ..borderRadius(all: 8)
    ..fontSize(18.0)
    ..minHeight(60)
    ..minWidth(250)
    ..alignmentContent.center()
    ..alignment.center()
    ..fontFamily('Raleway')
    ..ripple(true)
    ..elevation(10, color: Colors.grey);
  static final disabledSmallButtonStyle = TxtStyle()
    ..textColor(Colors.black)
    ..padding(horizontal: 15, vertical: 8)
    ..background.color(Colors.grey)
    ..borderRadius(all: 8)
    ..fontSize(10.0)
    ..height(40)
    ..minWidth(100)
    ..alignmentContent.center()
    ..alignment.center()
    ..fontFamily('Raleway')
    ..ripple(false)
    ..elevation(1, color: Colors.grey);
  static final inputStyle = ParentStyle()
    ..margin(top: 8.0, bottom: 8.0)
    ..padding(top: 8.0, bottom: 8.0)
    ..background.color(Colors.white)
    ..padding(all: 6.0)
    ..borderRadius(all: 5.0)
    ..elevation(2.0);
  static final dropDownMenuStyle = TextStyle(
    color: AppThemes.blueColor,
    fontFamily: 'Raleway',
  );
  static final smallCardStyle = ParentStyle()
    ..elevation(5.0)
    ..border(
      color: AppThemes.blueColor,
      all: 1.0,
    )
    ..borderRadius(all: 8.0)
    ..padding(all: 8.0)
    ..width(250)
    ..background.color(Colors.white);
  static final cardStyle = ParentStyle()
    ..elevation(5.0)
    ..height(200.0)
    ..borderRadius(topRight: 8.0, bottomRight: 8.0,)
    ..border(color: AppThemes.blueColor, all: 1.0)
    ..background.color(Colors.white);
  static final tagStyle = ParentStyle()
    ..border(all: 0.2)
    ..margin(right: 8.0)
    ..height(10.0)
    ..borderRadius(all: 5.0);
  static final ratingStyle = TxtStyle()
    ..bold()
    ..fontSize(26.0)
    ..textColor(AppThemes.blueColor);
  static final smallRatingStyle = TxtStyle()
    ..bold()
    ..fontSize(22.0)
    ..textColor(AppThemes.blueColor);
}
