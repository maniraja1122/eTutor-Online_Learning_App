import '../Repository/DBHelper.dart';

class CompletedLessons{
  String userkey=DBHelper.auth.currentUser!.uid;
  String lessonkey="";

//<editor-fold desc="Data Methods">

  CompletedLessons({
    required this.lessonkey,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompletedLessons &&
          runtimeType == other.runtimeType &&
          userkey == other.userkey &&
          lessonkey == other.lessonkey);

  @override
  int get hashCode => userkey.hashCode ^ lessonkey.hashCode;

  @override
  String toString() {
    return 'CompletedLessons{' +
        ' userkey: $userkey,' +
        ' lessonkey: $lessonkey,' +
        '}';
  }

  CompletedLessons copyWith({
    String? userkey,
    String? lessonkey,
  }) {
    return CompletedLessons(
      lessonkey: lessonkey ?? this.lessonkey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userkey': this.userkey,
      'lessonkey': this.lessonkey,
    };
  }

  factory CompletedLessons.fromMap(Map<String, dynamic> map) {
    return CompletedLessons(
      lessonkey: map['lessonkey'] as String,
    );
  }

//</editor-fold>
}