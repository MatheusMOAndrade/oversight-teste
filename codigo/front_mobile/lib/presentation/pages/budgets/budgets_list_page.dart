import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:oversight/presentation/pages/budgets/budget_services_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../themes/oversight_colors.dart';

import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../navigation/enums/form_modes.dart';
import '../../../service/budgets/models/budget_model.dart';
import '../../../stores/budget/budget_cubit.dart';
import '../../widgets/widgets.dart';
import 'budget_creation_page.dart';
//import 'budget_creation_page.dart';

class BudgetsListPage extends StatefulWidget {
  const BudgetsListPage({super.key});

  @override
  State<BudgetsListPage> createState() => _BudgetsListPageState();
}

class _BudgetsListPageState extends State<BudgetsListPage> {
  late final BudgetCubit _cubit;

  //BudgetModel _budgetModel = const BudgetModel();

  List<BudgetModel> _budgetList = <BudgetModel>[];

  @override
  void initState() {
    _cubit = GetIt.I.get();
    _cubit.init();

    super.initState();
  }

  List<BudgetModel> getBudgetList(List<BudgetModel> budgetList) {
    return budgetList.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OversightColors.cultured,
      endDrawer: const OversightDrawer(),
      appBar: OversightAppBar(
        style: const OversightAppBarStyle(
          backgroundColor: OversightColors.cultured,
          elevation: 2,
        ),
        title: Text(
          'Orçamentos',
          style: OversightTextStyles.kBodyStrong.copyWith(
            color: OversightColors.primaryCian,
            fontSize: 25,
          ),
        ),
        action: [
          Builder(builder: (context) {
            return OversightButton(
              icon: Icons.menu,
              style: const OversightButtonStyle(
                backgroundColor: OversightColors.transparent,
                secondaryColor: OversightColors.primaryCian,
                pressedColor: OversightColors.transparent,
                width: 48.0,
                height: 48.0,
                iconSize: 22.0,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const VSpace(16),
            SearchBar(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              updateBudgetsList: (changedList) {
                setState(() {
                  _budgetList = changedList;
                });
              },
              cubit: _cubit,
              budgetList: _budgetList,
            ),
            BlocBuilder<BudgetCubit, BudgetState>(
              bloc: _cubit,
              builder: (context, state) {
                if (state is BudgetLoaded) {
                  List<BudgetModel> budgets = getBudgetList(
                    state.budgetList,
                  );

                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: budgets.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return OversightActionsCard(
                            isBudget: true,
                            onEdit: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BudgetServicesPage(
                                    budgetId: budgets[index].id,
                                    budgetModel: budgets[index],
                                    customerId: budgets[index].customerId,
                                  ),
                                ),
                              );
                            },
                            itemName: budgets[index].name,
                            status: budgets[index].status,
                            menuItemList: [
                              BubbleMenuItem(
                                text: 'Editar',
                                action: () async {
                                  bool? result =
                                      await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BudgetCreationPage(
                                        formMode: FormMode.update,
                                        budget: budgets[index],
                                        customerId: budgets[index].customerId,
                                        onRedirectAction: () {
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  );
                                  if (result != null) {
                                    _cubit.init();
                                  }
                                },
                              ),
                              BubbleMenuItem(
                                text: 'Deletar',
                                action: () {
                                  _cubit.deleteBudget(
                                    budgets[index].id.toString(),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                }

                if (state is BudgetSkeletonLoading) {
                  List<BudgetModel> budgets = getBudgetList(
                    state.budgetList,
                  );

                  return Skeletonizer(
                    enabled: true,
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: budgets.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return OversightActionsCard(
                              isBudget: false,
                              itemName: budgets[index].name,
                              quantity: 0,
                              price: 1000,
                              createdAt: 'XX/XX/XXXX',
                              menuItemList: [
                                BubbleMenuItem(
                                  text: 'Delete',
                                  action: () {},
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }

                return const Padding(
                  padding: EdgeInsets.only(top: 64.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: OversightColors.black,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => BudgetCreationPage(
                onRedirectAction: () {
                  setState(() {});
                },
              ),
            ),
          );
          if (result != null) {
            _cubit.init();
          }
        },
        tooltip: 'Add',
        backgroundColor: OversightColors.primaryCian,
        child: const Icon(
          Icons.add,
          color: OversightColors.white,
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final BudgetCubit cubit;
  final List<BudgetModel> budgetList;
  final Function(List<BudgetModel>) updateBudgetsList;
  final EdgeInsets padding;

  const SearchBar({
    Key? key,
    required this.cubit,
    required this.budgetList,
    required this.updateBudgetsList,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<BudgetCubit, BudgetState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is BudgetLoaded && budgetList.isEmpty) {
          updateBudgetsList(state.budgetList);
        }
        if (state is BudgetListChanged) {
          updateBudgetsList(state.budgetList);
        }
      },
      child: Padding(
        padding: padding,
        child: OversightInputSearch(
          placeholder: 'Buscar orçamentos',
          style: const OversightInputSearchStyle(
            height: 48,
          ),
          onQueryChanged: (value) {
            cubit.filter(budgetList, value);
          },
        ),
      ),
    );
  }
}
