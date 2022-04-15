import 'package:bongdavui/services/auth.dart';
import 'package:bongdavui/widgets/general_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/route_name.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/stateless/app_dialog.dart';
import '../../../widgets/stateless/box_space.dart';
import '../../../widgets/stateless/button_back.dart';
import '../../../widgets/stateless/input_field.dart';
import '../../../widgets/stateless/responsive_button.dart';
import '../../football_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends FootBallBaseScreen<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool enableClick = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    emailController.text = 'nguyentanlinh90@gmail.com';
    passwordController.text = '123456';
    confirmPasswordController.text = '123456';

    return screenWithKeyboard(context,
     Scaffold(
        appBar: baseAppBar(context,  AppString.registrationAccount),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s_8, vertical: AppSizes.s_16),
          child: Column(
            children: [
              InputField(
                controller: emailController,
                label: AppString.email,
                maxLength: 100,
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
              BoxSpace(height: size.height * 0.01),
              InputField(
                controller: confirmPasswordController,
                label: AppString.confirmPassword,
                obscureText: true,
                textInputType: TextInputType.visiblePassword,
                onChange: () {},
                onTextChanged: (text) {},
              ),
              BoxSpace(height: size.height * 0.02),
              ResponsiveButton(
                  enable: enableClick,
                  type: AppConstants.typeNormal,
                  btText: AppString.signIn,
                  onTap: () async {
                    setState(() {
                      enableClick = false;
                    });
                    String email = emailController.text;
                    String pass = passwordController.text;
                    if (isValid(
                        context, email, pass, confirmPasswordController.text)) {
                      await AuthService.signInWithEmailAndPassword(email, pass,
                          (isSuccess, data) {
                        if (isSuccess) {
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
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  bool isValid(
      BuildContext context, String email, String pass, String confirmPass) {
    bool isValid = true;
    if (email.isEmpty) {
      showMessage('', AppString.please_input_email);
      return false;
    }

    if (pass.length < 6) {
      showMessage('', AppString.please_input_email);
      return false;
    }
    if (pass != confirmPass) {
      showMessage('', AppString.please_input_email);
      return false;
    }
    return isValid;
  }
}

void _showMessage(BuildContext context, String message) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AppDialog(
            title: AppString.alert, content: message, yes: AppString.yes);
      });
}


