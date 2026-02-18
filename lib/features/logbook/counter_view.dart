import 'package:flutter/material.dart';
import 'package:logbook_app_077/features/logbook/counter_controller.dart';

class CounterView extends StatefulWidget {
 final String username;

  const CounterView({super.key, required this.username});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();
  double _sliderValue = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LogBook: Task 2"),
        backgroundColor: const Color.fromARGB(255, 233, 196, 221),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // 1. Angka Utama
              const Text("Total Hitungan:", style: TextStyle(fontSize: 18)),
              Text('${_controller.value}',
                  style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),

              const SizedBox(height: 30),

              // 2. Slider Section
              Text("Atur Nilai Step: ${_sliderValue.round()}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Slider(
                value: _sliderValue, min: 1, max: 20, divisions: 19,
                label: _sliderValue.round().toString(),
                activeColor: const Color.fromARGB(255, 167, 89, 142),
                onChanged: (val) => setState(() {
                  _sliderValue = val;
                  _controller.setStep(val.toInt());
                }),
              ),

              const SizedBox(height: 30),

              // 3. Tombol Aksi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: "btn_min",
                    backgroundColor: const Color.fromARGB(255, 156, 71, 80),
                    onPressed: () => setState(() => _controller.decrement()),
                    child: const Icon(Icons.remove, color: Colors.black),
                  ),
                  FloatingActionButton(
                    heroTag: "btn_reset",
                    backgroundColor: const Color.fromARGB(255, 175, 172, 147),
                    onPressed: _showResetDialog,
                    child: const Icon(Icons.refresh, color: Colors.black),
                  ),
                  FloatingActionButton(
                    heroTag: "btn_add",
                    backgroundColor: const Color.fromARGB(255, 83, 121, 84),
                    onPressed: () => setState(() => _controller.increment()),
                    child: const Icon(Icons.add, color: Colors.black),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // 4. Panggil Widget History Terpisah (Clean!)
              HistoryListWidget(historyData: _controller.history),
            ],
          ),
        ),
      ),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Konfirmasi Reset"),
        content: const Text("Yakin ingin menghapus semua history?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              setState(() => _controller.reset());
              Navigator.pop(ctx);
            },
            child: const Text("Ya, Reset", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

  // --- Tampilan History---
class HistoryListWidget extends StatelessWidget {
  final List<String> historyData;
  const HistoryListWidget({super.key, required this.historyData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Riwayat Aktivitas",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text("(${historyData.length}/5)",
                style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        const SizedBox(height: 10),
        historyData.isEmpty
            ? Container(
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(children: const [
                  Icon(Icons.history_toggle_off, size: 40, color: Colors.grey),
                  Text("Belum ada aktivitas", style: TextStyle(color: Colors.grey))
                ]),
              )
            : Column(
                children: historyData.map((data) => _buildCard(data)).toList()),
      ],
    );
  }

  Widget _buildCard(String data) {
    Color color = Colors.blueGrey;
    IconData icon = Icons.refresh_rounded;

    if (data.contains("Ditambah")) {
      color = Colors.green[800]!;
      icon = Icons.arrow_upward_rounded;
    } else if (data.contains("Dikurang")) {
      color = Colors.red[800]!;
      icon = Icons.arrow_downward_rounded;
    }

    String aksi = data.split(' (Jam')[0];
    String jam = data.contains('(Jam')
        ? data.split('(Jam ')[1].replaceAll(')', '')
        : '-';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color),
        ),
        title: Text(aksi,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text("Pukul $jam"),
        trailing: Icon(Icons.circle, size: 10, color: color),
      ),
    );
  }
}