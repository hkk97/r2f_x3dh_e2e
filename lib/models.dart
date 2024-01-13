import 'dart:typed_data';

// This class represents a shared secret key used in the X3DH protocol.
class X3DHKey {
  final String? hexStr; // The key represented as a hexadecimal string.
  final List<int>? bytes; // The key represented as a list of integers.

  X3DHKey({this.hexStr, this.bytes});

  // Converts the X3DHKey object to a JSON representation.
  Map<String, dynamic> toJson() => {'hexStr': hexStr, 'bytes': bytes};

  // Creates an X3DHKey object from a JSON representation.
  factory X3DHKey.fromJson(Map<String, dynamic> json) => X3DHKey(
        hexStr: json['hexStr'],
        bytes: json['bytes'],
      );
}

// This class represents a uni-directional encrypted message.
class UniEncryptedMsg extends EncryptedMsg {
  final X3DHKey x3dhKey; // The X3DH key associated with the message.

  UniEncryptedMsg({
    required Uint8List ciphertext,
    required Uint8List iv,
    required this.x3dhKey,
  }) : super(ciphertext: ciphertext, iv: iv);

  // Converts the UniEncryptedMsg object to a JSON representation.
  @override
  Map<String, dynamic> toJson() => {
        'ciphertext': ciphertext,
        'iv': iv,
        'x3dhKey': x3dhKey,
      };

  // Creates a UniEncryptedMsg object from a JSON representation.
  factory UniEncryptedMsg.fromJson(Map<String, dynamic> json) =>
      UniEncryptedMsg(
        ciphertext: json['ciphertext'],
        iv: json['iv'],
        x3dhKey: X3DHKey.fromJson(json['x3dhKey']),
      );
}

// This class represents an encrypted message.
class EncryptedMsg {
  final Uint8List ciphertext; // The encrypted data.
  final Uint8List iv; // The initialization vector used for encryption.

  EncryptedMsg({
    required this.ciphertext,
    required this.iv,
  });

  // Converts the EncryptedMsg object to a JSON representation.
  Map<String, dynamic> toJson() => {
        'ciphertext': ciphertext,
        'iv': iv,
      };

  // Creates an EncryptedMsg object from a JSON representation.
  factory EncryptedMsg.fromJson(Map<String, dynamic> json) => EncryptedMsg(
        ciphertext: json['ciphertext'],
        iv: json['iv'],
      );
}
