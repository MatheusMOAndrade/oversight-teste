import '../../api/dio_client.dart';
import '../../api/endpoints.dart';
import '../../di/locator.dart';
import '../../../service/user/cache_service.dart';
import 'package:dio/dio.dart';

import 'models/buget_service_model.dart';

abstract class IBudgetServiceService {
  Future<List<BudgetServiceModel>> getBudgetService(String budgetId);

  Future<void> addBudgetService(
      BudgetServiceModel budgetService, String budgetId);

  Future<void> editBudgetService(
    BudgetServiceModel budgetService,
    String budgetId,
  );

  Future<void> deleteBudgetService(String budgetId, String budgetService);
}

class BudgetServiceService implements IBudgetServiceService {
  final DioClient dioClient = locator.get<DioClient>();
  final CacheService cacheService = locator.get<CacheService>();

  @override
  Future<List<BudgetServiceModel>> getBudgetService(String budgetId) async {
    final token = await cacheService.getData(key: "token");

    final query = await dioClient.get(
      '${Endpoints.budgets}/$budgetId/services',
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    final jsonData = query.data["data"] as List;

    final list = jsonData
        .map(
          (budgetService) => BudgetServiceModel.fromJson(budgetService),
        )
        .toList();

    return list;
  }

  @override
  Future<void> addBudgetService(
      BudgetServiceModel budgetService, String budgetId) async {
    final token = await cacheService.getData(key: "token");
    final budgetId = await cacheService.getData(key: "budgetId");
    final linkedBudgetService = budgetService.copyWith(budgetId: budgetId);

    await dioClient.post(
      '${Endpoints.budgets}/$budgetId/services',
      data: linkedBudgetService.toJson(),
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );
  }

  @override
  Future<void> editBudgetService(
      BudgetServiceModel budgetService, String budgetId) async {
    final token = await cacheService.getData(key: "token");
    final linkedBudgetService = budgetService.copyWith(budgetId: budgetId);
    final serviceId = budgetService.serviceId;

    await dioClient.put(
      '${Endpoints.budgets}/$budgetId/services/$serviceId',
      data: linkedBudgetService.toJson(),
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );
  }

  @override
  Future<void> deleteBudgetService(
    String budgetId,
    String serviceId,
  ) async {
    final token = await cacheService.getData(key: "token");

    print(serviceId);

    await dioClient.delete(
      '${Endpoints.budgets}/$budgetId/services/$serviceId',
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );
  }

  sendHTMLToBackend(String html) async {
    final token = await cacheService.getData(key: "token");

    await dioClient.post(
      '${Endpoints.message}/',
      data: html,
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );
  }
}
