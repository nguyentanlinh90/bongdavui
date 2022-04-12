import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/app_sizes.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
          alignment: Alignment.center,
          child: const FaIcon(
            FontAwesomeIcons.angleLeft,
            size: AppSizes.s_30,
          )),
    );
  }
}
