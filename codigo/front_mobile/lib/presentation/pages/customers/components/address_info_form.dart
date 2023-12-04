import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import '../../../widgets/widgets.dart';

class AddressInfoForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> _formKey;
  final int number;
  final String street;
  final String cep;
  final String complement;
  final Function(String)? onNumberChanged;
  final Function(String)? onCepChanged;
  final Function(String)? onStreetChanged;
  final Function(String)? onComplementChanged;
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;

  const AddressInfoForm({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
    required this.number,
    required this.cep,
    required this.street,
    required this.complement,
    required this.onNumberChanged,
    required this.onComplementChanged,
    required this.onCepChanged,
    required this.onStreetChanged,
    required this.onNextPage,
    required this.onPreviousPage,
  }) : _formKey = formKey;

  @override
  State<AddressInfoForm> createState() => _AddressInfoFormState();
}

class _AddressInfoFormState extends State<AddressInfoForm>
    with AutomaticKeepAliveClientMixin<AddressInfoForm> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: FormBuilder(
        key: widget._formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldInput(
                name: 'cep',
                topLabel: 'Cep',
                initialValue: widget.cep,
                placeholder: 'Digite o CEP',
                validator: FormBuilderValidators.numeric(),
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                onChanged: widget.onCepChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldInput(
                name: 'street',
                topLabel: 'Rua',
                placeholder: 'Digite a sua rua',
                validator: FormBuilderValidators.required(),
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                initialValue: widget.street,
                onChanged: widget.onStreetChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldInput(
                name: 'number',
                topLabel: 'Numero',
                placeholder: 'Digite o numero',
                initialValue: widget.number.toString(),
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                validator: FormBuilderValidators.numeric(),
                onChanged: widget.onNumberChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldInput(
                name: 'complement',
                topLabel: 'Complemento',
                placeholder: 'Digite o complemento',
                initialValue: widget.complement,
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                validator: FormBuilderValidators.required(),
                onChanged: widget.onComplementChanged,
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
            const VSpace(20),
            OversightButton(
              title: 'Voltar',
              isLoading: false,
              responsiveText: true,
              iconPosition: IconPosition.left,
              onPressed: widget.onPreviousPage,
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
      ),
    );
  }
}
