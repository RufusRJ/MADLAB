import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// To make our app interactive (for gestures), we convert it to a StatefulWidget.
// This allows the widget to hold data (a "state") that can change.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This variable will hold the text for our interactive gesture area.
  String _gestureText = 'Tap Me!';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // SafeArea avoids the phone's status bar/notch (Slide 4)
        body: SafeArea(
          // We use a Column to arrange widgets vertically (Slide 6)
          child: Column(
            // mainAxisAlignment spaces children out along the vertical axis
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment aligns children along the horizontal axis
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SECTION 1: A styled Container (Slide 7)
              Container(
                width: 300,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  border: Border.all(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  // A Text widget with styling (Slide 9)
                  child: Text(
                    'Styled Container',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // SECTION 2: A Row of Buttons (Slides 6 & 8)
              Row(
                // mainAxisAlignment spaces children out along the horizontal axis
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.star), // Icon widget (Slide 11)
                    label: const Text('Button 1'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
                    label: const Text('Button 2'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_up),
                    label: const Text('Button 3'),
                  ),
                ],
              ),

              // SECTION 3: An interactive Gesture Area (Slide 16)
              GestureDetector(
                onTap: () {
                  // setState() tells Flutter to rebuild the widget with the new text
                  setState(() {
                    _gestureText = 'Tapped! Tap again!';
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    _gestureText = 'Double Tapped!';
                  });
                },
                onLongPress: () {
                  setState(() {
                    _gestureText = 'Long Pressed!';
                  });
                },
                child: Container(
                  width: 300,
                  height: 150,
                  color: Colors.green[300],
                  child: Center(
                    child: Text(
                      _gestureText, // The text that will change
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}