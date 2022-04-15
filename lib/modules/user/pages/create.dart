import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:bongdavui/config/theme/app_text_styles.dart';
import 'package:bongdavui/modules/main/main_page.dart';
import 'package:bongdavui/services/auth.dart';
import 'package:bongdavui/utils/utils.dart';
import 'package:bongdavui/widgets/general_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/route_name.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/stateless/app_dialog.dart';
import '../../../widgets/stateless/input_field.dart';
import '../../../widgets/stateless/responsive_button.dart';
import '../../football_screen.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends FootBallBaseScreen<CreateUserPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool enableClick = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    emailController.text = 'nguyentanlinh90@gmailcom';
    passwordController.text = ' Vignesh123!';
    confirmPasswordController.text = ' Vignesh123!';

    return screenWithKeyboard(
      context,
      Scaffold(
        appBar: baseAppBar(context, AppString.registrationAccount),
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
              spaceHeight(size.height * 0.01),
              InputField(
                controller: passwordController,
                label: AppString.password,
                obscureText: true,
                textInputType: TextInputType.visiblePassword,
                onChange: () {},
                onTextChanged: (text) {},
              ),
              spaceHeight(size.height * 0.01),
              InputField(
                controller: confirmPasswordController,
                label: AppString.confirmPassword,
                obscureText: true,
                textInputType: TextInputType.visiblePassword,
                onChange: () {},
                onTextChanged: (text) {},
              ),
              Text(AppString.valid_pass_error,
                  style: AppTextStyles.h5(
                      color: AppColors.red, fontWeight: FontWeight.w100)),
              spaceHeight(size.height * 0.05),
              ResponsiveButton(
                  enable: enableClick,
                  type: AppConstants.typeNormal,
                  btText: AppString.signIn,
                  onTap: () async {
                    String email = emailController.text;
                    String pass = passwordController.text;
                    if (isValid(
                        context, email, pass, confirmPasswordController.text)) {
                      setState(() {
                        enableClick = false;
                      });

                      await AuthService.createUserWithEmailAndPassword(
                          email, pass, (isSuccess, data) {
                        if (isSuccess) {
                          //todo
                          /*Navigator.pushAndRemoveUntil(
                              context, MainPage(userModel: userModel), ModalRoute.withName('/'));*/
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
      showMessage('', AppString.valid_email_empty);
      return false;
    }

    if (!Utils.validEmail(email)) {
      showMessage('', AppString.valid_email_error);
      return false;
    }

    if (pass.length < 6) {
      // showMessage('', AppString.please_input_email);
      return false;
    }
    if (pass != confirmPass) {
      // showMessage('', AppString.please_input_email);
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
