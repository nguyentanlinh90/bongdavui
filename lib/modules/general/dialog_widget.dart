
import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart';
import '../../widgets/general_widget.dart';

Future<bool> _onWillPop(BuildContext context) async {
  return (await showDialog(
    context: context,
    builder: (context) => new AlertDialog(),
  )) ?? false;
}
Widget generalMessage(BuildContext context,String title,String description, VoidCallback callback){
  return WillPopScope(
    onWillPop: () async => true,// todo disable back
   // onWillPop: ()=>_onWillPop(context),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        spaceHeight(20),
        //Text(title.isEmpty?'Notify':title, style: const TextStyle(color: AppColors.primaryColor,fontSize: 15),),
        textBold(title.isEmpty?'Notify':title),
        spaceHeight(20),
        const Divider(height: 1,color: AppColors.gray,),
        spaceHeight(20),
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Text(description, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textColor,fontSize: 15),),
        ),
        spaceHeight(20),
        InkWell(
          onTap: callback,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: 120,
            height: 36,
            decoration: bgRadius(AppColors.primaryColor, 15),
            child: Center(child: textWhiteLargeBold('OK')),
          ),
        ),

        const SizedBox(height: 5,),
      ],
    ),
  );
}

