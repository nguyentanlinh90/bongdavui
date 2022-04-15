
import 'package:bongdavui/core/general_screen.dart';
import 'package:bongdavui/helpers/connect_internet.dart';
import 'package:flutter/material.dart';
import 'general/dialog_controller.dart';

abstract class FootBallBaseScreen <T extends StatefulWidget> extends GeneralScreen<T>{
  ConnectInternet? connectInternet;
  bool isOnline = true;
  bool? isLoading = false;
  bool firstLoad = true;
  bool endData = false;

  bool isLogin = false;
  Dialog? dialog;
  // todo bloc

 @override
 void initAll() {
   initBloc();// TODO : THE FIRST
   _checkInternet();
    super.initAll();
  }

 @override
  void disposeAll() {
   dismissLoading();
   dismissDialog();
   _disposeBloc();
   isLoading = false;
   firstLoad = true;
   endData = false;
   if (connectInternet != null) {
     connectInternet!.dispose();
   }
    super.disposeAll();
  }
 void _disposeBloc(){

 }
  void dismissDialog() {
    DialogController(context, dialog).dismissDialog();
    firstLoad = true;
  }
  void initBloc() {
  }
 _checkInternet() async {
   connectInternet = ConnectInternet();
   await  connectInternet!.checkConnection().then((isConnect) {
     if (mounted)
     {
       setState(() {
         isOnline = isConnect;
       });
     }
   });
 }
 internetOnChangedListener(ValueChanged<bool> isConnect)async{
   if (connectInternet != null) {
     connectInternet!.dispose();
   }
   // connectionStatus = Connection.getInstance(); todo bị duplicate listen
   connectInternet = ConnectInternet();
   connectInternet!.onChangedListener();
   connectInternet!.connectionChange.listen((event) {
     isConnect(event);
   });
 }
 setIsLoading(bool isLoad) {
   if(mounted) {
     setState(() {
       isLoading = isLoad;
     });
   }
 }

 void showErrorRequest(String error) {
   showMessage('', error);
 }
 showMessage(String title, String message) {
   DialogController(context, dialog).showBaseNotification(title, message);
 }
}
