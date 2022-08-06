import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/ListItems/CourseItem.dart';
import 'package:etutor/Repository/DBHelper.dart';
import 'package:etutor/Widgets/BackBtn.dart';
import 'package:flutter/material.dart';

class wishListView extends StatelessWidget {
  const wishListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(),
        title: Text(
          "Wishlist",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: DBHelper.db
            .collection("Wishlist")
            .where("userkey", isEqualTo: DBHelper.auth.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            var arr = snapshot.data!.docs;
            if (arr.isEmpty) {
              return Center(
                child: Text(
                  "No Favourites Yet !",
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
            return ListView.builder(
              itemCount: arr.length,
              itemBuilder: (BuildContext context, int index) {
                return StreamBuilder(
                  stream: DBHelper.db
                      .collection("Course")
                      .where("key", isEqualTo: arr[index].get("coursekey"))
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasData) {
                      return CourseItem(snap: snapshot.data!.docs[0]);
                    }
                    return SizedBox();
                  },
                );
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
