import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:r2f_x3dh_e2e/models.dart';
import 'package:cryptography/cryptography.dart';
import 'package:example/models/dart_encrypted_msg.dart';

class DartX3DHE2ESer {
  static final DartX3DHE2ESer _ser = DartX3DHE2ESer.internal();
  factory DartX3DHE2ESer() => _ser;

  DartX3DHE2ESer.internal();

  // Convert a hex string to a list of bytes
  List<int> hexStringToBytes(String hexString) => hex.decode(hexString);

  // Perform the encryption process using AES-GCM with a 256-bit key
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

  // Encrypt the plaintext using a shared secret key provided as a hex string
  Future<UniDartEncryptedMsg> encryptWithStringKey(
    String sharedSecretKey,
    String plaintext,
  ) async {
    final key = hexStringToBytes(sharedSecretKey);
    return await performEncryption(key, plaintext);
  }

  // Encrypt the plaintext using a shared secret key provided as a list of bytes
  Future<UniDartEncryptedMsg> encryptWithBytesKey(
    List<int> sharedSecretKey,
    String plaintext,
  ) async =>
      await performEncryption(sharedSecretKey, plaintext);

  // Decrypt the ciphertext using a shared secret key provided as a hex string
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

  // Decrypt the ciphertext using a shared secret key provided as a list of bytes
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
