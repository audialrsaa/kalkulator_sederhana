import 'package:flutter/foundation.dart';
import '../models/saving_plan.dart';

class SavingProvider extends ChangeNotifier {
  List<SavingPlan> plans = [];
  SavingPlan? activePlan;

  void addPlan(String name, int target) {
    plans.add(SavingPlan(name: name, target: target));
    notifyListeners();
  }

  void setActivePlan(SavingPlan plan) {
    activePlan = plan;
    notifyListeners();
  }

  void addSaving(SavingPlan plan, int amount) {
    plan.addSaving(amount);
    notifyListeners();
  }
}
