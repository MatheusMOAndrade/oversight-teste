import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';

import '../../../../service/customer/models/customer_model.dart';
import '../../../../stores/customer/customer_cubit.dart';
import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';

import '../../../widgets/widgets.dart';

class BudgetInitialInfoForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> _formKey;
  final String name;
  final String description;
  final Widget customerDropdown;
  final String customerId;
  final String incomingMargin;
  final Function(String)? onNameChanged;
  final Function(String)? onDescriptionChanged;
  final Function(String)? onIncomingMarginChanged;
  final Function(String?)? onCustomerIdSelected;
  final VoidCallback onNextPage;

  const BudgetInitialInfoForm({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
    required this.name,
    required this.description,
    required this.incomingMargin,
    required this.customerId,
    required this.onNameChanged,
    required this.onIncomingMarginChanged,
    required this.onDescriptionChanged,
    required this.onCustomerIdSelected,
    required this.onNextPage,
    required this.customerDropdown,
  }) : _formKey = formKey;

  @override
  State<BudgetInitialInfoForm> createState() => _BudgetInitialInfoFormState();
}

class _BudgetInitialInfoFormState extends State<BudgetInitialInfoForm> {
  late final CustomerCubit _cubit;

  @override
  void initState() {
    _cubit = GetIt.I.get();
    _cubit.init();

    super.initState();
  }

  List<CustomerModel> getCustomerList(List<CustomerModel> customerList) {
    return customerList.toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: widget._formKey,
        child: Column(
          children: [
            widget.customerDropdown,
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldInput(
                name: 'name',
                topLabel: 'Nome',
                placeholder: 'Digite o nome do orçamento',
                validator: FormBuilderValidators.required(),
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                initialValue: widget.name,
                onChanged: widget.onNameChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldInput(
                name: 'description',
                topLabel: 'Descrição',
                placeholder: 'Digite uma descrição',
                validator: FormBuilderValidators.email(),
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                initialValue: widget.description,
                onChanged: widget.onDescriptionChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldInput(
                name: 'incoming_margin',
                topLabel: 'Margem de Lucro',
                initialValue: widget.incomingMargin.toString(),
                placeholder: 'Digite a margem de lucro',
                validator: FormBuilderValidators.required(),
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                onChanged: widget.onIncomingMarginChanged,
              ),
            ),
            const VSpace(20),
            OversightButton(
              title: 'Próxima',
              isLoading: false,
              responsiveText: true,
              iconPosition: IconPosition.left,
              onPressed: widget.onNextPage,
              style: OversightButtonStyle(
                textStyle: OversightTextStyles.kBodyStrong.copyWith(
                  fontSize: 16,
                ),
                backgroundColor: OversightColors.primaryCian,
                width: 350,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
