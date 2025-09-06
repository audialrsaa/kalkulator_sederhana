import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/saving_provider.dart';
import '../widgets/saving_card.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SavingProvider>();
    final plan = provider.activePlan; // ✅ ambil dari provider

    return Scaffold(
      appBar: AppBar(title: Text(plan?.name ?? "Progress Tabungan")),
      body: plan == null
          ? const Center(child: Text("Belum ada rencana tabungan"))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Target: Rp${plan.target}",
                          style: const TextStyle(fontSize: 16)),
                      Text("Sudah terkumpul: Rp${plan.saved}",
                          style: const TextStyle(fontSize: 16)),
                      Text("Sisa: Rp${plan.remaining}",
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      plan.isComplete
                          ? const Text(
                              "🎉 Target tercapai!",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Tambah tabungan (Rp)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          final amount =
                              int.tryParse(_amountController.text) ?? 0;
                          if (amount > 0) {
                            context
                                .read<SavingProvider>()
                                .addSaving(plan, amount);
                            _amountController.clear();
                          }
                        },
                        child: const Text("Tambah"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Riwayat Nabung",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: plan.entries.length,
                    itemBuilder: (context, index) {
                      return SavingCard(entry: plan.entries[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
