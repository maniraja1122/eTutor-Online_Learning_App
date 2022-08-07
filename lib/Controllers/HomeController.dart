import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/ListItems/CourseItem.dart';
import 'package:etutor/ListItems/ProgressCourseItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Repository/DBHelper.dart';

class HomeController extends GetxController {
  var selectedButton = "All Courses".obs;
  var selectedCourseButton = "All Courses".obs;
  var searchTerm = "".obs;
  var showNavBar = true.obs;
  var barrating=1.0.obs;
  //Get List Streams
  dynamic getCourseList(String selectedButton) {
    switch (selectedButton) {
      case "All Courses":
        return StreamBuilder(
          stream: DBHelper.db.collection("Course").snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              var arr = snapshot.data!.docs;
              return ListView.builder(
                itemCount: arr.length,
                itemBuilder: (BuildContext context, int index) {
                  return CourseItem(snap: arr[index]);
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        );
      case "Popular":
        return StreamBuilder(
          stream: DBHelper.db
              .collection("Course")
              .orderBy("totalEnrollments", descending: true)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              var arr = snapshot.data!.docs;
              return ListView.builder(
                itemCount: arr.length,
                itemBuilder: (BuildContext context, int index) {
                  return CourseItem(snap: arr[index]);
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        );
      default:
        return StreamBuilder(
          stream: DBHelper.db
              .collection("Course")
              .orderBy("key", descending: true)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              var arr = snapshot.data!.docs;
              return ListView.builder(
                itemCount: arr.length,
                itemBuilder: (BuildContext context, int index) {
                  return CourseItem(snap: arr[index]);
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        );
    }
  }
  dynamic getMyCoursesList(String selected) {
    switch (selected) {
      case "All Courses":
        return StreamBuilder(
          stream: DBHelper.db
              .collection("Enrolled")
              .where("userkey", isEqualTo: DBHelper.auth.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              var arr = snapshot.data!.docs;
              if (arr.isEmpty) {
                return Center(
                  child: Text("No Courses Enrolled"),
                );
              }
              return ListView.builder(
                itemCount: arr.length,
                itemBuilder: (BuildContext context, int index) {
                    return ProgressCourseItem(coursekey: arr[index].get("coursekey"));
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      case "On Progress":
        return StreamBuilder(
          stream: DBHelper.db
              .collection("Enrolled")
              .where("userkey", isEqualTo: DBHelper.auth.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              var arr = snapshot.data!.docs;
              if (arr.isEmpty) {
                return Center(
                  child: Text("No Courses in Progress"),
                );
              }
              var enrolledlist=arr.map((e) => e.get("coursekey")).toList();
              return StreamBuilder(
                stream: DBHelper.db
                    .collection("CompletedCourses")
                    .where("userkey", isEqualTo: DBHelper.auth.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    var arr = snapshot.data!.docs;
                    var completedlist=arr.map((e) => e.get("coursekey")).toList();
                    var items=enrolledlist.where((element) => !completedlist.contains(element)).toList();
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProgressCourseItem(coursekey: items[index]);
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      case "Completed":
        return StreamBuilder(
          stream: DBHelper.db
              .collection("CompletedCourses")
              .where("userkey", isEqualTo: DBHelper.auth.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              var arr = snapshot.data!.docs;
              if (arr.isEmpty) {
                return Center(
                  child:Text("No Courses Completed !",style: TextStyle(fontSize: 18),),
                );
              }
              return ListView.builder(
                itemCount: arr.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProgressCourseItem(coursekey: arr[index].get("coursekey"));
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
    }
  }
}
