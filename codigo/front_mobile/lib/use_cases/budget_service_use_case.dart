import '../api/dio_exception.dart';
import '../service/budget_service/budget_service_service.dart';
import '../service/budget_service/models/buget_service_model.dart';

class BudgetServiceUseCase {
  final BudgetServiceService budgetServiceService;

  const BudgetServiceUseCase({
    required this.budgetServiceService,
  });

  Future<List<BudgetServiceModel>> getBudgetService(String budgetId) async {
    try {
      return await budgetServiceService.getBudgetService(budgetId);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> addBudgetService(
    List<BudgetServiceModel> budgetS,
    String budgetId,
  ) async {
    try {
      for (var budgetServiceModel in budgetS) {
        await budgetServiceService.addBudgetService(
          budgetServiceModel,
          budgetId,
        );
      }
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> editBudgetService(
    List<BudgetServiceModel> budgetS,
    String budgetId,
  ) async {
    try {
      for (var budgetServiceModel in budgetS) {
        await budgetServiceService.editBudgetService(
          budgetServiceModel,
          budgetId,
        );
      }
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> deleteBudgetService(
    String budgetId,
    String serviceId,
  ) async {
    try {
      await budgetServiceService.deleteBudgetService(
        budgetId,
        serviceId,
      );
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  sendHTMLToBackend(String html) async {
    try {
      await budgetServiceService.sendHTMLToBackend(
        html,
      );
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }
}
