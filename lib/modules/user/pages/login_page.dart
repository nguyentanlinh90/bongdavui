import 'package:bongdavui/config/routes/route_name.dart';
import 'package:bongdavui/models/user.dart';
import 'package:bongdavui/modules/user/widgets/or_line.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../services/auth.dart';
import '../../../widgets/stateless/input_field.dart';
import '../../../widgets/stateless/responsive_button.dart';
import '../widgets/forgot_pass.dart';
import '../widgets/skip_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  style: AppTextStyles.bold(AppSizes.s_50)
                      .copyWith(color: AppColors.blackGrey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //future
                  /*ResponsiveButton(
                      type: AppConstants.typeFacebook,
                      btText: AppString.loginWithFacebook,
                      onTap: () {}),
                  SizedBox(
                    height: size.height * 0.02,
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
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  OrLine(),
                  SizedBox(
                    height: size.height * 0.03,
                  ),*/
                  InputField(
                    controller: emailController,
                    label: AppString.email,
                    maxLength: 100,
                    onChange: () {},
                    onTextChanged: (text) {},
                  ),
                  SizedBox(height: size.height * 0.01),
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
                      onTap: () async {
                        String email = emailController.text;
                        String pass = passwordController.text;
                        UserModel user =
                            await AuthService.loginWithEmailAndPassword(
                                email, pass);

                      }),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  OrLine(),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ResponsiveButton(
                      type: AppConstants.typeNormal,
                      btText: AppString.signIn,
                      onTap: () {
                        Navigator.of(context).pushNamed(RouteName.signIn);
                      }),
                ]),
                SizedBox(
                  height: size.height * 0.03,
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
