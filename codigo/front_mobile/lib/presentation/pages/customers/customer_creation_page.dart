import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:oversight/api/dio_exception.dart';
import 'package:oversight/navigation/navigation.dart';

import '../../../service/address/models/address_model.dart';
import '../../../service/customer/models/customer_model.dart';
import '../../../navigation/enums/form_modes.dart';
import '../../../presentation/widgets/widgets.dart';

import '../../../stores/customer/customer_cubit.dart';
import '../../../themes/themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'components/address_info_form.dart';
import 'components/customer_initial_info_form.dart';

class CustomerCreation extends StatefulWidget {
  final CustomerModel customer;
  final AddressModel address;
  final FormMode formMode;
  final String customerId;

  final VoidCallback? onRedirectAction;

  const CustomerCreation({
    Key? key,
    this.customer = const CustomerModel(),
    this.address = const AddressModel(),
    this.formMode = FormMode.create,
    this.onRedirectAction,
    this.customerId = '',
  }) : super(key: key);

  @override
  State<CustomerCreation> createState() => _CustomerCreationState();
}

class _CustomerCreationState extends State<CustomerCreation> {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _cep = '';
  String _street = '';
  String _number = '';
  String _complement = '';
  late final CustomerCubit _cubit;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _formKeyAddress =
      GlobalKey<FormBuilderState>();
  double _progress = 0;
  int currentPage = 0;
  final PageController _progressController = PageController(initialPage: 0);

  @override
  void initState() {
    _cubit = GetIt.I.get();

    _progress = 1 / 3; // Set the initial progress for the first page

    super.initState();
  }

  void showCustomerEmailExistSnackbar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Current Customer Email already exist.'),
      ),
    );
  }

  void _changePage() {
    currentPage++;

    _progress = (currentPage + 1) / 3;
    _progressController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _changeToPreviousPage() {
    _progress = (currentPage + 1) / 3;
    _progressController.previousPage(
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
              ? 'Novo cliente'
              : 'Editar cliente',
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
                3; // Update the progress based on the current page
          });
        },
        children: [
          CustomerInitialInfoForm(
            formKey: _formKey,
            name: widget.customer.name,
            email: widget.customer.email,
            phone: widget.customer.phone,
            onNameChanged: (value) => setState(() {
              _name = value;
            }),
            onEmailChanged: (value) => setState(() {
              _email = value;
            }),
            onPhoneChanged: (value) => setState(() {
              _phone = value;
            }),
            onNextPage: () => _changePage(),
          ),
          AddressInfoForm(
            formKey: _formKeyAddress,
            cep: widget.address.cep,
            number: widget.address.number,
            complement: widget.address.complement,
            street: widget.address.street,
            onNumberChanged: (value) => setState(() {
              _number = value;
            }),
            onComplementChanged: (value) => setState(() {
              _complement = value;
            }),
            onStreetChanged: (value) => setState(() {
              _street = value;
            }),
            onCepChanged: (value) => setState(() {
              _cep = value;
            }),
            onNextPage: () => _changePage(),
            onPreviousPage: () => _changeToPreviousPage(),
          ),
          _finishOperation(),
        ],
      ),
    );
  }

  SingleChildScrollView _finishOperation() {
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
          BlocBuilder<CustomerCubit, CustomerState>(
            bloc: _cubit,
            builder: (context, state) {
              return OversightButton(
                title: 'Concluir',
                isLoading: false,
                responsiveText: true,
                iconPosition: IconPosition.left,
                onPressed: () async {
                  if (widget.formMode == FormMode.create) {
                    try {
                      await _cubit.addCustomer(
                        widget.customer.copyWith(
                          email: _email,
                          name: _name,
                          phone: _phone,
                        ),
                        widget.address.copyWith(
                          cep: _cep,
                          complement: _complement,
                          street: _street,
                          number: int.parse(_number),
                        ),
                        customerEmailExistCallback:
                            showCustomerEmailExistSnackbar,
                      );
                    } on DioExceptions catch (e) {
                      navigator?.pop(true);
                      _changeToPreviousPage();
                    }

                    widget.customer.copyWith(
                      email: '',
                      name: '',
                      phone: '',
                    );

                    widget.address.copyWith(
                      cep: '',
                      complement: '',
                      street: '',
                      number: 0,
                    );

                    navigator?.pop(true);
                  }
                  if (widget.formMode == FormMode.update) {
                    CustomerModel customerUpdated;
                    AddressModel addressUpdated;

                    customerUpdated = widget.customer.copyWith(
                      email: _email != '' ? _email : widget.customer.email,
                      name: _name != '' ? _name : widget.customer.name,
                      phone: _phone != '' ? _phone : widget.customer.phone,
                    );

                    addressUpdated = widget.address.copyWith(
                      cep: _cep != '' ? _cep : widget.address.cep,
                      complement: _complement != ''
                          ? _complement
                          : widget.address.complement,
                      street: _street != '' ? _street : widget.address.street,
                      number: _number != ''
                          ? int.parse(_number)
                          : widget.address.number,
                    );

                    _cubit.editCustomer(
                      customerUpdated,
                      addressUpdated,
                      widget.customerId,
                      showCustomerEmailExistSnackbar,
                    );

                    widget.customer.copyWith(
                      email: '',
                      name: '',
                      phone: '',
                    );

                    widget.address.copyWith(
                      cep: '',
                      complement: '',
                      street: '',
                      number: 0,
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
