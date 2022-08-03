
class Notifications{
  int key=DateTime.now().microsecondsSinceEpoch;
  String userkey="";
  String text="";

//<editor-fold desc="Data Methods">

  Notifications({
    required this.userkey,
    required this.text,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notifications &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          userkey == other.userkey &&
          text == other.text);

  @override
  int get hashCode => key.hashCode ^ userkey.hashCode ^ text.hashCode;

  @override
  String toString() {
    return 'Notifications{' +
        ' key: $key,' +
        ' userkey: $userkey,' +
        ' text: $text,' +
        '}';
  }

  Notifications copyWith({
    int? key,
    String? userkey,
    String? text,
  }) {
    return Notifications(
      userkey: userkey ?? this.userkey,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'userkey': this.userkey,
      'text': this.text,
    };
  }

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      userkey: map['userkey'] as String,
      text: map['text'] as String,
    );
  }

//</editor-fold>
}