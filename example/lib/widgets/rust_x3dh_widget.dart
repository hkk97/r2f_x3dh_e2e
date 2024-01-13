import 'dart:async';
import 'package:flutter/material.dart';
import 'package:example/enum/enum.dart';
import 'package:r2f_x3dh_e2e/models.dart';
import 'package:example/models/message.dart';
import 'package:r2f_x3dh_e2e/r2f_x3dh_e2e.dart';
import 'package:smooth_list_view/smooth_list_view.dart';
import 'package:example/models/testing_result_status.dart';
import 'package:example/widgets/decrypted_rust_text_widget.dart';

class RustX3dhWidget extends StatefulWidget {
  final List<Message> messages;
  const RustX3dhWidget({super.key, required this.messages});

  @override
  State<RustX3dhWidget> createState() => RustX3dhWidgetState();
}

class RustX3dhWidgetState extends State<RustX3dhWidget> {
  late ScrollController _scrollContlr;
  late List<UniEncryptedMsg> _encryptedMsgs;
  late ValueNotifier<TestinStatus> _testStatusNotifi;

  @override
  void initState() {
    _testStatusNotifi = ValueNotifier(
      TestinStatus(testStatus: TestStatus.idle),
    );
    _scrollContlr = ScrollController();
    _encryptedMsgs = [];
    super.initState();
  }

  @override
  void dispose() {
    _scrollContlr.dispose();
    _testStatusNotifi.dispose();
    super.dispose();
  }

  // Mocking the process of encrypting data received from the server and storing it locally
  Future<void> encryptMsg() async {
    for (int i = 0; i < widget.messages.length; i++) {
      final msg = widget.messages[i];
      final dartEncryptedMsg =
          await R2FX3DHE2ESer().encryptWithHexStringKey<UniEncryptedMsg>(
        x3DHKey: msg.keyPair.u1SharedSecretKey,
        data: msg.text,
      );
      _encryptedMsgs.add(dartEncryptedMsg);
    }
  }

  @override
  Widget build(context) {
    return ValueListenableBuilder<TestinStatus>(
      valueListenable: _testStatusNotifi,
      builder: (context, testStatus, child) {
        switch (testStatus.testStatus) {
          case TestStatus.completed:
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 4, top: 8, left: 4, bottom: 12.0),
                    child: Scrollbar(
                      thickness: 4,
                      radius: const Radius.circular(4.0),
                      interactive: true,
                      thumbVisibility: true,
                      controller: _scrollContlr,
                      child: SmoothListView.builder(
                        reverse: true,
                        controller: _scrollContlr,
                        duration: const Duration(milliseconds: 250),
                        itemCount: _encryptedMsgs.length,
                        addAutomaticKeepAlives: true,
                        itemBuilder: (context, index) {
                          return DecryptedRustTextWidget(
                            index: index + 1,
                            dartEncryptedMsg: _encryptedMsgs[index],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      for (int i = 3; i >= 1; i--) {
                        await _scrollContlr.animateTo(
                          _scrollContlr.position.maxScrollExtent,
                          duration: Duration(seconds: 5 * i),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    child: const Text(
                      "Move to top",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          case TestStatus.processing:
            return const SizedBox(
              child: CircularProgressIndicator(),
            );
          case TestStatus.idle:
          default:
            return Center(
              child: ElevatedButton(
                onPressed: () async {
                  _testStatusNotifi.value = _testStatusNotifi.value.update(
                    startAt: DateTime.now(),
                    testStatus: TestStatus.processing,
                  );
                  await encryptMsg().whenComplete(() {
                    setState(() {
                      _testStatusNotifi.value = _testStatusNotifi.value.update(
                        completedAt: DateTime.now(),
                        testStatus: TestStatus.completed,
                      );
                    });
                  });
                },
                child: const Text(
                  "Start",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
