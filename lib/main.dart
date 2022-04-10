import 'package:bongdavui/config/routes/route_name.dart';
import 'package:bongdavui/config/routes/router_setting.dart';
import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:bongdavui/modules/new_user/pages/sign_in_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // debugShowCheckedModeBanner: false,
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        initialRoute: RouteName.signInPage,
        onGenerateRoute: RouterSetting.generateRouter,
        theme: ThemeData(primaryColor: AppColors.primaryColor),
        darkTheme: ThemeData.dark(),
        home: SignInPage());
  }
}
