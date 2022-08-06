import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Repository/DBHelper.dart';

class PromotionItem extends StatelessWidget {
  QueryDocumentSnapshot snap;
  PromotionItem({Key? key,required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Image.network(snap.get("imageurl"),fit: BoxFit.fill,),
    );
  }
}
