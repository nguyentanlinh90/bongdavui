import 'package:flutter/material.dart';

class AppInputDecorator extends StatelessWidget {
  final String labels;
  final IconData icons;

  const AppInputDecorator({required this.labels, required this.icons, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labels,
        prefixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Icon(
            icons,
          ),
        ),
      ),
    );
  }
}
