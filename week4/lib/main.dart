import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const FancyFormApp());
}

class FancyFormApp extends StatelessWidget {
  const FancyFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fancy Form Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FancyFormPage(),
    );
  }
}

class FancyFormPage extends StatefulWidget {
  const FancyFormPage({super.key});

  @override
  State<FancyFormPage> createState() => _FancyFormPageState();
}

class _FancyFormPageState extends State<FancyFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String? _selectedCourse;
  bool _acceptTerms = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please accept Terms & Conditions")),
        );
        return;
      }
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("🎉 Success"),
          content: Text(
            "Welcome ${_nameCtrl.text}!\n"
            "Email: ${_emailCtrl.text}\n"
            "Course: $_selectedCourse",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D28D9), Color(0xFF9333EA), Color(0xFFC084FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                width: 380,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Sign Up Form",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black45,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Name
                      TextFormField(
                        controller: _nameCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputStyle("Name", Icons.person),
                        validator: (v) =>
                            v == null || v.isEmpty ? "Enter your name" : null,
                      ),
                      const SizedBox(height: 16),

                      // Email
                      TextFormField(
                        controller: _emailCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputStyle("Email", Icons.email),
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Enter your email";
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                            return "Invalid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password
                      TextFormField(
                        controller: _passCtrl,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputStyle("Password", Icons.lock),
                        validator: (v) =>
                            v != null && v.length >= 6
                                ? null
                                : "Min 6 characters",
                      ),
                      const SizedBox(height: 16),

                      // Dropdown
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.deepPurple.shade700,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputStyle("Select Course", Icons.book),
                        value: _selectedCourse,
                        items: ["Flutter", "React", "Android", "iOS"]
                            .map((c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(c),
                                ))
                            .toList(),
                        onChanged: (v) => setState(() => _selectedCourse = v),
                        validator: (v) =>
                            v == null ? "Pick a course" : null,
                      ),
                      const SizedBox(height: 16),

                      // Checkbox
                      CheckboxListTile(
                        title: const Text(
                          "I accept Terms & Conditions",
                          style: TextStyle(color: Colors.white),
                        ),
                        value: _acceptTerms,
                        onChanged: (v) =>
                            setState(() => _acceptTerms = v ?? false),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.pinkAccent,
                        checkColor: Colors.white,
                      ),
                      const SizedBox(height: 20),

                      // Fancy animated gradient button
                      FancyButton(
                        text: "Submit",
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.white38),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.white),
      ),
    );
  }
}

// --------- Fancy Gradient Button Widget ----------
class FancyButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const FancyButton({super.key, required this.onPressed, required this.text});

  @override
  State<FancyButton> createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton> {
  bool _hovering = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) {
          setState(() => _pressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.identity()
            ..scale(_pressed ? 0.95 : 1.0, _pressed ? 0.95 : 1.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _hovering
                  ? [Colors.orangeAccent, Colors.pinkAccent]
                  : [Colors.pinkAccent, Colors.orangeAccent],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: _hovering ? 20 : 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
