import 'dart:convert';
import 'models/message.dart';
import 'ser/dart_x3dh_e2e_ser.dart';
import 'package:flutter/services.dart';
import 'package:benchmarking/benchmarking.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  test(
    'DartX3DHE2ESer-1000Msgs',
    () async {
      final encryptionBenchmark = syncBenchmark(
        'DartX3DHE2ESer-1000Msgs',
        () async {
          final messagesJson =
              await rootBundle.loadString('assets/messages_1000.json');
          final messages = jsonDecode(messagesJson) as List<dynamic>;
          for (final messageStr in messages) {
            final message = Message.fromJson(messageStr);
            final encryptedRes = await DartX3DHE2ESer().encryptWithStringKey(
              message.keyPair.u1SharedSecretKey,
              message.text,
            );
            final decryptedText = await DartX3DHE2ESer().decryptWithStringKey(
              message.keyPair.u2SharedSecretKey,
              encryptedRes[0],
              encryptedRes[1],
              encryptedRes[2],
            );
            if (decryptedText != message.text) {
              break;
            }
            // expect(decryptedText, message.text);
          }
        },
      );
      encryptionBenchmark.report();
    },
  );
}
