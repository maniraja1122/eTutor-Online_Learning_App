import 'package:etutor/Controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/ETutorIcon.dart';
import '../Widgets/SelectionButton.dart';
import '../Widgets/SelectionButtonCourse.dart';

class MyCourseView extends GetView {
  @override
  Widget build(BuildContext context) {
    var _controller=Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        leading: ETutorIcon(
          myicon: Icons.library_books,
          background: Colors.blue.shade700,
          foreground: Colors.white,
        ),
        title: Text(
          "My Courses",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(height: 10,),
          Row(children: [
            Obx(() =>
                SelectionButtonCourse(content: "All Courses",
                    selectedButton: _controller.selectedCourseButton.value)),
            SizedBox(width: 10,),
            Obx(() =>
                SelectionButtonCourse(content: "On Progress",
                    selectedButton: _controller.selectedCourseButton.value)),
            SizedBox(width: 10,),
            Obx(() =>
                SelectionButtonCourse(content: "Completed",
                    selectedButton: _controller.selectedCourseButton.value)),
          ],),
          SizedBox(height: 20,),
          Expanded(
                child: Obx(() => _controller.getMyCoursesList(_controller.selectedCourseButton.value)))
        ],),
      ),
    );
  }
}
