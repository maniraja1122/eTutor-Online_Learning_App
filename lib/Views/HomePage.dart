import 'package:etutor/Controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomePage extends GetView {
  @override
  Widget build(BuildContext context) {
    var _controller = Get.put(HomeController());
    return Scaffold(
      body: Center(child: Text("Home"),),
    );
  }
}