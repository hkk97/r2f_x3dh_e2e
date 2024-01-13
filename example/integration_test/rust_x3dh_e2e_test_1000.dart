import 'dart:convert';
import 'models/message.dart';
import 'package:flutter/services.dart';
import 'package:r2f_x3dh_e2e/models.dart';
import 'package:benchmarking/benchmarking.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:r2f_x3dh_e2e/r2f_x3dh_e2e.dart';
import 'package:integration_test/integration_test.dart';
import 'package:r2f_x3dh_e2e/src/rust/frb_generated.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async => await RustLib.init());

  test(
    'RustX3DHE2ESer-1000Msgs',
    () async {
      final messagesJson =
          await rootBundle.loadString('assets/messages_1000.json');
      final messages = jsonDecode(messagesJson) as List<dynamic>;
      final encryptionBenchmark = syncBenchmark(
        'RustX3DHE2ESer-1000Msgs',
        () async {
          for (final messageStr in messages) {
            final message = Message.fromJson(messageStr);
            final encryptedRes =
                await R2FX3DHE2ESer().encryptWithHexStringKey<EncryptedMsg>(
              x3DHKey: message.keyPair.u1SharedSecretKey,
              data: message.text,
            );

            final decryptedText = await R2FX3DHE2ESer().decryptWithHexStringKey(
              x3DHKey: message.keyPair.u1SharedSecretKey,
              ciphertext: encryptedRes.ciphertext,
              iv: encryptedRes.iv,
            );
            if (decryptedText != message.text) {
              break;
            }
          }
        },
      );
      encryptionBenchmark.report();
    },
  );
}
