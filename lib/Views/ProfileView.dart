import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/RegisterProcess/Selector.dart';
import 'package:etutor/Repository/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/ETutorIcon.dart';

class ProfileView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ETutorIcon(
          myicon: Icons.library_books,
          background: Colors.blue.shade700,
          foreground: Colors.white,
        ),
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await DBHelper.auth.signOut();
              Get.offAll(Selector());
            },
            child: ETutorIcon(
                myicon: Icons.logout,
                background: Colors.grey.shade200,
                foreground: Colors.blue.shade700),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: DBHelper.db
                .collection("Users")
                .where("key", isEqualTo: DBHelper.auth.currentUser!.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                var current = snapshot.data!.docs[0];
                return ListTile(
                  trailing: InkWell(
                    onTap: () async {
                      var picker=await ImagePicker().pickImage(source: ImageSource.gallery,maxWidth: 1800,maxHeight: 1800);
                      if(picker!=null){
                        var imgdata=await picker.readAsBytes();
                        var myref=DBHelper.storage.ref().child("Users").child(current.get("key"));
                        await myref.putData(imgdata);
                        var url=await myref.getDownloadURL();
                        await current.reference.update({
                          "MyPICUrl":url
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue.shade700,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  title: Text(
                    current.get("Name"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(current.get("Email")),
                  leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: current.get("MyPICUrl") != ""
                          ? NetworkImage(current.get("MyPICUrl"))
                          : AssetImage("assets/images/placeholder.png")
                              as ImageProvider),
                );
              }
              return SizedBox();
            },
          )
        ],
      ),
    );
  }
}
