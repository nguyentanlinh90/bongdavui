import 'package:bongdavui/config/routes/route_name.dart';
import 'package:bongdavui/main.dart';
import 'package:bongdavui/modules/new_field/new_field_page.dart';
import 'package:bongdavui/modules/new_user/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class RouterSetting {
  static Route<dynamic>? generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.signInRoute:
        {
          return MaterialPageRoute(
              builder: (_) => SignInPage());
        }
      /*case RouteName.editPage:
        {
          Todo todo = settings.arguments as Todo
          return MaterialPageRoute( builder: (_) => EditPage(todo: todo));
        }*/
      case RouteName.newFieldRoute:
        {
          return MaterialPageRoute(
              builder: (_) => NewFieldPage());
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
