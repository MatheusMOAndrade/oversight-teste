import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/locator.dart';
import '../../service/budget_service/models/buget_service_model.dart';
import '../../service/budgets/models/budget_model.dart';
import '../../service/user/cache_service.dart';
import '../../use_cases/budget_use_case.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  final CacheService cacheService = locator.get<CacheService>();
  final BudgetUseCase budgetUseCase;

  BudgetCubit({
    required this.budgetUseCase,
  }) : super(BudgetInitial());

  void init() async {
    emit(BudgetSkeletonLoading(budgetList: mockedList));

    final budgetList = await budgetUseCase.getList();

    emit(BudgetLoaded(budgetList: budgetList));
  }

  void filter(List<BudgetModel> budgetList, String query) {
    emit(BudgetLoading());

    final filteredList = budgetUseCase.filterList(budgetList, query);

    emit(BudgetListChanged(budgetList: budgetList));

    emit(BudgetLoaded(budgetList: filteredList));
  }

  Future<void> addBudget(
    BudgetModel budget,
    List<BudgetServiceModel> budgetS,
  ) async {
    emit(BudgetLoading());

    await budgetUseCase.addBudget(
      budget,
    );

    final budgetList = await budgetUseCase.getList();

    emit(BudgetListChanged(budgetList: budgetList));
    emit(BudgetLoaded(budgetList: budgetList));
  }

  void deleteBudget(String budgetId) async {
    emit(BudgetLoading());

    await budgetUseCase.deleteBudget(budgetId);

    final budgetList = await budgetUseCase.getList();

    emit(BudgetListChanged(budgetList: budgetList));
    emit(BudgetLoaded(budgetList: budgetList));
  }

  void editBudget(
    BudgetModel budget,
    List<BudgetServiceModel> budgetS,
    String budgetId,
  ) async {
    emit(BudgetLoading());

    await budgetUseCase.editBudget(
      budget,
      budgetS,
      budgetId,
    );

    final budgetList = await budgetUseCase.getList();

    emit(BudgetListChanged(budgetList: budgetList));
    emit(BudgetLoaded(budgetList: budgetList));
  }

  List<BudgetModel> get mockedList {
    return [
      const BudgetModel(
          name: 'MockName1',
          description: 'description1',
          incomingMargin: 0,
          status: 'budgeting'),
      const BudgetModel(
          name: 'MockName2',
          description: 'description2',
          incomingMargin: 0,
          status: 'budgeting'),
      const BudgetModel(
          name: 'MockName3',
          description: 'description3',
          incomingMargin: 0,
          status: 'budgeting'),
    ];
  }
}
