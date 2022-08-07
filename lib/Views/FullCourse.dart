import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/Controllers/HomeController.dart';
import 'package:etutor/ListItems/LessonItem.dart';
import 'package:etutor/Widgets/BackBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../Models/Rating.dart';
import '../Repository/DBHelper.dart';
import '../Widgets/ETutorIcon.dart';

class FullCourse extends GetView {
  String coursekey = "";

  FullCourse({Key? key, required this.coursekey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller=Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(),
        title: StreamBuilder(
          stream: DBHelper.db
              .collection("CourseLesson")
              .where("coursekey", isEqualTo: coursekey)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              var count = snapshot.data!.docs.length;
              return Text(
                count.toString() + " Lessons",
                style: TextStyle(fontWeight: FontWeight.bold),
              );
            }
            return SizedBox();
          },
        ),
        actions: [
          StreamBuilder(
            stream: DBHelper.db
                .collection("CompletedCourses")
                .where("coursekey", isEqualTo: coursekey)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                var arr = snapshot.data!.docs.where((element) =>
                    element.get("userkey") == DBHelper.auth.currentUser!.uid);
                if (arr.isEmpty) {
                  return SizedBox();
                }
                return StreamBuilder(
                  stream: DBHelper.db
                      .collection("Rating")
                      .where("userkey",
                          isEqualTo: DBHelper.auth.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasData) {
                      var arr = snapshot.data!.docs.where(
                          (element) => element.get("coursekey") == coursekey);
                      if (arr.isEmpty) {
                        return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (c) {
                                    return AlertDialog(
                                      titleTextStyle: TextStyle(color: Colors.black,fontSize: 20),
                                      title: Text("Rate It"),
                                      content: Obx(()=>RatingBar.builder(
                                        itemSize: 30,
                                        initialRating: _controller.barrating.value,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          _controller.barrating.value=rating;
                                        },
                                      )),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              await DBHelper.db.collection("Rating").add(Rating(coursekey: coursekey, rating: _controller.barrating.value).toMap());
                                              Get.back();
                                            },
                                            child: Text("Rate")),
                                        ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Cancel"))
                                      ],
                                    );
                                  });
                            },
                            child: ETutorIcon(
                              myicon: Icons.star,
                              background: Colors.grey.shade200,
                              foreground: Colors.blue.shade700,
                            ));
                      }
                      return SizedBox();
                    }
                    return SizedBox();
                  },
                );
              }
              return SizedBox();
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: DBHelper.db
            .collection("CourseLesson")
            .where("coursekey", isEqualTo: coursekey)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            var arr = snapshot.data!.docs;
            return ListView.builder(
              itemCount: arr.length,
              itemBuilder: (BuildContext context, int index) {
                return LessonItem(
                    itemno: index + 1, lessonkey: arr[index].get("lessonkey"));
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
