part of 'budget_service_cubit.dart';

abstract class BudgetServiceState {}

class BudgetServiceInitial extends BudgetServiceState {}

class BudgetServiceLoading extends BudgetServiceState {}

class BudgetServiceLoaded extends BudgetServiceState {
  final List<ServiceModel> matchedServiceList;
  final double? budgetSum;
  final List<BudgetServiceModel>? budgetServiceModel;
  final CustomerModel? relatedCustomerModel;
  final CompanyModel? relatedCompanyModel;

  BudgetServiceLoaded({
    required this.matchedServiceList,
    this.budgetSum,
    this.budgetServiceModel,
    this.relatedCustomerModel,
    this.relatedCompanyModel,
  });
}

class BudgetServiceSkeletonLoading extends BudgetServiceState {
  final List<ServiceModel> matchedServiceList;

  BudgetServiceSkeletonLoading({
    required this.matchedServiceList,
  });
}

class BudgetServiceListChanged extends BudgetServiceState {
  final List<ServiceModel> matchedServiceList;

  BudgetServiceListChanged({
    required this.matchedServiceList,
  });
}
