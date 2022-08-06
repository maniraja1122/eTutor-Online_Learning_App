import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ETutorIcon.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.back();
      },
      child: ETutorIcon(
          myicon: Icons.arrow_back,
          background: Colors.grey.shade200,
          foreground: Colors.blue),
    );
  }
}
