import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/features/schools/presentation/pages/about_page.dart';
import 'package:EduMap/features/schools/presentation/pages/contact_page.dart';
import 'package:EduMap/features/schools/presentation/pages/detail_page.dart';
import 'package:EduMap/features/schools/presentation/pages/home_page.dart';
import 'package:EduMap/features/schools/presentation/pages/map_page.dart';
import 'package:EduMap/features/schools/presentation/pages/profile_page.dart';
import 'package:EduMap/features/schools/presentation/pages/replay_page.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/features/users/presentation/pages/login_page.dart';
import 'package:EduMap/features/users/presentation/pages/register_page.dart';
import 'package:EduMap/features/users/presentation/pages/request_page.dart';
import 'package:EduMap/main.dart';
import 'package:flutter/material.dart';

class Router {
  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String requestRoute = '/request';
  static const String loginRoute = '/login';
  static const String replayRoute = '/replay';
  static const String registerRoute = '/register';
  static const String detailRoute = '/detail';
  static const String mapRoute = '/map';
  static const String profileRoute = '/profile';
  static const String aboutRoute = '/about';
  static const String contactRoute = '/contact';
  static const String settingsRoute = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case homeRoute:
        if (args is HomePageParams) {
          return MaterialPageRoute(
            builder: (_) => HomeScreen(
              args: args,
            ),
          );
        }
        return errorRoute(settings);
      case requestRoute:
        return MaterialPageRoute(builder: (_) => RequestScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case detailRoute:
        if (args is DetailPageArgs) {
          return MaterialPageRoute(
            builder: (_) => DetailPage(
              args: args,
            ),
          );
        }
        return errorRoute(settings);
      case mapRoute:
        if (args is MapPageParams) {
          return MaterialPageRoute(
            builder: (_) => MapPage(
              schools: args.schools,
              user: args.user,
            ),
          );
        }
        return errorRoute(settings);
      case replayRoute:
        if (args is ReplayPageParams) {
          return MaterialPageRoute(
            builder: (_) => ReplayPage(
              comment: args.comment,
              idSchool: args.idSchool,
              user: args.user,
            ),
          );
        }
        return errorRoute(settings);
      case profileRoute:
        if (args is User) {
          return MaterialPageRoute(
            builder: (_) => ProfilePage(
              user: args,
            ),
          );
        }
        return errorRoute(settings);
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => Container());
      case aboutRoute:
        return MaterialPageRoute(builder: (_) => AboutPage());
      case contactRoute:
        return MaterialPageRoute(builder: (_) => ContactPage());
      default:
        return errorRoute(settings);
    }
  }

  static MaterialPageRoute errorRoute(settings) {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                  child: Text(
                'No route defined for ${settings.name}',
                style: TextStyle(
                  color: Colors.red,
                ),
              )),
            ));
  }
}
