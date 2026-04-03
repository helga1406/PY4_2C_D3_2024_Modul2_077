import 'package:flutter_test/flutter_test.dart';
import 'package:logbook_app_077/features/auth/login_controller.dart'; 

void main() {
  dynamic actual, expected;
  dynamic actual1, expected1;
  dynamic actual2, expected2;

  group('Modul 2 - Authentication (Test)', () {
    late LoginController controller;

    setUp(() {
      // (1) setup (arrange, build)
      controller = LoginController();
    });

    // Sesuai TC01 di Excel
    test('login berhasil dengan kredensial yang valid', () {
      // (2) exercise (act, operate)
      actual1 = controller.login("helga", "polban2026");
      actual2 = controller.attempts;

      expected1 = true;
      expected2 = 0;

      // (3) verify (assert, check)
      expect(actual1, expected1, reason: 'Expected $expected1 but got $actual1');
      expect(actual2, expected2, reason: 'Expected $expected2 but got $actual2');
    });

    // Sesuai TC02 di Excel
    test('login gagal dan attempts bertambah jika password salah', () {
      // (2) exercise (act, operate)
      actual1 = controller.login("helga", "salahpass");
      actual2 = controller.attempts;

      expected1 = false;
      expected2 = 1;

      // (3) verify (assert, check)
      expect(actual1, expected1, reason: 'Expected $expected1 but got $actual1');
      expect(actual2, expected2, reason: 'Expected $expected2 but got $actual2');
    });

    // Sesuai TC03 di Excel
    test('akun terkunci (isLocked) setelah 3 kali gagal login', () {
      // (2) exercise (act, operate)
      controller.login("helga", "salahpass"); // gagal 1
      controller.login("helga", "salahpass"); // gagal 2
      controller.login("helga", "salahpass"); // gagal 3

      actual = controller.isLocked;
      expected = true;

      // (3) verify (assert, check)
      expect(actual, expected, reason: 'Expected $expected but got $actual');
    });
  });
}