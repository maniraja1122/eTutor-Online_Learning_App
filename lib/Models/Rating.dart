

class Rating{
  String userkey="";
  String coursekey="";
  double rating=0;
  String comment="";

//<editor-fold desc="Data Methods">

  Rating({
    required this.userkey,
    required this.coursekey,
    required this.rating,
    required this.comment,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rating &&
          runtimeType == other.runtimeType &&
          userkey == other.userkey &&
          coursekey == other.coursekey &&
          rating == other.rating &&
          comment == other.comment);

  @override
  int get hashCode =>
      userkey.hashCode ^
      coursekey.hashCode ^
      rating.hashCode ^
      comment.hashCode;

  @override
  String toString() {
    return 'Rating{' +
        ' userkey: $userkey,' +
        ' coursekey: $coursekey,' +
        ' rating: $rating,' +
        ' comment: $comment,' +
        '}';
  }

  Rating copyWith({
    String? userkey,
    String? coursekey,
    double? rating,
    String? comment,
  }) {
    return Rating(
      userkey: userkey ?? this.userkey,
      coursekey: coursekey ?? this.coursekey,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userkey': this.userkey,
      'coursekey': this.coursekey,
      'rating': this.rating,
      'comment': this.comment,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userkey: map['userkey'] as String,
      coursekey: map['coursekey'] as String,
      rating: map['rating'] as double,
      comment: map['comment'] as String,
    );
  }

//</editor-fold>
}