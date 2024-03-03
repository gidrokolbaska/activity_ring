import 'package:activity_ring/activity_ring.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoThemeData;

import 'package:activity_ring_example/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ExampleApp());
}

/// Example widget to show Ring widget
class RingExample extends StatelessWidget {
  const RingExample({super.key});

  // ignore: public_member_api_docs

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 216,
        child: Ring(
          percent: 220,
          childBuilder: (percent) {
            final animatedCalories = percent * 2000 / 100;
            return Text('${animatedCalories.round()}');
          },
          subChildBuilder: (context) {
            return Text('TEST');
          },
          color: RingColorScheme(
            ringGradients: [
              [Colors.green, Colors.green],
              [
                Colors.red,
                Colors.red,
              ]
            ],
            gradient: false,
            intensity: 0,
          ),
          radius: 216 / 2,
          width: width,
        ),
      ),
    );
  }
}

/// Main Application.
class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bajat',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        cupertinoOverrideTheme: const CupertinoThemeData(
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.dark,
      // Use this instead of home so that we get the modal effect
      // for home screen
      // onGenerateRoute: router,
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: RingExample(),
        ),
      ),
    );
  }
}
