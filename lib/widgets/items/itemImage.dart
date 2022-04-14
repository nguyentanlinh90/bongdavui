import 'dart:io';

import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_sizes.dart';

class ItemImage extends StatelessWidget {
  final XFile? item;
  final VoidCallback? remove;
  const ItemImage({Key? key, this.item, this.remove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)),
      color: AppColors.primaryColor,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image.file(File(item!.path)),
          ElevatedButton(
              onPressed: () {
                remove!();
              },
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  primary: AppColors.white,
                  padding: const EdgeInsets.all(0)),
              child: const FaIcon(
                FontAwesomeIcons.xmark,
                size: AppSizes.s_30,
                color: AppColors.black,
              ))
        ],
      ),
    );
  }
}
