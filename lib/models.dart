import 'dart:typed_data';

class X3DHKey {
  final String? hexStr;
  final List<int>? bytes;

  X3DHKey({this.hexStr, this.bytes});

  Map<String, dynamic> toJson() => {'hexStr': hexStr, 'bytes': bytes};
  factory X3DHKey.fromJson(Map<String, dynamic> json) => X3DHKey(
        hexStr: json['hexStr'],
        bytes: json['bytes'],
      );
}

class UniEncryptedMsg extends EncryptedMsg {
  final X3DHKey x3dhKey;

  UniEncryptedMsg({
    required super.ciphertext,
    required super.iv,
    required this.x3dhKey,
  });

  @override
  Map<String, dynamic> toJson() => {
        'ciphertext': ciphertext,
        'iv': iv,
        'x3dhKey': x3dhKey,
      };

  factory UniEncryptedMsg.fromJson(Map<String, dynamic> json) =>
      UniEncryptedMsg(
        ciphertext: json['ciphertext'],
        iv: json['iv'],
        x3dhKey: X3DHKey.fromJson(json['x3dhKey']),
      );
}

class EncryptedMsg {
  final Uint8List ciphertext;
  final Uint8List iv;

  EncryptedMsg({
    required this.ciphertext,
    required this.iv,
  });

  Map<String, dynamic> toJson() => {
        'ciphertext': ciphertext,
        'iv': iv,
      };

  factory EncryptedMsg.fromJson(Map<String, dynamic> json) => EncryptedMsg(
        ciphertext: json['ciphertext'],
        iv: json['iv'],
      );
}
