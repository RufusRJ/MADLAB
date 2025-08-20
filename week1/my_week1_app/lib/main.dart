// Import the basic Material Design library from the Flutter framework.
import 'package:flutter/material.dart';

// The main() function is the starting point for all Flutter apps.
void main() {
  // runApp() takes the root widget and makes it the root of the widget tree.
  runApp(const MyApp());
}

// MyApp is the main widget for your application.
// It's a StatelessWidget because it doesn't need to manage any internal state.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // The build() method describes how to display the widget.
  // It's called by the Flutter framework whenever this widget needs to be rendered.
  @override
  Widget build(BuildContext context) {
    // MaterialApp is a convenient widget that includes many features
    // an application needs, like routing and theming.
    return MaterialApp(
      // The home property defines the default screen of the app.
      home: Scaffold(
        // Scaffold provides a standard mobile app layout structure.
        appBar: AppBar(
          // AppBar is the toolbar at the top of the screen.
          title: const Text('Hello World'),
        ),
        // The body is the primary content of the Scaffold.
        body: const Center(
          // Center is a widget that centers its child widget.
          child: Text('Welcome to Flutter!'),
        ),
      ),
    );
  }
}