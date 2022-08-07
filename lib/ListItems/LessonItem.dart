import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/Models/CompletedCourses.dart';
import 'package:etutor/Models/CompletedLessons.dart';
import 'package:etutor/Repository/DBHelper.dart';
import 'package:etutor/Views/VideoViewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LessonItem extends StatelessWidget {
  var itemno = 0;
  var lessonkey = "";

  LessonItem({Key? key, required this.itemno, required this.lessonkey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: InkWell(
        onTap: () async {
          var arr = await DBHelper.db
              .collection("Lessons")
              .where("key", isEqualTo: lessonkey)
              .get();
          var item = arr.docs[0];
          Get.to(VideoViewer(vidlink: item.get("videourl")));
          //Add Lesson
          var check = await DBHelper.db
              .collection("CompletedLessons")
              .where("userkey", isEqualTo: DBHelper.auth.currentUser!.uid)
              .get();
          var checklesson = check.docs
              .where((element) => element.get("lessonkey") == lessonkey)
              .toList();
          if (checklesson.isEmpty) {
            await DBHelper.db
                .collection("CompletedLessons")
                .add(CompletedLessons(lessonkey: lessonkey).toMap());
          }
          //Add Complete
          var courseitem = await DBHelper.db
              .collection("CourseLesson")
              .where("lessonkey", isEqualTo: lessonkey)
              .get();
          var coursekey = await courseitem.docs[0].get("coursekey");
          var courselessons = await DBHelper.db
              .collection("CourseLesson")
              .where("coursekey", isEqualTo: coursekey)
              .get();
          var arrcourse = courselessons.docs;
          var totallessons = arrcourse.length;
          var lessonkeys = arrcourse.map((e) => e.get("lessonkey")).toList();
          var completedlessons = await DBHelper.db
              .collection("CompletedLessons")
              .where("lessonkey", whereIn: lessonkeys)
              .get();
          var completedlist = completedlessons.docs.where((e) =>
          e.get("userkey") == DBHelper.auth.currentUser!.uid);
          if (completedlist.length == totallessons) {
            var check = await DBHelper.db
                .collection("CompletedCourses")
                .where("userkey", isEqualTo: DBHelper.auth.currentUser!.uid)
                .get();
            var checkcourse = check.docs
                .where((element) => element.get("coursekey") == coursekey)
                .toList();
            if (checkcourse.isEmpty) {
              await DBHelper.db
                  .collection("CompletedCourses")
                  .add(CompletedCourses(coursekey: coursekey).toMap());
            }
          }
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            leading: Icon(
              Icons.play_circle_outlined,
              color: Colors.blue.shade700,
              size: 35,
            ),
            title: StreamBuilder(
              stream: DBHelper.db
                  .collection("Lessons")
                  .where("key", isEqualTo: lessonkey)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  var current = snapshot.data!.docs[0];
                  return Text(
                    itemno.toString() + ". " + current.get("name"),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  );
                }
                return SizedBox();
              },
            ),
            trailing: StreamBuilder(
              stream: DBHelper.db
                  .collection("CompletedLessons")
                  .where("userkey", isEqualTo: DBHelper.auth.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  var arr = snapshot.data!.docs
                      .where((e) => e.get("lessonkey") == lessonkey);
                  if (arr.isNotEmpty) {
                    return Icon(
                      Icons.check_circle_outline,
                      color: Colors.blue.shade700,
                    );
                  }
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
