import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/Controllers/HomeController.dart';
import 'package:etutor/ListItems/PromotionItem.dart';
import 'package:etutor/Repository/DBHelper.dart';
import 'package:etutor/Views/ViewCourse.dart';
import 'package:etutor/Widgets/MainAppBar.dart';
import 'package:etutor/Widgets/SelectionButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainView extends GetView {
  @override
  Widget build(BuildContext context) {
    var _controller = Get.find<HomeController>();
    return Scaffold(
      appBar: MainAppBar(),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5,),
              Text(
                "Promotion",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              StreamBuilder(
                stream: DBHelper.db.collection("Course").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    snapshot) {
                  if (snapshot.hasData) {
                    var arr = snapshot.data!.docs;
                    return CarouselSlider.builder(itemCount: arr.length,
                        itemBuilder: (c, i, p) {
                          return InkWell(onTap: () {
                            Get.to(ViewCourse(snap: arr[i]));
                          }, child: PromotionItem(
                              snap: arr[i]));
                        },
                        options
                            : CarouselOptions(autoPlay: true));
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              SizedBox(height: 10,),
              Text(
                "Awesome Courses",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Row(children: [
                Obx(() =>
                    SelectionButton(content: "All Courses",
                        selectedButton: _controller.selectedButton.value)),
                SizedBox(width: 10,),
                Obx(() =>
                    SelectionButton(content: "Popular",
                        selectedButton: _controller.selectedButton.value)),
                SizedBox(width: 10,),
                Obx(() =>
                    SelectionButton(content: "Newest",
                        selectedButton: _controller.selectedButton.value)),
              ],),
              SizedBox(height: 5,),
              Expanded(child: Obx(() =>
                  _controller.getCourseList(_controller.selectedButton.value)))
            ],
          ),
        ),
      ),
    );
  }
}
