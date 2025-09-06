import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/saving_provider.dart';
import 'result_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SavingProvider>();
    final plans = provider.plans;

    final berjalan = plans.where((p) => !p.isComplete).toList();
    final selesai = plans.where((p) => p.isComplete).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Tabungan")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Tabungan Berjalan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: berjalan.length,
              itemBuilder: (context, index) {
                final plan = berjalan[index];
                return ListTile(
                  title: Text(plan.name),
                  subtitle: Text("Target: Rp${plan.target} | Terkumpul: Rp${plan.saved}"),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    provider.setActivePlan(plan);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResultPage(), // ✅ tanpa argumen
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Tabungan Selesai",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selesai.length,
              itemBuilder: (context, index) {
                final plan = selesai[index];
                return ListTile(
                  title: Text(plan.name),
                  subtitle: Text("Target: Rp${plan.target} | Terkumpul: Rp${plan.saved}"),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showAddDialog(context);
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final targetCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Buat Tabungan Baru"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Nama Tabungan"),
            ),
            TextField(
              controller: targetCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Target (Rp)"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameCtrl.text;
              final target = int.tryParse(targetCtrl.text) ?? 0;
              if (name.isNotEmpty && target > 0) {
                context.read<SavingProvider>().addPlan(name, target);
                Navigator.pop(ctx);
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}
