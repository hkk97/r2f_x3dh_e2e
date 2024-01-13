import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:example/models/dart_encrypted_msg.dart';
import 'package:r2f_x3dh_e2e/models.dart';

class DartX3DHE2ESer {
  static final DartX3DHE2ESer _ser = DartX3DHE2ESer.internal();
  factory DartX3DHE2ESer() => _ser;

  DartX3DHE2ESer.internal();

  List<int> hexStringToBytes(String hexString) => hex.decode(hexString);

  Future<UniDartEncryptedMsg> performEncryption(
    List<int> key,
    String plaintext,
  ) async {
    final cipher = AesGcm.with256bits();
    final secretKey = SecretKey(key);
    final secretBox = await cipher.encryptString(
      plaintext,
      secretKey: secretKey,
    );
    return UniDartEncryptedMsg(
      ciphertext: secretBox.cipherText,
      iv: secretBox.nonce,
      mac: secretBox.mac.bytes,
      x3dhKey: X3DHKey(bytes: key),
    );
  }

  Future<UniDartEncryptedMsg> encryptWithStringKey(
    String sharedSecretKey,
    String plaintext,
  ) async {
    final key = hexStringToBytes(sharedSecretKey);
    return await performEncryption(key, plaintext);
  }

  Future<UniDartEncryptedMsg> encryptWithBytesKey(
    List<int> sharedSecretKey,
    String plaintext,
  ) async =>
      await performEncryption(sharedSecretKey, plaintext);

  Future<String> decryptWithStringKey(
    String sharedSecretKey,
    List<int> ciphertext,
    List<int> iv,
    List<int> mac,
  ) async {
    final sharedSecretBytesKey = hexStringToBytes(sharedSecretKey);
    final secretKey = SecretKey(sharedSecretBytesKey);
    final cipher = AesGcm.with256bits();

    final secretBox = SecretBox(
      ciphertext,
      nonce: iv,
      mac: Mac(mac),
    );
    final decryptedBytes =
        await cipher.decrypt(secretBox, secretKey: secretKey);
    final decryptedText = utf8.decode(decryptedBytes);
    return decryptedText;
  }

  Future<String> decryptWithBytesKey(
    List<int> sharedSecretKey,
    List<int> ciphertext,
    List<int> iv,
    List<int> mac,
  ) async {
    final secretKey = SecretKey(sharedSecretKey);
    final cipher = AesGcm.with256bits();

    final secretBox = SecretBox(
      ciphertext,
      nonce: iv,
      mac: Mac(mac),
    );
    final decryptedBytes =
        await cipher.decrypt(secretBox, secretKey: secretKey);
    final decryptedText = utf8.decode(decryptedBytes);
    return decryptedText;
  }
}
