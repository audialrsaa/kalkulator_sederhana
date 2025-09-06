import 'package:flutter/material.dart';
import '../models/saving_entry.dart';

class SavingCard extends StatelessWidget {
  final SavingEntry entry;
  const SavingCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: const Icon(Icons.attach_money, color: Colors.green),
        title: Text("Rp${entry.amount}"),
        subtitle: Text(
          "${entry.date.day}-${entry.date.month}-${entry.date.year}",
        ),
      ),
    );
  }
}
