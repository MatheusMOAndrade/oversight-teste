// import 'dart:ffi';

// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../navigation/navigation.dart';
import '../../../service/oversight_services/models/oversight_service_model.dart';
import '../../../navigation/enums/form_modes.dart';
import '../../../presentation/widgets/widgets.dart';
import '../../../stores/service/service_cubit.dart';
import '../../../themes/themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ServiceCreation extends StatefulWidget {
  final ServiceModel service;
  final FormMode formMode;
  final String serviceId;

  final VoidCallback? onRedirectAction;

  const ServiceCreation({
    Key? key,
    this.service = const ServiceModel(),
    this.formMode = FormMode.create,
    this.onRedirectAction,
    this.serviceId = '',
  }) : super(key: key);

  @override
  State<ServiceCreation> createState() => _ServiceCreationState();
}

class _ServiceCreationState extends State<ServiceCreation> {
  String _name = '';
  String _description = '';
  String _mesureUnit = '';
  int _value = 0;
  String _type = '';
  int _errorMargin = 0;
  late final ServiceCubit _cubit;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  List<String> typesList = ['service', 'good'];
  List<String> mesureUnitsList = [
    'm',
    'm2',
    'm3',
    'ml',
    'l',
    'hour',
    'day',
    'week',
  ];

  double _progress = 0;
  int currentPage = 0;
  final PageController _progressController = PageController(initialPage: 0);

  @override
  void initState() {
    _cubit = GetIt.I.get();

    _progress = 1 / 2; // Set the initial progress for the first page

    super.initState();
  }

  void showServiceEmailExistSnackbar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Current Service Email already exist.'),
      ),
    );
  }

  void _changePage() {
    if (currentPage < 1) {
      currentPage++;
    } else {
      currentPage--;
    }
    _progress = (currentPage + 1) / 2;
    _progressController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
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
              ? 'Novo serviço'
              : 'Editar serviço',
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
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: OversightColors.primaryCian,
          ),
        ),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(5),
        //   child: LinearProgressIndicator(
        //     minHeight: 5.0,
        //     value: _progress,
        //     color: OversightColors.grassGreen,
        //     backgroundColor: Colors.grey[300],
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: OversightFormFieldInput(
                  name: 'name',
                  topLabel: 'Nome',
                  placeholder: 'Digite o nome do serviço',
                  initialValue: widget.service.name,
                  style: const OversightInputStyle(
                    height: 40,
                    borderColor: OversightColors.black,
                  ),
                  validator: FormBuilderValidators.required(),
                  onChanged: (value) => setState(() {
                    _name = value;
                    print(_name);
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: OversightFormFieldInput(
                  name: 'description',
                  topLabel: 'Descrição',
                  placeholder: 'Descrição do serviço',
                  initialValue: widget.service.description,
                  style: const OversightInputStyle(
                    height: 40,
                    borderColor: OversightColors.black,
                  ),
                  validator: FormBuilderValidators.required(),
                  onChanged: (value) => setState(() {
                    _description = value;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: OversightFormFieldDropdown(
                  name: 'mesureUnit',
                  topLabel: 'Unidade de Medida',
                  placeholder: widget.service.mesureUnit != ''
                      ? widget.service.mesureUnit
                      : 'Escolha a unidade de medida',
                  style: const OversightDropdownStyle(
                    borderColor: OversightColors.black,
                  ),
                  items:
                      mesureUnitsList.map((mesureUnit) => mesureUnit).toList(),
                  onItemSelected: (value) => setState(() {
                    _mesureUnit = mesureUnitsList
                        .firstWhere((element) => element == value.toString());
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: OversightFormFieldInput(
                  name: 'value',
                  topLabel: 'Valor unitário',
                  placeholder: 'Valor unitário do serviço',
                  initialValue: widget.service.value.toString(),
                  validator: FormBuilderValidators.numeric(),
                  keyboardType: TextInputType.number,
                  style: const OversightInputStyle(
                    height: 40,
                    borderColor: OversightColors.black,
                  ),
                  onChanged: (value) => setState(() {
                    _value = int.parse(value);
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: OversightFormFieldDropdown(
                  name: 'type',
                  topLabel: 'Tipo de serviço',
                  placeholder: widget.service.type != ''
                      ? widget.service.type
                      : 'Escolha o tipo de serviço',
                  style: const OversightDropdownStyle(
                    borderColor: OversightColors.black,
                  ),
                  items: typesList.map((type) => type).toList(),
                  onItemSelected: (value) => setState(() {
                    _type = typesList
                        .firstWhere((element) => element == value.toString());
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: OversightFormFieldInput(
                  name: 'errorMargin',
                  topLabel: 'Margem de erro',
                  placeholder: 'Margem de erro do serviço, em porcentagem',
                  initialValue: widget.service.value.toString(),
                  validator: FormBuilderValidators.required(),
                  keyboardType: TextInputType.number,
                  style: const OversightInputStyle(
                    height: 40,
                    borderColor: OversightColors.black,
                  ),
                  onChanged: (value) => setState(() {
                    _errorMargin = int.parse(value);
                  }),
                ),
              ),
              const VSpace(20),
              BlocBuilder<ServiceCubit, ServiceState>(
                bloc: _cubit,
                builder: (context, state) {
                  return OversightButton(
                    title: 'Concluir',
                    isLoading: false,
                    responsiveText: true,
                    iconPosition: IconPosition.left,
                    onPressed: () {
                      if (widget.formMode == FormMode.create &&
                          _formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        _cubit.addService(
                          widget.service.copyWith(
                            name: _name,
                            description: _description,
                            errorMargin: _errorMargin,
                            type: _type,
                            mesureUnit: _mesureUnit,
                            value: _value,
                          ),
                        );

                        widget.service.copyWith(
                          name: '',
                          description: '',
                          errorMargin: 0,
                          mesureUnit: '',
                          type: '',
                          value: 0,
                        );

                        navigator?.pop(true);
                      }
                      if (widget.formMode == FormMode.update) {
                        ServiceModel serviceModelUpdated;

                        serviceModelUpdated = widget.service.copyWith(
                          name: _name,
                          description: _description,
                          errorMargin: _errorMargin,
                          type: _type,
                          mesureUnit: _mesureUnit,
                          value: _value,
                        );

                        _cubit.editService(
                          serviceModelUpdated,
                          widget.serviceId,
                          showServiceEmailExistSnackbar,
                        );

                        widget.service.copyWith(
                          name: '',
                          description: '',
                          errorMargin: 0,
                          mesureUnit: '',
                          type: '',
                          value: 0,
                        );

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
            ],
          ),
        ),
      ),
    );
  }
}
