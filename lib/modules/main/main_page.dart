import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:bongdavui/models/user.dart';
import 'package:bongdavui/modules/main/home/home_page.dart';
import 'package:bongdavui/modules/main/my_profile/pages/my_profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final UserModel userModel;

  const MainPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      HomePage(),
      MyProfilePage(userModel: widget.userModel),
    ];
    return Scaffold(
      backgroundColor: AppColors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primaryColor,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.sports_soccer_outlined,
                size: 30,
                color: AppColors.white,
              ),
              label: "Home",
              icon: Icon(
                Icons.sports_soccer_outlined,
                size: 30,
                color: AppColors.blackGrey,
              )),
          BottomNavigationBarItem(
              label: "My Profile", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
