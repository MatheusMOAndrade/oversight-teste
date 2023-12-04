import '../api/dio_exception.dart';

import '../service/company/company_service.dart';
import '../service/company/models/company_model.dart';

class CompanyUseCase {
  final CompanyService companyService;

  const CompanyUseCase({
    required this.companyService,
  });

  Future<CompanyModel> getCompany() async {
    try {
      return await companyService.getCompany();
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }
}
