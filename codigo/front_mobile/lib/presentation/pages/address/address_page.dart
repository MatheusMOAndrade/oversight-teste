import 'package:get_it/get_it.dart';
import 'package:oversight/service/address/models/address_model.dart';
import 'package:oversight/stores/address/address_cubit.dart';

import '../../../navigation/enums/form_modes.dart';
import '../../../presentation/widgets/widgets.dart';
import '../../../themes/themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddressCreate extends StatefulWidget {
  final FormMode formMode;

  const AddressCreate({
    Key? key,
    this.formMode = FormMode.create,
  }) : super(key: key);

  @override
  State<AddressCreate> createState() => _AddressCreateState();
}

class _AddressCreateState extends State<AddressCreate> {
  String? _cep;
  String? _street;
  int? _number;
  String? _complement;

  late final AddressCubit _cubit;
  final _formKey = GlobalKey<FormBuilderState>();

  AddressModel _addressModel = const AddressModel();

  @override
  void initState() {
    _cubit = GetIt.I.get();
    _cubit.init();

    super.initState();

    // if (widget.formMode != FormMode.create){
    //     _getAddress();
    // }
  }

  void _getAddress() {
    _addressModel = _cubit.getAddress() as AddressModel;
  }

  void _onChanged(AddressModel address) {
    _addressModel = _addressModel.copyWith(
        cep: address.cep, street: address.street, number: address.number);
  }

  void _updateAddress() {
    _onChanged(
      AddressModel(
        cep: _cep ?? _addressModel.cep,
        street: _street ?? _addressModel.street,
        complement: _complement ?? _addressModel.complement,
        number: _number ?? _addressModel.number,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OversightColors.cultured,
      appBar: OversightAppBar(
        style: const OversightAppBarStyle(
          backgroundColor: OversightColors.primaryCian,
          actionsIconTheme: IconThemeData(
            color: OversightColors.white,
            size: 14,
          ),
        ),
        title: Text(
          (widget.formMode == FormMode.create)
              ? 'Novo cliente'
              : 'Editar cliente',
          style: OversightTextStyles.kBodyStrongWhite,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: OversightColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: OversightFormFieldInput(
                  name: 'cep',
                  topLabel: 'CEP',
                  initialValue: _addressModel.cep,
                  placeholder: 'Digite o seu CEP',
                  validator: FormBuilderValidators.required(),
                  style: const OversightInputStyle(
                    height: 40,
                    borderColor: OversightColors.black,
                  ),
                  onChanged: (value) {
                    _cep = value;

                    _updateAddress();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: OversightFormFieldInput(
                  name: 'street',
                  topLabel: 'Endereço',
                  placeholder: 'Digite o seu endereço',
                  style: const OversightInputStyle(
                    height: 40,
                    borderColor: OversightColors.black,
                  ),
                  validator: FormBuilderValidators.required(),
                  initialValue: _addressModel.street,
                  onChanged: (value) {
                    _street = value;

                    _updateAddress();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: OversightFormFieldInput(
                  name: 'number',
                  style: const OversightInputStyle(
                    height: 40,
                    borderColor: OversightColors.black,
                  ),
                  topLabel: 'Número',
                  initialValue: _addressModel.number.toString(),
                  placeholder: 'Digite o numero',
                  validator: FormBuilderValidators.required(),
                  onChanged: (value) {
                    _number = int.parse(value);

                    _updateAddress();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: OversightFormFieldInput(
                  name: 'complement',
                  style: const OversightInputStyle(
                    height: 40,
                    borderColor: OversightColors.black,
                  ),
                  topLabel: 'Complemento',
                  placeholder: 'Digite o complemento',
                  initialValue: _addressModel.complement,
                  onChanged: (value) {
                    _complement = value;

                    _updateAddress();
                  },
                ),
              ),
              OversightButton(
                title: 'Salvar',
                isLoading: false,
                responsiveText: true,
                iconPosition: IconPosition.left,
                onPressed: () {
                  _cubit.addAddress(
                    _addressModel,
                  );

                  _addressModel = const AddressModel();

                  Navigator.of(context).pop();
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
        ),
      ),
    );
  }
}
