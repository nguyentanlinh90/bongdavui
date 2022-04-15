
import 'package:bongdavui/modules/general/dialog_widget.dart';
import 'package:flutter/material.dart';
class DialogController {
  BuildContext context;
  Dialog? dialog;

  DialogController(this.context, this.dialog);

  Function? _showDialog() {
    showDialog(
        // barrierDismissible: false,// touch outside dismiss
        context: context,
        builder: (BuildContext context) => dialog!);
  }

   dismissDialog() async{

    if(dialog!=null){
   //   Navigator.pop(context);
      Navigator.of(context).pop();
      dialog = null;
    }
  }

  showBaseNotification(String title, String description) async {
   await dismissDialog();
    dialog = Dialog(
      child: generalMessage(context, title, description, dismissDialog),
    );
    _showDialog();
  }

}
