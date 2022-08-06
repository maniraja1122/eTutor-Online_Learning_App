import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/ListItems/CourseItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Repository/DBHelper.dart';

class HomeController extends GetxController {
  var selectedButton = "All Courses".obs;
  var searchTerm="".obs;
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
          stream:DBHelper.db.collection("Course").orderBy("totalEnrollments",descending: true).snapshots(),
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
        stream: DBHelper.db.collection("Course").orderBy("key",descending: true).snapshots(),
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
}
