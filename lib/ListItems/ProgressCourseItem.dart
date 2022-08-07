import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/Views/FullCourse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../Repository/DBHelper.dart';
import '../Views/ViewCourse.dart';

class ProgressCourseItem extends StatelessWidget {
  String coursekey;

  ProgressCourseItem({Key? key, required this.coursekey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
              Get.to(FullCourse(coursekey: coursekey));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: StreamBuilder(
              stream: DBHelper.db
                  .collection("Course")
                  .where("key", isEqualTo: coursekey)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  var item = snapshot.data!.docs[0];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.get("name"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  );
                }
                return SizedBox();
              },
            ),
            subtitle: StreamBuilder(
              stream: DBHelper.db
                  .collection("CourseLesson")
                  .where("coursekey", isEqualTo: coursekey)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  var arr = snapshot.data!.docs;
                  return Text(
                    arr.length.toString() + " lessons",
                    style: TextStyle(color: Colors.black),
                  );
                }
                return SizedBox();
              },
            ),
            leading: StreamBuilder(
              stream: DBHelper.db
                  .collection("Course")
                  .where("key", isEqualTo: coursekey)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  var item = snapshot.data!.docs[0];
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      item.get("imageurl"),
                      height: 60,
                      width: 60,
                      fit: BoxFit.fill,
                    ),
                  );
                }
                return SizedBox();
              },
            ),
            trailing: StreamBuilder(
              stream: DBHelper.db
                  .collection("CourseLesson")
                  .where("coursekey", isEqualTo: coursekey)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  var arr = snapshot.data!.docs;
                  var totallessons = arr.length;
                  var lessonkeys = arr.map((e) => e.get("lessonkey")).toList();
                  return StreamBuilder(
                    stream: DBHelper.db
                        .collection("CompletedLessons")
                        .where("lessonkey", whereIn: lessonkeys)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasData) {
                        var completedlist = snapshot.data!.docs.where((e) =>
                            e.get("userkey") == DBHelper.auth.currentUser!.uid);
                        var completecount = completedlist.length;
                        var completedpercentage =
                            (completecount.toDouble() / totallessons);
                        return CircularPercentIndicator(
                          radius: 25,
                          lineWidth: 5.0,
                          percent: completedpercentage,
                          center: Text(
                            (completedpercentage * 100).toStringAsFixed(0) +
                                "%",
                            style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                          progressColor: Colors.blue.shade700,
                        );
                      }
                      return CircularPercentIndicator(
                        radius: 25,
                        lineWidth: 5.0,
                        percent: 0,
                        center: Text(
                          (0).toStringAsFixed(0) + "%",
                          style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold),
                        ),
                        progressColor: Colors.blue.shade700,
                      );
                    },
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
