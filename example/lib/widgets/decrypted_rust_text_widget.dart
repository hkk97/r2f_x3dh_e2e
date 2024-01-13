import 'dart:async';
import 'package:flutter/material.dart';
import 'package:r2f_x3dh_e2e/models.dart';
import 'package:r2f_x3dh_e2e/r2f_x3dh_e2e.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class DecryptedRustTextWidget extends StatefulWidget {
  final int index;
  final UniEncryptedMsg dartEncryptedMsg;
  const DecryptedRustTextWidget({
    super.key,
    required this.index,
    required this.dartEncryptedMsg,
  });

  @override
  State<DecryptedRustTextWidget> createState() =>
      DecryptedRustTextWidgetState();
}

class DecryptedRustTextWidgetState extends State<DecryptedRustTextWidget>
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
  Widget build(context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _msgNotifi,
      builder: (context, msg, child) {
        if (msg == null) {
          return ChatBubble(
            backGroundColor: Colors.grey.shade300,
            clipper: ChatBubbleClipper9(type: BubbleType.receiverBubble),
          );
        }
        return ChatBubble(
          backGroundColor: Colors.grey.shade300,
          clipper: ChatBubbleClipper9(type: BubbleType.receiverBubble),
          child: Text(msg),
        );
      },
    );
  }

  @override
  FutureOr<void> afterFirstLayout(context) async {
    final dartEncryptedMsg = await R2FX3DHE2ESer().decryptWithHexStringKey(
      x3DHKey: widget.dartEncryptedMsg.x3dhKey.hexStr!,
      ciphertext: widget.dartEncryptedMsg.ciphertext,
      iv: widget.dartEncryptedMsg.iv,
    );
    _msgNotifi.value = dartEncryptedMsg;
  }
}
