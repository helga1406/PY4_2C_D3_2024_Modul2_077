import 'package:flutter/material.dart';
import 'package:logbook_app_077/features/auth/login_view.dart'; // Pastikan path ini benar

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  // 1. Variabel int step = 1 (Konsep Langkah 1)
  int step = 1;

  void _nextStep() {
    setState(() {
      // 2. Logika: Jika tombol ditekan, step++
      if (step < 3) {
        step++;
      } else {
        // 3. Jika step > 3, pindah ke LoginView (Navigator.pushReplacement)
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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Halaman Onboarding",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            
            // Menampilkan angka step saat ini
            Text(
              '$step',
              style: const TextStyle(
                fontSize: 100, 
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 158, 101, 140),
              ),
            ),
            
            const SizedBox(height: 50),
            
            ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 158, 101, 140),
                foregroundColor: Colors.white,
                minimumSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              // Teks tombol berubah di langkah terakhir
              child: Text(step < 3 ? "Lanjut" : "Mulai"),
            ),
          ],
        ),
      ),
    );
  }
}