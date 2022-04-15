import 'package:bongdavui/config/routes/route_name.dart';
import 'package:bongdavui/modules/user/widgets/or_line.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_strings.dart';
import '../../../services/auth.dart';
import '../../../widgets/general_widget.dart';
import '../../../widgets/stateless/input_field.dart';
import '../../../widgets/stateless/responsive_button.dart';
import '../../football_screen.dart';
import '../widgets/forgot_pass.dart';
import '../widgets/skip_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends FootBallBaseScreen<SignInPage> {
  bool enableClick = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    emailController.text = 'nguyentanlinh90@gmail.com';
    passwordController.text = '123456';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.02, vertical: size.height * 0.02),
            child: Column(
              children: [
                Text(
                  AppString.bongDaVui,
                  style:
                      AppTextStyles.h3().copyWith(color: AppColors.blackGrey),
                  textAlign: TextAlign.center,
                ),
                spaceHeight(
                  size.height * 0.05,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //future
                  /*ResponsiveButton(
                      type: AppConstants.typeFacebook,
                      btText: AppString.loginWithFacebook,
                      onTap: () {}),
                  spaceHeight(
                    size.height * 0.02,
                  ),
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
                  spaceHeight(
                    size.height * 0.03,
                  ),
                  OrLine(),
                  spaceHeight(
                    size.height * 0.03,
                  ),*/
                  InputField(
                    controller: emailController,
                    label: AppString.email,
                    maxLength: 100,
                    onChange: () {},
                    onTextChanged: (text) {},
                  ),
                  spaceHeight(size.height * 0.01),
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
                      enable: enableClick,
                      type: AppConstants.typeNormal,
                      btText: AppString.login,
                      onTap: () async {
                        setState(() {
                          enableClick = false;
                        });
                        String email = emailController.text;
                        String pass = passwordController.text;
                        await AuthService.signInWithEmailAndPassword(
                            email, pass, (isSuccess, data) {
                          if (isSuccess) {
                            showMessage('', 'success');
                            Navigator.pushNamedAndRemoveUntil(
                                context, RouteName.main, ModalRoute.withName('/'));
                          } else {
                            // _showMessage(context, data);
                            showMessage('', data);
                            setState(() {
                              enableClick = true;
                            });
                          }
                        });
                      }),
                  spaceHeight(
                    size.height * 0.03,
                  ),
                  const OrLine(),
                  spaceHeight(
                    size.height * 0.03,
                  ),
                  ResponsiveButton(
                      type: AppConstants.typeNormal,
                      btText: AppString.signIn,
                      onTap: () {
                        Navigator.of(context).pushNamed(RouteName.signIn);
                      }),
                ]),
                spaceHeight(
                  size.height * 0.03,
                ),
                const SkipButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
