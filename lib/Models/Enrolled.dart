
import '../Repository/DBHelper.dart';

class Enrolled{
  String userkey=DBHelper.auth.currentUser!.uid;
  String coursekey="";

//<editor-fold desc="Data Methods">

  Enrolled({
    required this.coursekey,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Enrolled &&
          runtimeType == other.runtimeType &&
          userkey == other.userkey &&
          coursekey == other.coursekey);

  @override
  int get hashCode => userkey.hashCode ^ coursekey.hashCode;

  @override
  String toString() {
    return 'Enrolled{' +
        ' userkey: $userkey,' +
        ' coursekey: $coursekey,' +
        '}';
  }

  Enrolled copyWith({
    String? userkey,
    String? coursekey,
  }) {
    return Enrolled(
      coursekey: coursekey ?? this.coursekey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userkey': this.userkey,
      'coursekey': this.coursekey,
    };
  }

  factory Enrolled.fromMap(Map<String, dynamic> map) {
    return Enrolled(
      coursekey: map['coursekey'] as String,
    );
  }

//</editor-fold>
}