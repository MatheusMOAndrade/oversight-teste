import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';

import '../../../widgets/widgets.dart';

class CustomerInitialInfoForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> _formKey;
  final String name;
  final String email;
  final String phone;
  final Function(String)? onNameChanged;
  final Function(String)? onPhoneChanged;
  final Function(String)? onEmailChanged;
  final VoidCallback onNextPage;

  const CustomerInitialInfoForm({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
    required this.name,
    required this.phone,
    required this.email,
    required this.onNameChanged,
    required this.onPhoneChanged,
    required this.onEmailChanged,
    required this.onNextPage,
  }) : _formKey = formKey;

  @override
  State<CustomerInitialInfoForm> createState() =>
      _CustomerInitialInfoFormState();
}

class _CustomerInitialInfoFormState extends State<CustomerInitialInfoForm>
    with AutomaticKeepAliveClientMixin<CustomerInitialInfoForm> {
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
                name: 'name',
                topLabel: 'Nome',
                placeholder: 'Digite o seu nome',
                initialValue: widget.name,
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                validator: FormBuilderValidators.required(),
                onChanged: widget.onNameChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldInput(
                name: 'email',
                topLabel: 'Email',
                placeholder: 'Digite o seu email',
                validator: FormBuilderValidators.email(),
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                initialValue: widget.email,
                onChanged: widget.onEmailChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldInput(
                name: 'phone',
                topLabel: 'Telefone',
                initialValue: widget.phone,
                placeholder: 'Digite o telefone',
                validator: FormBuilderValidators.required(),
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                onChanged: widget.onPhoneChanged,
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
