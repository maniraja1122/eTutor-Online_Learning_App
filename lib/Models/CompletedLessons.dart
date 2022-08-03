class CompletedLessons{
  String userkey="";
  String lessonkey="";

//<editor-fold desc="Data Methods">

  CompletedLessons({
    required this.userkey,
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
      userkey: userkey ?? this.userkey,
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
      userkey: map['userkey'] as String,
      lessonkey: map['lessonkey'] as String,
    );
  }

//</editor-fold>
}