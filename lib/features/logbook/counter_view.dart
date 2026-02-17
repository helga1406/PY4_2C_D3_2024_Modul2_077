import 'package:flutter/material.dart';
import 'package:logbook_app_077/features/logbook/counter_controller.dart';
import 'package:logbook_app_077/features/onboarding/onboarding_view.dart';

class CounterView extends StatefulWidget {
  final String username;
  const CounterView({super.key, required this.username});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  // Fungsi async
  void _initData() async {
    await _controller.loadData();
    if (mounted) setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logbook: ${widget.username}"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Konfirmasi Logout"),
                    content: const Text("Apakah Anda yakin? Data riwayat tetap tersimpan."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Batal"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const OnboardingView()),
                            (route) => false,
                          );
                        },
                        child: const Text("Ya, Keluar", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Text("Selamat Datang, ${widget.username}!"),
          const SizedBox(height: 10),
          const Text("Angka Terakhir Anda:"),
          Text(
            '${_controller.value}',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const Divider(height: 50, thickness: 1, indent: 20, endIndent: 20),
          
          // Bagian Spesifikasi Task 3: Menampilkan History Log
          const Text("Riwayat Aktivitas", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: _controller.history.isEmpty 
              ? const Center(child: Text("Belum ada riwayat."))
              : ListView.builder(
                  itemCount: _controller.history.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.history_edu),
                        title: Text(
                          _controller.history[index],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _controller.increment(widget.username);
          setState(() {}); 
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}