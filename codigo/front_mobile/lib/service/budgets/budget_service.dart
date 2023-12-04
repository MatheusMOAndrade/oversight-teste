import '../../api/dio_client.dart';
import '../../api/endpoints.dart';
import '../../di/locator.dart';
import '../../../service/user/cache_service.dart';
import 'package:dio/dio.dart';

import 'models/budget_model.dart';

abstract class IBudgetService {
  Future<List<BudgetModel>> getBudgetList();

  Future<void> addBudget(BudgetModel budget);

  Future<void> deleteBudget(String id);

  Future<void> editBudget(BudgetModel budget, String id);
}

class BudgetService implements IBudgetService {
  final DioClient dioClient = locator.get<DioClient>();
  final CacheService cacheService = locator.get<CacheService>();

  @override
  Future<List<BudgetModel>> getBudgetList() async {
    final token = await cacheService.getData(key: "token");

    final query = await dioClient.get(
      Endpoints.budgets,
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    final jsonData = query.data["data"] as List;

    final list = jsonData
        .map(
          (budget) => BudgetModel.fromJson(budget),
        )
        .toList();

    return list;
  }

  @override
  Future<void> addBudget(BudgetModel budget) async {
    final token = await cacheService.getData(key: "token");

    final query = await dioClient.post(
      Endpoints.budgets,
      data: budget.toJson(),
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    await cacheService.deleteData(key: "budgetId");
    await cacheService.saveData(
        key: "budgetId", value: query.data["data"]["id"]);
  }

  @override
  Future<void> deleteBudget(String id) async {
    final token = await cacheService.getData(key: "token");

    await dioClient.delete(
      '${Endpoints.budgets}/$id',
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );
  }

  @override
  Future<void> editBudget(BudgetModel budget, String id) async {
    final token = await cacheService.getData(key: "token");

    await dioClient.put(
      '${Endpoints.budgets}/$id',
      data: budget.toJson(),
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    await cacheService.deleteData(key: "budgetId");
    await cacheService.saveData(key: "budgetId", value: id);
  }
}
