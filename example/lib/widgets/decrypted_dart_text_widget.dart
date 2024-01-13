import 'dart:async';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:example/models/dart_encrypted_msg.dart';
import 'package:example/services/dart_x3dh_e2e_ser.dart';

class DecryptedDartTextWidget extends StatefulWidget {
  final int index;
  final UniDartEncryptedMsg dartEncryptedMsg;
  const DecryptedDartTextWidget({
    super.key,
    required this.index,
    required this.dartEncryptedMsg,
  });

  @override
  State<DecryptedDartTextWidget> createState() =>
      DecryptedDartTextWidgetState();
}

class DecryptedDartTextWidgetState extends State<DecryptedDartTextWidget>
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
    final dartEncryptedMsg = await DartX3DHE2ESer().decryptWithBytesKey(
      widget.dartEncryptedMsg.x3dhKey.bytes!,
      widget.dartEncryptedMsg.ciphertext,
      widget.dartEncryptedMsg.iv,
      widget.dartEncryptedMsg.mac,
    );
    _msgNotifi.value = dartEncryptedMsg;
  }
}
