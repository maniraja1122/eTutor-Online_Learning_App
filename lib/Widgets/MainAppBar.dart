import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/Repository/DBHelper.dart';
import 'package:etutor/Routes/AppRoutes.dart';
import 'package:etutor/Widgets/ETutorIcon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: ETutorIcon(
        myicon: Icons.library_books,
        background: Colors.blue.shade700,
        foreground: Colors.white,
      ),
      title: StreamBuilder(
        stream: DBHelper.db
            .collection("Users")
            .where("key", isEqualTo: DBHelper.auth.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            var username = snapshot.data!.docs[0].get("Name").toString();
            return Text("Hello, " + username.split(" ").first + " !",style: TextStyle(fontWeight: FontWeight.bold),);
          }
          return Text("");
        },
      ),
      actions: [
        InkWell(
          onTap: (){
            Get.toNamed(AppRoutes.ViewNotifications);
          },
          child: ETutorIcon(
              myicon: Icons.notifications, background: Colors.grey.shade200, foreground: Colors.blue.shade700),
        ),
        InkWell(onTap: (){
          Get.toNamed(AppRoutes.WishList);
        },
            child: ETutorIcon(myicon: Icons.favorite, background: Colors.grey.shade200, foreground: Colors.blue.shade700))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
