import 'package:shared_preferences/shared_preferences.dart';

class CounterController {
  int _value = 0;
  List<String> _history = [];

  int get value => _value;
  List<String> get history => _history;

  // 1. Fungsi Membaca Data 
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _value = prefs.getInt('last_counter') ?? 0;
    _history = prefs.getStringList('counter_history') ?? [];
  }

  // 2. Fungsi Menambah & Menyimpan Data 
  Future<void> increment(String username) async {
    _value++;
    
    DateTime now = DateTime.now();
    String timeStr = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
    String logEntry = "User $username menambah ke $_value pada jam $timeStr";
    
    _history.insert(0, logEntry);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_counter', _value);
    await prefs.setStringList('counter_history', _history);
  }
}