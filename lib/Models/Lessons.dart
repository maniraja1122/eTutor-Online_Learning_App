

class Lessons{
  String key=DateTime.now().microsecondsSinceEpoch.toString();
  String name="";
  String videourl="";

//<editor-fold desc="Data Methods">

  Lessons({
    required this.name,
    required this.videourl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lessons &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          name == other.name &&
          videourl == other.videourl);

  @override
  int get hashCode => key.hashCode ^ name.hashCode ^ videourl.hashCode;

  @override
  String toString() {
    return 'Lessons{' +
        ' key: $key,' +
        ' name: $name,' +
        ' videourl: $videourl,' +
        '}';
  }

  Lessons copyWith({
    String? key,
    String? name,
    String? videourl,
  }) {
    return Lessons(
      name: name ?? this.name,
      videourl: videourl ?? this.videourl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'name': this.name,
      'videourl': this.videourl,
    };
  }

  factory Lessons.fromMap(Map<String, dynamic> map) {
    return Lessons(
      name: map['name'] as String,
      videourl: map['videourl'] as String,
    );
  }

//</editor-fold>
}