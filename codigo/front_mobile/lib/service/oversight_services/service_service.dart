import '../../api/dio_client.dart';
import '../../api/endpoints.dart';
import '../../di/locator.dart';
import '../../../service/oversight_services/models/oversight_service_model.dart';
import '../../../service/user/cache_service.dart';
import 'package:dio/dio.dart';

abstract class IServiceService {
  Future<List<ServiceModel>> getServiceList();

  Future<void> addService(ServiceModel service);

  Future<void> deleteService(String id);

  Future<void> editService(ServiceModel service, String id);
}

class ServiceService implements IServiceService {
  final DioClient dioClient = locator.get<DioClient>();
  final CacheService cacheService = locator.get<CacheService>();

  @override
  Future<List<ServiceModel>> getServiceList() async {
    final token = await cacheService.getData(key: "token");

    final query = await dioClient.get(
      Endpoints.services,
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    final jsonData = query.data["data"] as List;

    final list = jsonData
        .map(
          (service) => ServiceModel.fromJson(service),
        )
        .toList();

    return list;
  }

  @override
  Future<void> addService(ServiceModel service) async {
    final token = await cacheService.getData(key: "token");

    final query = await dioClient.post(
      Endpoints.services,
      data: service.toJson(),
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    await cacheService.deleteData(key: "serviceId");
    await cacheService.saveData(
        key: "serviceId", value: query.data["data"]["id"]);
  }

  @override
  Future<void> deleteService(String id) async {
    final token = await cacheService.getData(key: "token");

    await dioClient.delete(
      '${Endpoints.services}/$id',
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );
  }

  @override
  Future<void> editService(ServiceModel service, String id) async {
    final token = await cacheService.getData(key: "token");

    await dioClient.put(
      '${Endpoints.services}/$id',
      data: service.toJson(),
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    await cacheService.deleteData(key: "serviceId");
    await cacheService.saveData(key: "serviceId", value: id);
  }

  Future<bool> checkServiceEmailExist(String serviceEmail) async {
    final token = await cacheService.getData(key: "token");

    final query = await dioClient.get(
      Endpoints.services,
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    final requiredId = (query.data["data"] as List)
        .where((element) => element == serviceEmail);

    return requiredId.isNotEmpty;
  }
}
