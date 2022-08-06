import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/Models/Wishlist.dart';
import 'package:etutor/Views/ViewCourse.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import '../Repository/DBHelper.dart';

class CourseItem extends StatelessWidget {
  QueryDocumentSnapshot snap;

  CourseItem({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(ViewCourse(snap: snap));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Container(
              decoration:BoxDecoration(borderRadius: BorderRadius.circular(20)),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                snap.get("imageurl"),
                height: 60,
                width: 60,
                fit: BoxFit.fill,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snap.get("name"),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,)
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                  stream: DBHelper.db
                      .collection("CourseLesson")
                      .where("coursekey", isEqualTo: snap.get("key"))
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      var arr = snapshot.data!.docs;
                      return Text(arr.length.toString() + " lessons",style: TextStyle(color: Colors.black),);
                    }
                    return SizedBox();
                  },
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 3,),
                    Expanded(
                      child: StreamBuilder(
                        stream: DBHelper.db
                            .collection("Rating")
                            .where("coursekey", isEqualTo: snap.get("key"))
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                          if (snapshot.hasData) {
                            var arr = snapshot.data!.docs;
                            var avg = 0.0;
                            if (arr.length > 0)
                              avg = arr
                                  .map((e) =>
                                  double.parse(e.get("rating").toString()))
                                  .average;
                            return Text(avg.toStringAsFixed(1));
                          }
                          return SizedBox();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StreamBuilder(
                  stream: DBHelper.db
                      .collection("Wishlist")
                      .where("coursekey", isEqualTo: snap.get("key"))
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      snapshot) {
                    if (snapshot.hasData) {
                      var arr = snapshot.data!.docs.where((e) =>
                      e.get("userkey") == DBHelper.auth.currentUser!.uid).toList();
                      if (arr.isEmpty) {
                        return InkWell(
                          onTap: () async {
                            await DBHelper.db.collection("Wishlist").add(Wishlist(coursekey: snap.get("key")).toMap());
                          },
                            child: Icon(Icons.favorite));
                      }
                      else{
                        return InkWell(
                          onTap: () async {
                           await arr[0].reference.delete();
                          },
                          child: Icon(Icons.favorite,color: Colors.blue.shade700,),
                        );
                      }
                    }
                    return Icon(Icons.favorite);
                  },
                ),
                Text(
                  "\$" + snap.get("price").toString(),
                  style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
