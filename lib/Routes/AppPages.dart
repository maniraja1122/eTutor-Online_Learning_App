import 'package:etutor/RegisterProcess/Login.dart';
import 'package:etutor/RegisterProcess/Selector.dart';
import 'package:etutor/Routes/AppRoutes.dart';
import 'package:etutor/Views/HomePage.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../RegisterProcess/Signup.dart';

class AppPages {
  static var PagesList = <GetPage>[
    GetPage(name: AppRoutes.Selector, page: () => Selector()),
    GetPage(name: AppRoutes.Login, page: () => Login()),
    GetPage(name: AppRoutes.Register, page: () => Signup()),
    GetPage(name: AppRoutes.Home, page: () => HomePage()),
  ];
}
