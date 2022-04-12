import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:bongdavui/config/theme/app_text_styles.dart';
import 'package:bongdavui/constants/app_constants.dart';
import 'package:bongdavui/constants/app_sizes.dart';
import 'package:bongdavui/constants/app_strings.dart';
import 'package:bongdavui/modules/main/main_page.dart';
import 'package:bongdavui/modules/new_user/widgets/forgot_pass.dart';
import 'package:bongdavui/modules/new_user/widgets/or_line.dart';
import 'package:bongdavui/modules/new_user/widgets/skip_button.dart';
import 'package:bongdavui/widgets/stateless/box_space.dart';
import 'package:bongdavui/widgets/stateless/input_field.dart';
import 'package:bongdavui/widgets/stateless/responsive_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // an ngay gio
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Text(
                      AppString.bongDaVui,
                      style: AppTextStyles.bold(AppSizes.s_50)
                          .copyWith(color: AppColors.blackGrey),
                      textAlign: TextAlign.center,
                    ),
                    BoxSpace(height: size.height * 0.05),
                    ResponsiveButton(
                        type: AppConstants.typeFacebook,
                        btText: AppString.loginWithFacebook,
                        onTap: () {}),
                    BoxSpace(height: size.height * 0.02),
                    ResponsiveButton(
                      type: AppConstants.typeGoogle,
                      btText: AppString.loginWithGoogle,
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) =>
                                    MainPage(),
                                transitionsBuilder: (___,
                                    Animation<double> animation,
                                    ____,
                                    Widget child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: RotationTransition(
                                      turns: Tween<double>(begin: 0.5, end: 1)
                                          .animate(animation),
                                      child: child,
                                    ),
                                  );
                                }));
                      },
                    ),
                    BoxSpace(height: size.height * 0.03),
                    const OrLine(),
                    BoxSpace(height: size.height * 0.02),
                    InputField(
                      controller: nameController,
                      label: AppString.userName,
                      onChange: () {},
                      onTextChanged: (text) {},
                    ),
                    BoxSpace(height: size.height * 0.01),
                    InputField(
                      controller: passwordController,
                      label: AppString.password,
                      obscureText: true,
                      textInputType: TextInputType.visiblePassword,
                      onChange: () {},
                      onTextChanged: (text) {},
                    ),
                    ForgotPass(
                      onPress: () {},
                    ),
                    ResponsiveButton(
                        type: AppConstants.typeNormal,
                        btText: AppString.login,
                        onTap: () {}),
                  ]),
                ),
              ),
              const SkipButton(),
            ],
          ),
        ),
      ),
    );
  }
}
