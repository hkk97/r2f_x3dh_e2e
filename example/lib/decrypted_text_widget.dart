import 'dart:async';
import 'package:flutter/material.dart';
import 'package:r2f_x3dh_e2e/models.dart';
import 'package:after_layout/after_layout.dart';
import 'package:r2f_x3dh_e2e/r2f_x3dh_e2e.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:example/services/dart_x3dh_e2e_ser.dart';

class DecryptedTextWidget extends StatefulWidget {
  final int index;
  final dynamic encryptedMsg;
  final bool isRust;

  const DecryptedTextWidget({
    Key? key,
    required this.index,
    required this.encryptedMsg,
    this.isRust = true,
  }) : super(key: key);

  @override
  State<DecryptedTextWidget> createState() => DecryptedTextWidgetState();
}

class DecryptedTextWidgetState extends State<DecryptedTextWidget>
    with AfterLayoutMixin {
  late ValueNotifier<String?> _msgNotifi;

  @override
  void initState() {
    _msgNotifi = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    _msgNotifi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _msgNotifi,
      builder: (context, msg, child) {
        if (msg == null) {
          // Display a chat bubble without any text if the message is null
          return ChatBubble(
            backGroundColor: Colors.grey.shade300,
            clipper: ChatBubbleClipper9(type: BubbleType.receiverBubble),
          );
        }
        // Display a chat bubble with the decrypted message as text
        return ChatBubble(
          backGroundColor: Colors.grey.shade300,
          clipper: ChatBubbleClipper9(type: BubbleType.receiverBubble),
          child: Text(msg),
        );
      },
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    if (widget.isRust) {
      // Handle decryption for Rust-encrypted message
      await handleRustDecryption();
    } else {
      // Handle decryption for Dart-encrypted message
      await handleDartDecryption();
    }
  }

  Future<void> handleDartDecryption() async {
    // Decrypt the Dart-encrypted message using the provided key and parameters
    final dartEncryptedMsg = await DartX3DHE2ESer().decryptWithBytesKey(
      widget.encryptedMsg.x3dhKey.bytes!,
      widget.encryptedMsg.ciphertext,
      widget.encryptedMsg.iv,
      widget.encryptedMsg.mac,
    );
    // Set the decrypted message as the value for the ValueNotifier
    _msgNotifi.value = dartEncryptedMsg;
  }

  Future<void> handleRustDecryption() async {
    // Cast the encrypted message to the appropriate type for Rust decryption
    final rustEncryptedMsg = widget.encryptedMsg as UniEncryptedMsg;
    // Decrypt the Rust-encrypted message using the provided key and parameters
    final dartEncryptedMsg = await R2FX3DHE2ESer().decryptWithHexStringKey(
      x3DHKey: rustEncryptedMsg.x3dhKey.hexStr!,
      ciphertext: rustEncryptedMsg.ciphertext,
      iv: rustEncryptedMsg.iv,
    );
    // Set the decrypted message as the value for the ValueNotifier
    _msgNotifi.value = dartEncryptedMsg;
  }
}
