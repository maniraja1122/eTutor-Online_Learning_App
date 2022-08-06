import 'package:flutter/material.dart';

class ETutorIcon extends StatelessWidget {
  IconData myicon;
  Color foreground;
  Color background;

  ETutorIcon(
      {Key? key,
      required this.myicon,
      required this.background,
      required this.foreground})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 40,
        child: Icon(
          myicon,
          color: foreground,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: background),
      ),
    );
  }
}
