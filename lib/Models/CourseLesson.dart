
class CourseLesson{
  int key=DateTime.now().microsecondsSinceEpoch;
  String lessonkey="";
  String coursekey="";

//<editor-fold desc="Data Methods">

  CourseLesson({
    required this.lessonkey,
    required this.coursekey,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseLesson &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          lessonkey == other.lessonkey &&
          coursekey == other.coursekey);

  @override
  int get hashCode => key.hashCode ^ lessonkey.hashCode ^ coursekey.hashCode;

  @override
  String toString() {
    return 'CourseLesson{' +
        ' key: $key,' +
        ' lessonkey: $lessonkey,' +
        ' coursekey: $coursekey,' +
        '}';
  }

  CourseLesson copyWith({
    int? key,
    String? lessonkey,
    String? coursekey,
  }) {
    return CourseLesson(
      lessonkey: lessonkey ?? this.lessonkey,
      coursekey: coursekey ?? this.coursekey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'lessonkey': this.lessonkey,
      'coursekey': this.coursekey,
    };
  }

  factory CourseLesson.fromMap(Map<String, dynamic> map) {
    return CourseLesson(
      lessonkey: map['lessonkey'] as String,
      coursekey: map['coursekey'] as String,
    );
  }

//</editor-fold>
}