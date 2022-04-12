import 'package:bongdavui/config/routes/route_name.dart';
import 'package:bongdavui/config/routes/router_setting.dart';
import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:bongdavui/modules/main/main_page.dart';
import 'package:bongdavui/modules/new_field/new_field_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        // initialRoute: RouteName.signInRoute,
        onGenerateRoute: RouterSetting.generateRouter,
        theme: ThemeData(primaryColor: AppColors.primaryColor),
        darkTheme: ThemeData.dark(),
        home: MainPage(),
        /*routes: <String, WidgetBuilder>{
          RouteName.mainRoute: (BuildContext context) => MainPage(),
          RouteName.newFieldRoute: (BuildContext context) => NewFieldPage(),
        },
        onUnknownRoute: (RouteSettings rs) => MaterialPageRoute(
            builder: (context) => Container(
                  child: Text('Not Found'),
                )
        )*/
    );
  }
}
