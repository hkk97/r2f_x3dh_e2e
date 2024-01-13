import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/models/message.dart';
import 'package:after_layout/after_layout.dart';
import 'package:example/widgets/dart_x3dh_widget.dart';
import 'package:example/widgets/rust_x3dh_widget.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App>
    with WidgetsBindingObserver, AfterLayoutMixin {
  late ValueNotifier<List<Message>?> _msgNotifi;
  late List<Widget> tabs;
  late List<Widget> tabbarViews;

  @override
  void initState() {
    super.initState();
    _msgNotifi = ValueNotifier(null);
    tabs = const [
      Tab(icon: Text("Pure-Dart")),
      Tab(icon: Text("Rust-to-Dart"))
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _msgNotifi.dispose();
  }

  @override
  Widget build(context) {
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('X3DH-E2E-TESTING'),
            centerTitle: true,
            bottom: TabBar(
              tabs: tabs,
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: ValueListenableBuilder<List<Message>?>(
                  valueListenable: _msgNotifi,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          "Loading Messages",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  builder: (context, msgs, child) {
                    if (msgs == null) {
                      return child!;
                    }
                    return TabBarView(
                      children: [
                        DartX3dhWidget(messages: msgs),
                        RustX3dhWidget(messages: msgs),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(context) async {
    await Future.delayed(
      const Duration(seconds: 1),
      () async {
        final messagesJson =
            await rootBundle.loadString('assets/messages_1000.json');
        final decodedJson = jsonDecode(messagesJson) as List<dynamic>;
        final messages =
            decodedJson.map((value) => Message.fromJson(value)).toList();
        _msgNotifi.value = messages;
      },
    );

    // for (final messageStr in messages) {
    //   final message = Message.fromJson(messageStr);
    //   final encryptedRes =
    //       await R2FX3DHE2ESer().encryptWithHexStringKey<EncryptedMsg>(
    //     x3DHKey: message.keyPair.u1SharedSecretKey,
    //     data: message.text,
    //   );

    //   final decryptedText = await R2FX3DHE2ESer().decryptWithHexStringKey(
    //     x3DHKey: message.keyPair.u1SharedSecretKey,
    //     ciphertext: encryptedRes.ciphertext,
    //     iv: encryptedRes.iv,
    //   );
    //   if (decryptedText != message.text) {
    //     break;
    //   }
    //   // expect(decryptedText, message.text);
    // }
  }
}
