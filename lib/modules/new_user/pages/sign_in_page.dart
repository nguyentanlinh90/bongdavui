import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:bongdavui/config/theme/app_text_styles.dart';
import 'package:bongdavui/constants/app_constants.dart';
import 'package:bongdavui/constants/app_sizes.dart';
import 'package:bongdavui/constants/app_strings.dart';
import 'package:bongdavui/modules/main/main_page.dart';
import 'package:bongdavui/modules/new_user/widgets/responsive_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    // an ngay gio
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.width * 0.1),
          child: Align(
            alignment: Alignment.center,
            child: Column(children: [
              Expanded(
                  child: Column(
                children: [
                  SizedBox(height: size.height * 0.1),
                  Text(
                    AppString.bongDaVui,
                    style: AppTextStyles.bold(AppSizes.s_50)
                        .copyWith(color: AppColors.blackGrey),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        ResponsiveButton(
                            type: AppConstants.typeFacebook,
                            btText: AppString.loginWithFacebook,
                            onTap: () {}),
                        const SizedBox(
                          height: AppSizes.s_30,
                        ),
                        ResponsiveButton(
                          type: AppConstants.typeGoogle,
                          btText: AppString.loginWithGoogle,
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                            MainPage(),
                                    transitionsBuilder: (___,
                                        Animation<double> animation,
                                        ____,
                                        Widget child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: RotationTransition(
                                          turns:
                                              Tween<double>(begin: 0.5, end: 1)
                                                  .animate(animation),
                                          child: child,
                                        ),
                                      );
                                    }));
                          },
                        ),
                      ])),
                  /*Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          color: AppColors.blackGrey,
                          height: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            right: AppSizes.s_10, left: AppSizes.s_10),
                        child: Text(
                          AppString.or,
                          style: AppTextStyles.black(AppSizes.s_20)
                              .copyWith(color: AppColors.blackGrey),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: AppColors.blackGrey,
                          height: 1,
                        ),
                      )
                    ],
                  )
              ),*/
                ],
              )),
              Material(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(AppSizes.s_24),
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => MainPage()));
                  },
                  splashColor: Colors.black38,
                  borderRadius: BorderRadius.circular(AppSizes.s_24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.s_50, vertical: AppSizes.s_12),
                    child: Text(
                      AppString.skip,
                      style:
                          AppTextStyles.h5().copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
