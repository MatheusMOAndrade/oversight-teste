import '../api/dio_exception.dart';

import '../service/budget_service/budget_service_service.dart';
import '../service/budget_service/models/buget_service_model.dart';
import '../service/budgets/budget_service.dart';
import '../service/budgets/models/budget_model.dart';

class BudgetUseCase {
  final BudgetService budgetService;
  final BudgetServiceService budgetServiceService;

  const BudgetUseCase({
    required this.budgetService,
    required this.budgetServiceService,
  });

  Future<List<BudgetModel>> getList() async {
    try {
      return await budgetService.getBudgetList();
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  List<BudgetModel> filterList(List<BudgetModel> budgetList, String query) {
    List<BudgetModel> filter = <BudgetModel>[];

    filter.addAll(budgetList);

    filter.retainWhere(
      (element) => element.name.toLowerCase().contains(
            query.toLowerCase(),
          ),
    );

    return filter;
  }

  Future<void> addBudget(
    BudgetModel budget,
    //List<BudgetServiceModel> budgetS,
  ) async {
    try {
      await budgetService.addBudget(budget);

      // for (var budgetServiceModel in budgetS) {
      //   await budgetServiceService.addBudgetService(budgetServiceModel);
      // }
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> deleteBudget(String budgetId) async {
    try {
      await budgetService.deleteBudget(budgetId);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> editBudget(
    BudgetModel budget,
    List<BudgetServiceModel> budgetS,
    String budgetId,
  ) async {
    try {
      await budgetService.editBudget(budget, budgetId);
      // for (var budgetServiceModel in budgetS) {
      //   await budgetServiceService.editBudgetService(
      //     budgetServiceModel,
      //     budgetId,
      //   );
      // }
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }
}
