import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/models/message.dart';
import 'package:after_layout/after_layout.dart';
import 'package:r2f_x3dh_e2e/r2f_x3dh_e2e.dart';
import 'package:example/widgets/dart_x3dh_widget.dart';
import 'package:example/widgets/rust_x3dh_widget.dart';

// The entry point of the application.
Future<void> main() async {
  await R2FX3DHE2ESer().init(); // Initializes the R2FX3DHE2ESer object.
  runApp(const App()); // Runs the application.
}

// The root widget of the application.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App>
    with WidgetsBindingObserver, AfterLayoutMixin {
  late ValueNotifier<List<Message>?>
      _msgNotifi; // A ValueNotifier to hold the list of messages.
  late List<Widget> tabs; // A list of tabs for the tab bar.
  late List<Widget> tabbarViews; // A list of views for the tab bar.

  @override
  void initState() {
    super.initState();
    _msgNotifi =
        ValueNotifier(null); // Initialize the ValueNotifier with null value.
    tabs = const [
      Tab(icon: Text("Pure-Dart")), // The "Pure-Dart" tab.
      Tab(icon: Text("Rust-to-Dart")) // The "Rust-to-Dart" tab.
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _msgNotifi.dispose(); // Dispose the ValueNotifier to release resources.
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
            title: const Text('X3DH-E2E-TESTING'), // The title of the app bar.
            centerTitle: true,
            bottom: TabBar(
              tabs: tabs, // Set the tabs for the tab bar.
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
                        child:
                            CircularProgressIndicator(), // A loading indicator.
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
                      return child!; // Show the loading indicator and text if messages are null.
                    }
                    return TabBarView(
                      children: [
                        DartX3dhWidget(
                            messages:
                                msgs), // The widget for the "Pure-Dart" tab.
                        RustX3dhWidget(
                            messages:
                                msgs), // The widget for the "Rust-to-Dart" tab.
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
        final messagesJson = await rootBundle.loadString(
            'assets/messages_1000.json'); // Load the JSON data from a file.
        final decodedJson =
            jsonDecode(messagesJson) as List<dynamic>; // Decode the JSON data.
        final messages = decodedJson
            .map((value) => Message.fromJson(value))
            .toList(); // Convert the decoded JSON into a list of Message objects.
        _msgNotifi.value =
            messages; // Update the ValueNotifier with the list of messages.
      },
    );
  }
}
