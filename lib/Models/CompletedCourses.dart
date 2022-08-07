

import 'package:etutor/Repository/DBHelper.dart';

class CompletedCourses{
  String userkey=DBHelper.auth.currentUser!.uid;
  String coursekey="";

//<editor-fold desc="Data Methods">

  CompletedCourses({
    required this.coursekey,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompletedCourses &&
          runtimeType == other.runtimeType &&
          userkey == other.userkey &&
          coursekey == other.coursekey);

  @override
  int get hashCode => userkey.hashCode ^ coursekey.hashCode;

  @override
  String toString() {
    return 'CompletedCourses{' +
        ' userkey: $userkey,' +
        ' coursekey: $coursekey,' +
        '}';
  }

  CompletedCourses copyWith({
    String? userkey,
    String? coursekey,
  }) {
    return CompletedCourses(
      coursekey: coursekey ?? this.coursekey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userkey': this.userkey,
      'coursekey': this.coursekey,
    };
  }

  factory CompletedCourses.fromMap(Map<String, dynamic> map) {
    return CompletedCourses(
      coursekey: map['coursekey'] as String,
    );
  }

//</editor-fold>
}