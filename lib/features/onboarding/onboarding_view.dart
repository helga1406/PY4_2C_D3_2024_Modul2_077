import 'package:flutter/material.dart';
import 'package:logbook_app_077/features/auth/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int step = 1; // Variabel untuk melacak langkah onboarding [cite: 109]

  void _nextStep() {
    setState(() {
      if (step < 3) {
        step++; // Tambah langkah [cite: 110]
      } else {
        // Jika sudah langkah ke-3, pindah ke Login [cite: 110]
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Halaman Onboarding", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text("$step", style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _nextStep,
              child: const Text("Lanjut"),
            ),
          ],
        ),
      ),
    );
  }
}