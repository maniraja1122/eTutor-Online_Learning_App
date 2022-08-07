import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/Models/Enrolled.dart';
import 'package:etutor/Models/Notifications.dart';
import 'package:etutor/Views/FullCourse.dart';
import 'package:etutor/Widgets/BackBtn.dart';
import 'package:etutor/Widgets/RoundButton.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import '../Repository/DBHelper.dart';

class ViewCourse extends StatelessWidget {
  QueryDocumentSnapshot snap;

  ViewCourse({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(),
        title: Text(
          snap.get("name"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                clipBehavior: Clip.hardEdge,
                child: Image.network(snap.get("imageurl"), fit: BoxFit.fill),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.group,
                            color: Colors.blue.shade700,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            snap.get("totalEnrollments").toString(),
                            style: TextStyle(color: Colors.blue.shade700),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.blue.shade700,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          StreamBuilder(
                            stream: DBHelper.db
                                .collection("Rating")
                                .where("coursekey", isEqualTo: snap.get("key"))
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                var arr = snapshot.data!.docs;
                                var avg = 0.0;
                                if (arr.length > 0)
                                  avg = arr
                                      .map((e) => double.parse(
                                          e.get("rating").toString()))
                                      .average;
                                return Text(
                                  avg.toStringAsFixed(1),
                                  style: TextStyle(color: Colors.blue.shade700),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    snap.get("name"),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    snap.get("desc"),
                    style: TextStyle(fontSize: 16),
                  )),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: DBHelper.db
                    .collection("CourseLesson")
                    .where("coursekey", isEqualTo: snap.get("key"))
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    var arr = snapshot.data!.docs;
                    return Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          arr.length.toString() + " Lessons",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ));
                  }
                  return SizedBox();
                },
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: DBHelper.db
                    .collection("CourseLesson")
                    .where("coursekey", isEqualTo: snap.get("key"))
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    var arr = snapshot.data!.docs;
                    var keylist = arr.map((e) => e.get("lessonkey")).toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: keylist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StreamBuilder(
                          stream: DBHelper.db
                              .collection("Lessons")
                              .where("key", isEqualTo: keylist[index])
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.hasData) {
                              var item = snapshot.data!.docs[0];
                              return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  child: ListTile(
                                    trailing: Icon(Icons.slow_motion_video_sharp,color: Colors.blue.shade700,),
                                title: Text(
                                  item.get("name"),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ));
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
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: DBHelper.db
                    .collection("Enrolled")
                    .where("userkey", isEqualTo: DBHelper.auth.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    var arr = snapshot.data!.docs.where((element) =>
                        element.get("coursekey") == snap.get("key"));
                    if (arr.isEmpty) {
                      return RoundButton(
                          text: "Enroll - \$" + snap.get("price").toString(),
                          bacground: Colors.blue.shade600,
                          foreground: Colors.white,
                          onPressed: () async {
                           await DBHelper.db.collection("Enrolled").add(Enrolled(coursekey: snap.get("key")).toMap());
                           await DBHelper.db.collection("Notifications").add(Notifications(text: "Course Successfully Enrolled "+"[${snap.get("name")}]").toMap());
                           await snap.reference.update({"totalEnrollments":snap.get("totalEnrollments")+1});
                           Get.showSnackbar(GetSnackBar(duration: Duration(seconds: 5),message: "Successfully Enrolled in "+snap.get("name").toString()),);
                          });
                    } else {
                      return RoundButton(
                          text: "Go To Course",
                          bacground: Colors.blue,
                          foreground: Colors.white,
                          onPressed: () {
                            Get.to(FullCourse(coursekey: snap.get("key"),));
                          });
                    }
                  }
                  return SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
