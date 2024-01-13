import 'package:r2f_x3dh_e2e/models.dart';

class UniDartEncryptedMsg extends DartEncryptedMsg {
  final X3DHKey x3dhKey; // The X3DHKey associated with the encrypted message

  UniDartEncryptedMsg({
    required super.ciphertext, // The encrypted message's ciphertext inherited from DartEncryptedMsg
    required super.iv, // The initialization vector inherited from DartEncryptedMsg
    required super.mac, // The message authentication code inherited from DartEncryptedMsg
    required this.x3dhKey, // The X3DHKey associated with the encrypted message
  });

  @override
  Map<String, dynamic> toJson() => {
        'ciphertext': ciphertext,
        'iv': iv,
        'x3dhKey': x3dhKey,
      };

  factory UniDartEncryptedMsg.fromJson(Map<String, dynamic> json) =>
      UniDartEncryptedMsg(
        ciphertext: json['ciphertext'],
        iv: json['iv'],
        mac: json['mac'],
        x3dhKey: X3DHKey.fromJson(json['x3dhKey']),
      );
}

class DartEncryptedMsg {
  final List<int> ciphertext; // The encrypted message's ciphertext
  final List<int> iv; // The initialization vector
  final List<int> mac; // The message authentication code

  DartEncryptedMsg({
    required this.ciphertext, // The encrypted message's ciphertext
    required this.iv, // The initialization vector
    required this.mac, // The message authentication code
  });

  Map<String, dynamic> toJson() => {
        'ciphertext': ciphertext,
        'iv': iv,
        'mac': mac,
      };

  factory DartEncryptedMsg.fromJson(Map<String, dynamic> json) =>
      DartEncryptedMsg(
        ciphertext: json['ciphertext'],
        iv: json['iv'],
        mac: json['mac'],
      );
}
