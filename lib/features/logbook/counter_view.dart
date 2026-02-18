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

  // Fungsi memuat data 
  void _initData() async {
    await _controller.loadData(widget.username);
    if (mounted) setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      
      // 1. App Bar dengan Nama User dan Logout
      appBar: AppBar(
        title: Text(
          "Logbook: ${widget.username}",
          style: const TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 158, 101, 140), 
        iconTheme: const IconThemeData(color: Colors.white),
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

      // 2. Body 
      body: Column(
        children: [
          const SizedBox(height: 40),
          
          // Bagian Sapaan (Mengambil Logika dari Controller)
          Text(
            "${_controller.getGreeting()}, ${widget.username}!", 
            style: const TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 158, 101, 140), 
            ),
          ),
          
          const Text(
            "Angka Terakhir Anda:",
            style: TextStyle(
              color: Color.fromARGB(221, 175, 133, 149),
              fontWeight: FontWeight.w500, 
            ),
          ),
          
          // Angka Counter
          Text(
            '${_controller.value}',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(221, 175, 133, 149),
            ),
          ),
          
          const Divider(height: 50, thickness: 1, indent: 20, endIndent: 20),
          
          // Header Riwayat
          const Text(
            "Riwayat Aktivitas", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 158, 101, 140),
            ),
          ),
          const SizedBox(height: 10),
          
          // List Riwayat
          Expanded(
            child: _controller.history.isEmpty 
              ? const Center(
                  child: Text(
                    "Belum ada riwayat.",
                    style: TextStyle(color: Color.fromARGB(221, 175, 133, 149)),
                  ),
                )
              : ListView.builder(
                  itemCount: _controller.history.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.history_edu, color: Color.fromARGB(255, 158, 101, 140)),
                        title: Text(
                          _controller.history[index],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 158, 101, 140), 
                          ),
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),

      // 3. Tombol Aksi 
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 158, 101, 140),
        foregroundColor: Colors.white,
        onPressed: () async {
          await _controller.increment(widget.username);
          setState(() {}); 
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}