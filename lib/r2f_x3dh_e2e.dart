// ignore_for_file: library_prefixes

// The library prefix 'r2f_x3dh_e2e' is used to import the library and its models.
library r2f_x3dh_e2e;

import 'package:r2f_x3dh_e2e/models.dart';
import 'package:r2f_x3dh_e2e/src/rust/frb_generated.dart';
import 'package:r2f_x3dh_e2e/src/rust/api/rust_x3dh_e2e.dart' as rustX3DHE2ESer;

// This class provides the encryption and decryption functionality.
class R2FX3DHE2ESer {
  static final R2FX3DHE2ESer _ser = R2FX3DHE2ESer.internal();

  // This private constructor is used to implement the singleton pattern.
  factory R2FX3DHE2ESer() => _ser;
  R2FX3DHE2ESer.internal();

  // Initializes the Rust library for encryption and decryption.
  Future<void> init() async => await RustLib.init();

  // Encrypts data using a shared secret key represented as a list of integers.
  // Returns an instance of the specified 'EncryptedMsg' type.
  Future<T> encryptWithBytesKey<T extends EncryptedMsg>({
    required List<int> x3DHKey,
    required String data,
    bool isUniEncryptedMsg = true,
  }) async {
    // Calls the Rust function to encrypt the data using the shared secret key.
    final res = rustX3DHE2ESer.encryptWithBytesKey(
      sharedSecretKey: x3DHKey,
      plaintext: data,
    );

    if (T == UniEncryptedMsg) {
      // If the specified type is 'UniEncryptedMsg', create an instance of it with the encrypted data and key.
      return UniEncryptedMsg(
        x3dhKey: X3DHKey(bytes: x3DHKey),
        ciphertext: res.$1,
        iv: res.$2,
      ) as T;
    }

    // Otherwise, create an instance of 'EncryptedMsg' with the encrypted data.
    return EncryptedMsg(
      ciphertext: res.$1,
      iv: res.$2,
    ) as T;
  }

  // Encrypts data using a shared secret key represented as a hexadecimal string.
  // Returns an instance of the specified 'EncryptedMsg' type.
  Future<T> encryptWithHexStringKey<T extends EncryptedMsg>({
    required String x3DHKey,
    required String data,
    bool isUniEncryptedMsg = true,
  }) async {
    // Calls the Rust function to encrypt the data using the shared secret key represented as a hexadecimal string.
    final res = rustX3DHE2ESer.encryptWithHexStringKey(
      sharedSecretKey: x3DHKey,
      plaintext: data,
    );

    if (T == UniEncryptedMsg) {
      // If the specified type is 'UniEncryptedMsg', create an instance of it with the encrypted data and key.
      return UniEncryptedMsg(
        x3dhKey: X3DHKey(hexStr: x3DHKey),
        ciphertext: res.$1,
        iv: res.$2,
      ) as T;
    }

    // Otherwise, create an instance of 'EncryptedMsg' with the encrypted data.
    return EncryptedMsg(
      ciphertext: res.$1,
      iv: res.$2,
    ) as T;
  }

  // Decrypts a message using a shared secret key represented as a hexadecimal string.
  // Returns the decrypted data as a string.
  Future<String> decryptWithHexStringKey({
    required String x3DHKey,
    required List<int> ciphertext,
    required List<int> iv,
  }) async {
    // Calls the Rust function to decrypt the message using the shared secret key represented as a hexadecimal string.
    final res = rustX3DHE2ESer.decryptWithHexStringKey(
      sharedSecretKey: x3DHKey,
      ciphertext: ciphertext,
      iv: iv,
    );

    // Returns the decrypted data.
    return res;
  }
}
