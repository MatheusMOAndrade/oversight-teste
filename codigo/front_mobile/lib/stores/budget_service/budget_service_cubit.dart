import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/locator.dart';
import '../../service/budget_service/models/buget_service_model.dart';
import '../../service/company/models/company_model.dart';
import '../../service/customer/models/customer_model.dart';
import '../../service/mailer/models/mailer_model.dart';
import '../../service/oversight_services/models/oversight_service_model.dart';
import '../../service/user/cache_service.dart';
import '../../use_cases/budget_service_use_case.dart';
import '../../use_cases/company_use_case.dart';
import '../../use_cases/customer_use_case.dart';
import '../../use_cases/mailer_use_case.dart';
import '../../use_cases/service_use_case.dart';

part 'budget_service_state.dart';

class BudgetServiceCubit extends Cubit<BudgetServiceState> {
  final CacheService cacheService = locator.get<CacheService>();
  final BudgetServiceUseCase budgetServiceUseCase;
  final MailerUseCase mailerUseCase;
  final ServiceUseCase serviceUseCase;
  final CustomerUseCase customerUseCase;
  final CompanyUseCase companyUseCase;

  BudgetServiceCubit({
    required this.budgetServiceUseCase,
    required this.serviceUseCase,
    required this.mailerUseCase,
    required this.customerUseCase,
    required this.companyUseCase,
  }) : super(BudgetServiceInitial());

  void init(
    String budgetId,
    String customerid,
  ) async {
    emit(BudgetServiceSkeletonLoading(matchedServiceList: mockedList));

    List<BudgetServiceModel> budgetServiceList =
        await budgetServiceUseCase.getBudgetService(budgetId);

    List<ServiceModel> matchedServiceList = await _matchBudgetService(budgetId);

    double budgetSum = await _getBudgetService(budgetId);

    CustomerModel relatedCustomerModel = await _getCustomerModel(customerid);

    CompanyModel relatedCompanyModel = await _getCompanyModel();

    emit(BudgetServiceLoaded(
      matchedServiceList: matchedServiceList,
      budgetSum: budgetSum,
      budgetServiceModel: budgetServiceList,
      relatedCustomerModel: relatedCustomerModel,
      relatedCompanyModel: relatedCompanyModel,
    ));
  }

  Future<double> _getBudgetService(String budgetId) async {
    List<BudgetServiceModel> budgetServiceList =
        await budgetServiceUseCase.getBudgetService(budgetId);

    final double budgetSum = budgetServiceList.fold(
      0.0,
      (previousValue, BudgetServiceModel e) =>
          previousValue + e.budgetedUnitValue,
    );

    return budgetSum;
  }

  Future<List<ServiceModel>> _matchBudgetService(String budgetId) async {
    final budgetServiceList =
        await budgetServiceUseCase.getBudgetService(budgetId);

    final serviceList = await serviceUseCase.getList();

    List<ServiceModel> matchedServiceList = [];

    for (var budgetService in budgetServiceList) {
      ServiceModel matchedService = serviceList
          .firstWhere((element) => element.id == budgetService.serviceId);

      matchedServiceList.add(matchedService);
    }
    return matchedServiceList;
  }

  Future<CustomerModel> _getCustomerModel(String customerId) async {
    final customerList = await customerUseCase.getList();

    CustomerModel customerModel =
        customerList.firstWhere((e) => e.id == customerId);

    return customerModel;
  }

  Future<CompanyModel> _getCompanyModel() async {
    return await companyUseCase.getCompany();
  }

  Future<void> addBudgetService(
    List<BudgetServiceModel> budgetS,
    String budgetId,
  ) async {
    emit(BudgetServiceLoading());

    await budgetServiceUseCase.addBudgetService(
      budgetS,
      budgetId,
    );

    List<ServiceModel> matchedServiceList = await _matchBudgetService(budgetId);

    emit(BudgetServiceLoaded(matchedServiceList: matchedServiceList));
  }

  Future<String> getToken(String budgetId) async {
    emit(BudgetServiceLoading());

    return await mailerUseCase.getToken(budgetId);
  }

  Future<void> postMail(
    MailerModel mailerModel,
  ) async {
    emit(BudgetServiceLoading());

    await mailerUseCase.postMail(mailerModel);
  }

  Future<void> editBudgetService(
    List<BudgetServiceModel> budgetS,
    String budgetId,
  ) async {
    emit(BudgetServiceLoading());

    await budgetServiceUseCase.editBudgetService(
      budgetS,
      budgetId,
    );

    List<ServiceModel> matchedServiceList = await _matchBudgetService(budgetId);

    emit(BudgetServiceLoaded(matchedServiceList: matchedServiceList));
  }

  void deleteBudgetService(
    String budgetId,
    String serviceId,
  ) async {
    emit(BudgetServiceLoading());

    await budgetServiceUseCase.deleteBudgetService(
      budgetId,
      serviceId,
    );

    List<ServiceModel> matchedServiceList = await _matchBudgetService(
      serviceId,
    );

    matchedServiceList.removeWhere((element) => element.id == serviceId);

    emit(BudgetServiceLoaded(matchedServiceList: matchedServiceList));
  }

  List<ServiceModel> get mockedList {
    return [
      const ServiceModel(
        name: 'MockName1',
        description: 'description1',
        value: 0,
        errorMargin: 10,
        mesureUnit: 'm',
      ),
      const ServiceModel(
        name: 'MockName2',
        description: 'description2',
        value: 0,
        errorMargin: 10,
        mesureUnit: 'm',
      ),
      const ServiceModel(
        name: 'MockName3',
        description: 'description3',
        value: 0,
        errorMargin: 10,
        mesureUnit: 'm',
      ),
    ];
  }
}
