import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';

import '../../../../navigation/enums/form_modes.dart';
import '../../../../navigation/navigation.dart';
import '../../../../service/budget_service/models/buget_service_model.dart';
import '../../../../service/budgets/models/budget_model.dart';
import '../../../../service/oversight_services/models/oversight_service_model.dart';
import '../../../../stores/budget_service/budget_service_cubit.dart';
import '../../../../stores/service/service_cubit.dart';
import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import '../../../widgets/widgets.dart';
import 'service_selection_page.dart';

class ServiceSelectionFlow extends StatefulWidget {
  final BudgetModel budgetModel;
  final List<BudgetServiceModel> budgetService;
  final FormMode formMode;
  final String customerId;
  final String budgetId;

  final VoidCallback? onRedirectAction;

  const ServiceSelectionFlow({
    Key? key,
    required this.budgetModel,
    this.budgetService = const <BudgetServiceModel>[],
    this.formMode = FormMode.update,
    this.onRedirectAction,
    this.customerId = '',
    required this.budgetId,
  }) : super(key: key);

  @override
  State<ServiceSelectionFlow> createState() => _ServiceSelectionFlowState();
}

class _ServiceSelectionFlowState extends State<ServiceSelectionFlow>
    with AutomaticKeepAliveClientMixin {
  late final BudgetServiceCubit _cubit;
  late final ServiceCubit _serviceCubit;

  double _progress = 0;
  int currentPage = 0;
  final PageController _progressController = PageController(initialPage: 0);

  @override
  void initState() {
    _cubit = GetIt.I.get();

    _serviceCubit = GetIt.I.get();
    _serviceCubit.init();

    _progress = 1 / 2; // Set the initial progress for the first page

    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  void _changePage() {
    currentPage++;

    _progress = (currentPage + 1) / 2;
    _progressController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _changeToPreviousPage() {
    currentPage--;

    _progress = (currentPage + 1) / 2;
    _progressController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  List<ServiceModel> getServiceList(List<ServiceModel> serviceList) {
    return serviceList.toList();
  }

  List<ServiceModel> selectedServices = [];

  List<BudgetServiceModel> selectedBudgetServices = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: OversightColors.cultured,
      appBar: OversightAppBar(
        style: const OversightAppBarStyle(
          backgroundColor: OversightColors.cultured,
          elevation: 2,
        ),
        title: Text(
          'Adicione serviços',
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
        leading: InkWell(
          onTap: () {
            navigator?.pop(true);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: OversightColors.primaryCian,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5),
          child: LinearProgressIndicator(
            minHeight: 5.0,
            value: _progress,
            color: OversightColors.grassGreen,
            backgroundColor: Colors.grey[300],
          ),
        ),
      ),
      body: PageView(
        controller: _progressController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
            _progress = (currentPage + 1) /
                2; // Update the progress based on the current page
          });
        },
        children: [
          ServiceSelectionPage(
            selectedBudgetServices: selectedBudgetServices,
            selectedServices: selectedServices,
            onNextPage: () => _changePage(),
          ),
          _buildBudgetServicesForm(),
        ],
      ),
    );
  }

  Column _buildBudgetServicesForm() {
    return Column(
      children: [
        const VSpace(20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Selecione a quantidade de cada serviço selecionado',
            style: OversightTextStyles.kBodyStrong.copyWith(
              fontSize: 20,
              color: OversightColors.primaryCian,
            ),
          ),
        ),
        const VSpace(20),
        BlocBuilder<ServiceCubit, ServiceState>(
          bloc: _serviceCubit,
          builder: (context, state) {
            if (state is ServiceLoaded) {
              List<ServiceModel> services = selectedServices;

              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: services.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: OversightExpandedCard(
                              title: services[index].name,
                              details: services[index].value.toString(),
                              onInputChanged: (newQuantity) {
                                final matchingService = selectedBudgetServices
                                    .firstWhere((element) =>
                                        element.serviceId ==
                                        services[index].id);

                                final updatedBudgetService =
                                    matchingService.copyWith(
                                  quantity: int.parse(newQuantity),
                                  budgetedUnitValue:
                                      services[index].value.toDouble() *
                                          int.parse(newQuantity),
                                );

                                final updatedList = [...selectedBudgetServices];

                                final indexToUpdate =
                                    selectedBudgetServices.indexWhere(
                                  (element) => element == matchingService,
                                );

                                if (indexToUpdate != -1) {
                                  updatedList[indexToUpdate] =
                                      updatedBudgetService;
                                }

                                setState(() {
                                  selectedBudgetServices = updatedList;
                                });
                              },
                              onPressed: () {},
                            ),
                          );
                        },
                      ),
                    ],
                  ),
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
        _buildFinishBudgetFlow(),
      ],
    );
  }

  SingleChildScrollView _buildFinishBudgetFlow() {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<BudgetServiceCubit, BudgetServiceState>(
            bloc: _cubit,
            builder: (context, state) {
              return OversightButton(
                title: 'Concluir',
                isLoading: false,
                responsiveText: true,
                iconPosition: IconPosition.left,
                onPressed: () async {
                  List<BudgetServiceModel> addedBudgetServiceList = await _cubit
                      .budgetServiceUseCase.budgetServiceService
                      .getBudgetService(widget.budgetId);

                  if (addedBudgetServiceList.isEmpty) {
                    await _cubit.addBudgetService(
                      selectedBudgetServices,
                      widget.budgetId,
                    );
                    widget.onRedirectAction;
                    navigator?.pop(true);
                  }

                  if (addedBudgetServiceList.isNotEmpty) {
                    List<BudgetServiceModel> updatedBudgetServiceList = [];
                    List<BudgetServiceModel> budgetServiceAddedLaterList = [];

                    for (var selectedBudgetService in selectedBudgetServices) {
                      bool alreadyExists = addedBudgetServiceList.any(
                        (element) =>
                            element.serviceId ==
                            selectedBudgetService.serviceId,
                      );

                      if (alreadyExists) {
                        BudgetServiceModel addedBudgetServiceModel =
                            addedBudgetServiceList.firstWhere((element) =>
                                element.serviceId ==
                                selectedBudgetService.serviceId);

                        addedBudgetServiceModel =
                            addedBudgetServiceModel.copyWith(
                          budgetId: addedBudgetServiceModel.budgetId,
                          serviceId: addedBudgetServiceModel.serviceId,
                          quantity: selectedBudgetService.quantity,
                          budgetedUnitValue:
                              ((addedBudgetServiceModel.budgetedUnitValue /
                                      addedBudgetServiceModel.quantity) *
                                  selectedBudgetService.quantity),
                        );

                        updatedBudgetServiceList.add(addedBudgetServiceModel);
                      } else {
                        budgetServiceAddedLaterList.add(selectedBudgetService);
                      }
                    }
                    if (budgetServiceAddedLaterList.isNotEmpty) {
                      await _cubit.addBudgetService(
                        budgetServiceAddedLaterList,
                        widget.budgetId,
                      );
                    }

                    if (updatedBudgetServiceList.isNotEmpty) {
                      await _cubit.editBudgetService(
                        updatedBudgetServiceList,
                        widget.budgetId,
                      );
                    }

                    widget.onRedirectAction;
                    navigator?.pop(true);
                  }
                },
                style: OversightButtonStyle(
                  textStyle: OversightTextStyles.kBodyStrong.copyWith(
                    fontSize: 16,
                  ),
                  backgroundColor: OversightColors.secondaryCian,
                  width: 350,
                ),
              );
            },
          ),
          const VSpace(20),
          OversightButton(
            title: 'Voltar',
            isLoading: false,
            responsiveText: true,
            iconPosition: IconPosition.left,
            onPressed: () {
              _changeToPreviousPage();
            },
            style: OversightButtonStyle(
              textStyle: OversightTextStyles.kBodyStrong.copyWith(
                fontSize: 16,
              ),
              backgroundColor: OversightColors.primaryCian,
              width: 350,
            ),
          ),
          const VSpace(20),
        ],
      ),
    );
  }
}
