import 'saving_entry.dart';

class SavingPlan {
  final String name;
  final int target;
  int saved = 0;
  List<SavingEntry> entries = [];

  SavingPlan({required this.name, required this.target});

  void addSaving(int amount) {
    saved += amount;
    entries.add(SavingEntry(amount: amount, date: DateTime.now()));
  }

  bool get isComplete => saved >= target;

  int get remaining => (target - saved).clamp(0, target);
}
