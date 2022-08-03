import 'dart:ffi';

class Users {
  String key = "";
  String Name = "NA";
  String Email = "NA";
  String Password = "NA";
  String MyPICUrl = "";

//<editor-fold desc="Data Methods">

  Users({
    required this.key,
    required this.Name,
    required this.Email,
    required this.Password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Users &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          Name == other.Name &&
          Email == other.Email &&
          Password == other.Password &&
          MyPICUrl == other.MyPICUrl);

  @override
  int get hashCode =>
      key.hashCode ^
      Name.hashCode ^
      Email.hashCode ^
      Password.hashCode ^
      MyPICUrl.hashCode;

  @override
  String toString() {
    return 'Users{' +
        ' key: $key,' +
        ' Name: $Name,' +
        ' Email: $Email,' +
        ' Password: $Password,' +
        ' MyPICUrl: $MyPICUrl,' +
        '}';
  }

  Users copyWith({
    String? key,
    String? Name,
    String? Email,
    String? Password,
    String? MyPICUrl,
  }) {
    return Users(
      key: key ?? this.key,
      Name: Name ?? this.Name,
      Email: Email ?? this.Email,
      Password: Password ?? this.Password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'Name': this.Name,
      'Email': this.Email,
      'Password': this.Password,
      'MyPICUrl': this.MyPICUrl,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      key: map['key'] as String,
      Name: map['Name'] as String,
      Email: map['Email'] as String,
      Password: map['Password'] as String,
    );
  }

//</editor-fold>
}












