import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/Routes/AppPages.dart';
import 'package:etutor/Routes/AppRoutes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Repository/DBHelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings=Settings(persistenceEnabled: true,cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "eTutor",
      theme: ThemeData(
          backgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(foregroundColor: Colors.black,backgroundColor: Colors.white) ,
          bottomAppBarColor:Colors.white,
          fontFamily: GoogleFonts.lato().fontFamily),
      darkTheme: ThemeData(
          backgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(foregroundColor: Colors.black,backgroundColor: Colors.white) ,
          bottomAppBarColor:Colors.white,
          fontFamily: GoogleFonts.lato().fontFamily),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.PagesList,
      initialRoute: DBHelper.auth.currentUser==null?AppRoutes.Selector:AppRoutes.Home,
    );
  }
}
