class Course{
  String key=DateTime.now().microsecondsSinceEpoch.toString();
  String name="";
  String desc="";
  double price=0;
  String imageurl="";

//<editor-fold desc="Data Methods">

  Course({
    required this.name,
    required this.desc,
    required this.price,
    required this.imageurl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          name == other.name &&
          desc == other.desc &&
          price == other.price &&
          imageurl == other.imageurl);

  @override
  int get hashCode =>
      key.hashCode ^
      name.hashCode ^
      desc.hashCode ^
      price.hashCode ^
      imageurl.hashCode;

  @override
  String toString() {
    return 'Course{' +
        ' key: $key,' +
        ' name: $name,' +
        ' desc: $desc,' +
        ' price: $price,' +
        ' imageurl: $imageurl,' +
        '}';
  }

  Course copyWith({
    String? key,
    String? name,
    String? desc,
    double? price,
    String? imageurl,
  }) {
    return Course(
      name: name ?? this.name,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      imageurl: imageurl ?? this.imageurl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'name': this.name,
      'desc': this.desc,
      'price': this.price,
      'imageurl': this.imageurl,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      name: map['name'] as String,
      desc: map['desc'] as String,
      price: map['price'] as double,
      imageurl: map['imageurl'] as String,
    );
  }

//</editor-fold>
}
