import 'package:flutter/material.dart';
import 'package:logbook_app_077/features/auth/login_controller.dart';
import 'package:logbook_app_077/features/logbook/counter_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final LoginController _controller = LoginController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isObscure = true; // Variabel untuk mengontrol visibilitas password

  void _handleLogin() {
    String user = _userController.text;
    String pass = _passController.text;

    // 1. Validasi Kosong 
    if (user.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username dan Password tidak boleh kosong!")),
      );
      return;
    }

    bool isSuccess = _controller.login(user, pass);

    if (isSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CounterView(username: user),
        ),
      );
    } else {
      int sisa = 3 - _controller.attempts;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Gagal! Sisa percobaan: ${sisa > 0 ? sisa : 0}")),
      );

      if (_controller.isLocked) {
        Future.delayed(const Duration(seconds: 10), () {
          if (mounted) setState(() {}); // Tombol akan jadi aktif lagi otomatis di layar
        });
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Gatekeeper")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passController,
              obscureText: _isObscure, // Mengikuti status variabel _isObscure
              decoration: InputDecoration(
                labelText: "Password",
                border: const OutlineInputBorder(),

                // 3. Tambahkan IconButton untuk toggle visibilitas password
                suffixIcon: IconButton(
                  icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 4. Tombol otomatis mati jika isLocked true 
            ElevatedButton(
              onPressed: _controller.isLocked ? null : _handleLogin,
              child: Text(_controller.isLocked ? "Terkunci (10 detik)" : "Masuk"),
            ),
          ],
        ),
      ),
    );
  }
}

