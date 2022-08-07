import 'package:etutor/Controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SelectionButtonCourse extends StatelessWidget {
  var content="";
  var selectedButton="";
  SelectionButtonCourse({Key? key,required this.content,required this.selectedButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selected;
    content==selectedButton?selected=true:selected=false;
    var _controller=Get.find<HomeController>();
    return InkWell(
      onTap: (){
        _controller.selectedCourseButton.value=content;
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
        decoration: BoxDecoration(border:Border.all(color: Colors.blue.shade700,width: 2),color: selected?Colors.blue.shade700:Colors.white,borderRadius: BorderRadius.circular(20)),
        child: Text(content,style: TextStyle(color: selected?Colors.white:Colors.blue.shade700,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
