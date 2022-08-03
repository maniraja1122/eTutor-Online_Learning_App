
class Enrolled{
  String userkey="";
  String coursekey="";

//<editor-fold desc="Data Methods">

  Enrolled({
    required this.userkey,
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
      userkey: userkey ?? this.userkey,
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
      userkey: map['userkey'] as String,
      coursekey: map['coursekey'] as String,
    );
  }

//</editor-fold>
}