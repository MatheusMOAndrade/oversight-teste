import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';

import '../../../navigation/navigation.dart';
import '../../../service/budget_service/models/buget_service_model.dart';
import '../../../service/budgets/models/budget_model.dart';
import '../../../service/customer/models/customer_model.dart';
import '../../../navigation/enums/form_modes.dart';
import '../../../presentation/widgets/widgets.dart';
import '../../../service/oversight_services/models/oversight_service_model.dart';
import '../../../stores/budget/budget_cubit.dart';
import '../../../stores/budget_service/budget_service_cubit.dart';
import '../../../stores/customer/customer_cubit.dart';
import '../../../stores/service/service_cubit.dart';
import '../../../themes/themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'components/budget_initial_info_form.dart';

class BudgetCreationPage extends StatefulWidget {
  final CustomerModel customer;
  final BudgetModel budget;
  final List<BudgetServiceModel> budgetService;
  final FormMode formMode;
  final String customerId;

  final VoidCallback? onRedirectAction;

  const BudgetCreationPage({
    Key? key,
    this.customer = const CustomerModel(),
    this.budget = const BudgetModel(),
    this.budgetService = const <BudgetServiceModel>[],
    this.formMode = FormMode.create,
    this.onRedirectAction,
    this.customerId = '',
  }) : super(key: key);

  @override
  State<BudgetCreationPage> createState() => _BudgetCreationPageState();
}

class _BudgetCreationPageState extends State<BudgetCreationPage> {
  String _name = '';
  String _customerId = '';
  String _description = '';
  String _incomingMargin = '';

  late final BudgetCubit _cubit;
  late final ServiceCubit _serviceCubit;
  late final CustomerCubit _customerCubit;
  late final BudgetServiceCubit _budgetServiceCubit;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  double _progress = 0;
  int currentPage = 0;
  final PageController _progressController = PageController(initialPage: 0);

  @override
  void initState() {
    _cubit = GetIt.I.get();

    _serviceCubit = GetIt.I.get();
    _serviceCubit.init();
    _customerCubit = GetIt.I.get();
    _customerCubit.init();
    _budgetServiceCubit = GetIt.I.get();

    _progress = 1 / 2; // Set the initial progress for the first page

    super.initState();
  }

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

  List<ServiceModel> selectedServices = [];

  List<BudgetServiceModel> selectedBudgetServices = [];

  List<CustomerModel> getCustomerList(List<CustomerModel> customerList) {
    return customerList.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OversightColors.cultured,
      appBar: OversightAppBar(
        style: const OversightAppBarStyle(
          backgroundColor: OversightColors.cultured,
          elevation: 2,
        ),
        title: Text(
          (widget.formMode == FormMode.create)
              ? 'Novo orçamento'
              : 'Editar orçamento',
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
          _buildInitialInfoForm(),
          _buildFinishBudgetFlow(),
        ],
      ),
    );
  }

  BudgetInitialInfoForm _buildInitialInfoForm() {
    return BudgetInitialInfoForm(
      formKey: _formKey,
      customerId: widget.customer.id,
      name: widget.budget.name,
      description: widget.budget.description,
      incomingMargin: widget.budget.incomingMargin.toString(),
      customerDropdown: BlocBuilder<CustomerCubit, CustomerState>(
        bloc: _customerCubit,
        builder: (context, state) {
          if (state is CustomerLoaded) {
            List<CustomerModel> customers = getCustomerList(
              state.customerList,
            );

            return Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldDropdown(
                name: 'customer',
                topLabel: 'Cliente',
                placeholder: widget.customerId != ''
                    ? customers
                        .firstWhere(
                          (customer) => widget.customerId == customer.id,
                        )
                        .name
                    : 'Escolha o nome do cliente',
                initialValue: widget.customerId,
                style: const OversightDropdownStyle(
                  borderColor: OversightColors.black,
                ),
                validator: FormBuilderValidators.required(),
                items: customers.map((customer) => customer.name).toList(),
                onItemSelected: (value) => setState(() {
                  _customerId = customers
                      .firstWhere((element) => element.name == value)
                      .id;
                }),
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
      onNameChanged: (value) => setState(() {
        _name = value;
      }),
      onDescriptionChanged: (value) => setState(() {
        _description = value;
      }),
      onIncomingMarginChanged: (value) => setState(() {
        _incomingMargin = value;
      }),
      onCustomerIdSelected: (value) => setState(() {
        _customerId = value ?? '';
      }),
      onNextPage: () => _changePage(),
    );
  }

  SingleChildScrollView _buildFinishBudgetFlow() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const VSpace(20),
          Text(
            'Deseja concluir a operação?',
            style: OversightTextStyles.kBodyStrong.copyWith(
              fontSize: 20,
            ),
          ),
          const VSpace(20),
          BlocBuilder<BudgetCubit, BudgetState>(
            bloc: _cubit,
            builder: (context, state) {
              return OversightButton(
                title: 'Concluir',
                isLoading: false,
                responsiveText: true,
                iconPosition: IconPosition.left,
                onPressed: () async {
                  if (widget.formMode == FormMode.create) {
                    await _cubit.addBudget(
                      widget.budget.copyWith(
                        name: _name,
                        customerId: _customerId,
                        description: _description,
                        incomingMargin: int.parse(_incomingMargin),
                        status: 'budgeting',
                      ),
                      selectedBudgetServices,
                    );

                    widget.budget.copyWith(
                      name: '',
                      customerId: '',
                      description: '',
                      incomingMargin: 0,
                      status: '',
                    );
                    // widget.address.copyWith(
                    //   cep: '',
                    //   complement: '',
                    //   street: '',
                    //   number: '',
                    // );

                    navigator?.pop(true);
                  }
                  if (widget.formMode == FormMode.update) {
                    BudgetModel updatedBudgetModel;

                    updatedBudgetModel = widget.budget.copyWith(
                      name: _name != '' ? _name : widget.budget.name,
                      customerId: _customerId != ''
                          ? _customerId
                          : widget.budget.customerId,
                      description: _description != ''
                          ? _description
                          : widget.budget.description,
                      incomingMargin: _incomingMargin != ''
                          ? int.parse(_incomingMargin)
                          : widget.budget.incomingMargin,
                      status: 'budgeting',
                    );

                    _cubit.editBudget(
                      updatedBudgetModel,
                      selectedBudgetServices,
                      widget.budget.id,
                    );

                    widget.customer.copyWith(
                      email: '',
                      name: '',
                      phone: '',
                    );

                    // widget.address.copyWith(
                    //   cep: '',
                    //   complement: '',
                    //   street: '',
                    //   number: '',
                    // );

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
