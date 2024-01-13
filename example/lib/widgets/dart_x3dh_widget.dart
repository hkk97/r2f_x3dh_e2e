import 'dart:async';
import 'package:flutter/material.dart';
import 'package:example/enum/enum.dart';
import 'package:example/models/message.dart';
import 'package:example/decrypted_text_widget.dart';
import 'package:smooth_list_view/smooth_list_view.dart';
import 'package:example/models/dart_encrypted_msg.dart';
import 'package:example/services/dart_x3dh_e2e_ser.dart';
import 'package:example/models/testing_result_status.dart';

class DartX3dhWidget extends StatefulWidget {
  final List<Message> messages;
  const DartX3dhWidget({super.key, required this.messages});

  @override
  State<DartX3dhWidget> createState() => DartX3dhWidgetState();
}

class DartX3dhWidgetState extends State<DartX3dhWidget> {
  late ScrollController
      _scrollContlr; // Scroll controller for managing scrolling behavior
  late List<UniDartEncryptedMsg>
      _encryptedMsgs; // List to store encrypted messages
  late ValueNotifier<TestinStatus>
      _testStatusNotifi; // Notifier for testing status

  @override
  void initState() {
    _testStatusNotifi = ValueNotifier(
      // Initializing test status notifier
      TestinStatus(testStatus: TestStatus.idle),
    );
    _scrollContlr = ScrollController(); // Initializing scroll controller
    _encryptedMsgs = []; // Initializing encrypted messages list
    super.initState();
  }

  @override
  void dispose() {
    _scrollContlr.dispose(); // Disposing of scroll controller
    _testStatusNotifi.dispose(); // Disposing of test status notifier
    super.dispose();
  }

  // Mocking the process of encrypting data received from the server and storing it locally
  Future<void> encryptMsg() async {
    for (int i = 0; i < widget.messages.length; i++) {
      final msg = widget.messages[i];
      final dartEncryptedMsg = await DartX3DHE2ESer().encryptWithStringKey(
        msg.keyPair.u1SharedSecretKey,
        msg.text,
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
                          return DecryptedTextWidget(
                            index: index + 1,
                            isRust: false,
                            encryptedMsg: _encryptedMsgs[index],
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
