part of 'budget_cubit.dart';

abstract class BudgetState {}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetLoaded extends BudgetState {
  final List<BudgetModel> budgetList;
  BudgetLoaded({
    required this.budgetList,
  });
}

class BudgetSkeletonLoading extends BudgetState {
  final List<BudgetModel> budgetList;
  BudgetSkeletonLoading({
    required this.budgetList,
  });
}

class BudgetListChanged extends BudgetState {
  final List<BudgetModel> budgetList;

  BudgetListChanged({
    required this.budgetList,
  });
}
