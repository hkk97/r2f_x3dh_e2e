// ignore_for_file: library_prefixes

library r2f_x3dh_e2e;

import 'package:r2f_x3dh_e2e/models.dart';
import 'package:r2f_x3dh_e2e/src/rust/frb_generated.dart';
import 'package:r2f_x3dh_e2e/src/rust/api/rust_x3dh_e2e.dart' as rustX3DHE2ESer;

class R2FX3DHE2ESer {
  static final R2FX3DHE2ESer _ser = R2FX3DHE2ESer.internal();

  factory R2FX3DHE2ESer() => _ser;
  R2FX3DHE2ESer.internal();

  Future<void> init() async => await RustLib.init();

  Future<T> encryptWithBytesKey<T extends EncryptedMsg>({
    required List<int> x3DHKey,
    required String data,
    bool isUniEncryptedMsg = true,
  }) async {
    final res = rustX3DHE2ESer.encryptWithBytesKey(
      sharedSecretKey: x3DHKey,
      plaintext: data,
    );
    if (T == UniEncryptedMsg) {
      // Use '==' instead of 'is'
      return UniEncryptedMsg(
        x3dhKey: X3DHKey(bytes: x3DHKey),
        ciphertext: res.$1,
        iv: res.$2,
      ) as T;
    }
    return EncryptedMsg(
      ciphertext: res.$1,
      iv: res.$2,
    ) as T;
  }

  Future<T> encryptWithHexStringKey<T extends EncryptedMsg>({
    required String x3DHKey,
    required String data,
    bool isUniEncryptedMsg = true,
  }) async {
    final res = rustX3DHE2ESer.encryptWithHexStringKey(
      sharedSecretKey: x3DHKey,
      plaintext: data,
    );
    if (T == UniEncryptedMsg) {
      // Use '==' instead of 'is's
      return UniEncryptedMsg(
        x3dhKey: X3DHKey(hexStr: x3DHKey),
        ciphertext: res.$1,
        iv: res.$2,
      ) as T;
    }
    return EncryptedMsg(
      ciphertext: res.$1,
      iv: res.$2,
    ) as T;
  }

  Future<String> decryptWithHexStringKey({
    required String x3DHKey,
    required List<int> ciphertext,
    required List<int> iv,
  }) async {
    final res = rustX3DHE2ESer.decryptWithHexStringKey(
      sharedSecretKey: x3DHKey,
      ciphertext: ciphertext,
      iv: iv,
    );
    return res;
  }
}
