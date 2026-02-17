class CounterController {
  int _counter = 0;
  int _step = 1; 
  
  // List untuk menyimpan riwayat
  final List<String> _history = []; 

  // Getter
  int get value => _counter;
  int get step => _step;
  List<String> get history => _history;

  // Fungsi set step dari Slider
  void setStep(int s) => _step = s;

  // --- LOGIKA RIWAYAT ---
  void _addHistory(String aksi) {

    DateTime now = DateTime.now();
    String jam = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    
    String pesan = "$aksi (Jam $jam)";

    _history.insert(0, pesan);
  
    if (_history.length > 5) {
      _history.removeLast();
    }
  }

  // --- LOGIKA TOMBOL ---
  void increment() {
    _counter += _step;
    _addHistory("user menambah $_step");
  }

  void decrement() {
    if (_counter > 0) {
      _counter -= _step;
      _addHistory("user mengurangi $_step");
    }
  }

  void reset() {
    _counter = 0;
    _addHistory("Data di-reset");
  }
}