import 'package:etutor/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/RoundButton.dart';

class Selector extends StatelessWidget {
  const Selector({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "E-Tutor",
                style: TextStyle(color: Colors.black, fontSize: 40,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Text(
                "Your learning is our earning",
                style: TextStyle(color: Colors.black54,fontSize: 15),
              ),
              SizedBox(
                height: 300,
              ),
              RoundButton(
                text: "Login",
                bacground: Colors.white,
                foreground: Colors.black,
                onPressed: () {
                  Get.toNamed(AppRoutes.Login);
                },
              ),
              SizedBox(
                height: 10,
              ),
              RoundButton(
                text: "Sign Up",
                bacground: Colors.blue,
                foreground: Colors.white,
                onPressed: () {
                  Get.toNamed(AppRoutes.Register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}