

import '../Repository/DBHelper.dart';

class Rating{
  String userkey=DBHelper.auth.currentUser!.uid;
  String coursekey="";
  double rating=0;

//<editor-fold desc="Data Methods">

  Rating({
    required this.coursekey,
    required this.rating,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rating &&
          runtimeType == other.runtimeType &&
          userkey == other.userkey &&
          coursekey == other.coursekey &&
          rating == other.rating);

  @override
  int get hashCode =>
      userkey.hashCode ^
      coursekey.hashCode ^
      rating.hashCode;

  @override
  String toString() {
    return 'Rating{' +
        ' userkey: $userkey,' +
        ' coursekey: $coursekey,' +
        ' rating: $rating,' +
        '}';
  }

  Rating copyWith({
    String? userkey,
    String? coursekey,
    double? rating,
  }) {
    return Rating(
      coursekey: coursekey ?? this.coursekey,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userkey': this.userkey,
      'coursekey': this.coursekey,
      'rating': this.rating,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      coursekey: map['coursekey'] as String,
      rating: map['rating'] as double,
    );
  }

//</editor-fold>
}