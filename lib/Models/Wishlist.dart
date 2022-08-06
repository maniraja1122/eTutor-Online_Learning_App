import 'package:etutor/Repository/DBHelper.dart';

class Wishlist{
  String userkey=DBHelper.auth.currentUser!.uid;
  String coursekey="";

//<editor-fold desc="Data Methods">

  Wishlist({
    required this.coursekey,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wishlist &&
          runtimeType == other.runtimeType &&
          userkey == other.userkey &&
          coursekey == other.coursekey);

  @override
  int get hashCode => userkey.hashCode ^ coursekey.hashCode;

  @override
  String toString() {
    return 'Wishlist{' +
        ' userkey: $userkey,' +
        ' coursekey: $coursekey,' +
        '}';
  }

  Wishlist copyWith({
    String? userkey,
    String? coursekey,
  }) {
    return Wishlist(
      coursekey: coursekey ?? this.coursekey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userkey': this.userkey,
      'coursekey': this.coursekey,
    };
  }

  factory Wishlist.fromMap(Map<String, dynamic> map) {
    return Wishlist(
      coursekey: map['coursekey'] as String,
    );
  }

//</editor-fold>
}
