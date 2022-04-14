import 'package:bongdavui/config/routes/route_name.dart';
import 'package:bongdavui/modules/main/main_page.dart';
import 'package:bongdavui/modules/user/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../../modules/new_field/new_field_page.dart';
import '../../modules/user/pages/sign_in_page.dart';

class RouterSetting {
  static Route<dynamic>? generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.login:
        {
          return MaterialPageRoute(builder: (_) => LoginPage());
        }
      case RouteName.signIn:
        {
          return MaterialPageRoute(builder: (_) => SignInPage());
        }
      case RouteName.main:
        {
          return MaterialPageRoute(builder: (_) => Container());
        }
      /*case RouteName.editPage:
        {
          Todo todo = settings.arguments as Todo
          return MaterialPageRoute( builder: (_) => EditPage(todo: todo));
        }*/
      case RouteName.newField:
        {
          return MaterialPageRoute(builder: (_) => NewFieldPage());
        }
      default:
        {
          return MaterialPageRoute(
              builder: (_) => Scaffold(
                    body: Center(
                      child: Text('No route define for ${settings.name}'),
                    ),
                  ));
        }
    }
  }
}
