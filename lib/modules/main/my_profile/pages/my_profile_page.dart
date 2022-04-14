import 'package:bongdavui/models/user.dart';
import 'package:bongdavui/services/auth.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  final UserModel userModel;

  const MyProfilePage({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('userModel');
    print(userModel);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(userModel.uid),
            Text(userModel.email),
            ElevatedButton(
                onPressed: () {
                  AuthService.signOut();
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
