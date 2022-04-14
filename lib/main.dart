import 'dart:async';

import 'package:bongdavui/config/routes/router_setting.dart';
import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:bongdavui/models/user.dart';
import 'package:bongdavui/modules/main/main_page.dart';
import 'package:bongdavui/modules/user/pages/login_page.dart';
import 'package:bongdavui/widgets/stateless/app_loading_overlay.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );*/
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // initialRoute: RouteName.main,
      onGenerateRoute: RouterSetting.generateRouter,
      theme: ThemeData(primaryColor: AppColors.primaryColor),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: _getLandingPage(),
        ),
      ),
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

  StreamBuilder<User?> _getLandingPage() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppLoadingOverlay(isLoading: true, widget: Container());
          }
          if (snapshot.hasData) {
            final data = snapshot.data;
            UserModel userModel = UserModel(uid: data!.uid, email: data.email!);
            return MainPage(userModel: userModel);
          } else {
            return LoginPage();
          }
        });
  }
}
