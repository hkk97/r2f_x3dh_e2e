import 'package:r2f_x3dh_e2e/models.dart';

class UniDartEncryptedMsg extends DartEncryptedMsg {
  final X3DHKey x3dhKey;

  UniDartEncryptedMsg({
    required super.ciphertext,
    required super.iv,
    required super.mac,
    required this.x3dhKey,
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
  final List<int> ciphertext;
  final List<int> iv;
  final List<int> mac;

  DartEncryptedMsg({
    required this.ciphertext,
    required this.iv,
    required this.mac,
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
