import 'package:flutter/material.dart';

class BoxSpace extends StatelessWidget {
  final double height;

  const BoxSpace({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
