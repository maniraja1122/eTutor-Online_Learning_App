import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/Controllers/HomeController.dart';
import 'package:etutor/ListItems/CourseItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../Repository/DBHelper.dart';

class SearchView extends GetView {



  @override
  Widget build(BuildContext context) {
    var _controller=Get.find<HomeController>();
    var keycontroller=KeyboardVisibilityController();
    keycontroller.onChange.listen((visible) {
      _controller.showNavBar.value=!visible;
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: TextField(
              onChanged: (val){
                  _controller.searchTerm.value=val;
              },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    suffixIcon: Icon(Icons.search),
                    hintText: "Search Courses Here")),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: DBHelper.db.collection("Course").snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return Obx((){
              var items= snapshot.data!.docs;
              var arr =items.where((e) => e.get("name").toString().toLowerCase().contains(_controller.searchTerm.value.toLowerCase())).toList();
              return ListView.builder(
                itemCount: arr.length,
                itemBuilder: (BuildContext context, int index) {
                  return CourseItem(snap: arr[index]);
                },
              );
            });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
