import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // The app starts with the HomeScreen
      home: HomeScreen(),
    );
  }
}

// HomeScreen needs to be a StatefulWidget to manage the animation states.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State variables to control the animations
  bool _isContainerAnimated = false;
  bool _isLogoVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 3: Animations & Nav'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // DEMO 1: AnimatedContainer (Slide 4)
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: _isContainerAnimated ? 250.0 : 100.0,
              height: _isContainerAnimated ? 100.0 : 100.0,
              color: _isContainerAnimated ? Colors.red : Colors.blue,
              child: const Center(
                child: Text('Animate Me!', style: TextStyle(color: Colors.white)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // setState triggers the animation by rebuilding the widget
                setState(() {
                  _isContainerAnimated = !_isContainerAnimated;
                });
              },
              child: const Text('Animate Container'),
            ),

            const SizedBox(height: 40), // A little space between demos

            // DEMO 2: AnimatedOpacity (Slide 6)
            AnimatedOpacity(
              opacity: _isLogoVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: const FlutterLogo(size: 100),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLogoVisible = !_isLogoVisible;
                });
              },
              child: const Text('Toggle Logo Visibility'),
            ),

            const SizedBox(height: 40),

            // DEMO 3: Navigation (Slide 10)
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                // Navigator.push adds a new screen to the stack
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
              child: const Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

// This is our second, very simple screen.
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pop removes this screen and goes back
            Navigator.pop(context);
          },
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}