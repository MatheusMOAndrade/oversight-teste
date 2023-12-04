import '../../api/dio_client.dart';
import '../../api/endpoints.dart';
import '../../di/locator.dart';
import '../../../service/user/cache_service.dart';
import 'package:dio/dio.dart';

import 'models/company_model.dart';

abstract class ICompanyService {
  Future<CompanyModel> getCompany();
}

class CompanyService implements ICompanyService {
  final DioClient dioClient = locator.get<DioClient>();
  final CacheService cacheService = locator.get<CacheService>();

  @override
  Future<CompanyModel> getCompany() async {
    final token = await cacheService.getData(key: "token");

    final query = await dioClient.get(
      Endpoints.companies,
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    final jsonData = query.data["data"] as List;

    final list = jsonData
        .map(
          (company) => CompanyModel.fromJson(company),
        )
        .toList();

    return list.first;
  }
}
