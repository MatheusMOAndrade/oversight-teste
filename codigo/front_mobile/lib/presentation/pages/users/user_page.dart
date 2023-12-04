import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:oversight/navigation/enums/form_modes.dart';
import 'package:oversight/presentation/widgets/buttons/button/oversight_button_style.dart';
import 'package:oversight/presentation/widgets/dropdowns/dropdown/dropdown.dart';
import 'package:oversight/presentation/widgets/input/form_field_input/form_field_input.dart';
import 'package:oversight/presentation/widgets/navigation/app_bar/app_bar.dart';
import 'package:oversight/service/user/models/user_model.dart';
import 'package:oversight/stores/user/user_cubit.dart';
import 'package:oversight/themes/oversight_colors.dart';
import 'package:oversight/themes/oversight_text_styles.dart';

import '../../widgets/buttons/button/oversight_button.dart';

class UserPage extends StatefulWidget {
  final UserModel user;
  final FormMode formMode;

  const UserPage({
    Key? key,
    this.user = const UserModel(),
    this.formMode = FormMode.create,
  }) : super(key: key);

  @override
  State<UserPage> createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  String? _name;
  String? _email;
  String? _role;
  String? _password;
  late final UserCubit _cubit;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _cubit = GetIt.I.get();
    super.initState();
  }

  void showCustomerEmailExistSnackbar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Current User Email already exist.'),
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
              ? 'Novo Usuário'
              : 'Editar Usuário',
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
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldInput(
                name: 'name',
                topLabel: 'Nome',
                placeholder: 'Digite o nome',
                initialValue: widget.user.name,
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                validator: FormBuilderValidators.required(),
                onChanged: (value) => setState(() {
                  _name = value;
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldInput(
                name: 'email',
                topLabel: 'Email',
                placeholder: 'Digite o email',
                initialValue: widget.user.email,
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                validator: FormBuilderValidators.email(),
                onChanged: (value) => setState(() {
                  _email = value;
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: OversightFormFieldDropdown(
                name: 'role',
                topLabel: 'Função',
                items: const ['admin', 'basic'],
                placeholder: widget.user.role != ''
                    ? widget.user.role
                    : 'Escolha a sua função',
                validator: FormBuilderValidators.required(),
                onItemSelected: (value) => setState(() {
                  _role = value;
                }),
              ),
            ),
            widget.formMode == FormMode.create
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                    child: OversightFormFieldInput(
                      name: 'password',
                      topLabel: 'Senha',
                      placeholder: 'Digite a senha',
                      obscure: true,
                      initialValue: widget.user.password,
                      style: const OversightInputStyle(
                        height: 40,
                        borderColor: OversightColors.black,
                      ),
                      validator: FormBuilderValidators.required(),
                      onChanged: (value) => setState(() {
                        _password = value;
                      }),
                    ),
                  )
                : Container(),
            OversightButton(
              title: 'Salvar',
              isLoading: false,
              responsiveText: true,
              iconPosition: IconPosition.left,
              onPressed: () {
                if (widget.formMode == FormMode.create) {
                  _cubit.addUser(
                    widget.user.copyWith(
                      email: _email,
                      name: _name,
                      password: _password,
                      role: _role,
                    ),
                    userEmailExistCallback: showCustomerEmailExistSnackbar,
                  );

                  widget.user.copyWith(
                    email: '',
                    name: '',
                    password: '',
                    role: '',
                  );

                  Navigator.of(context).pop();
                }
                if (widget.formMode == FormMode.update &&
                    _formKey.currentState!.validate()) {
                  _cubit.editUser(
                    widget.user.copyWith(
                      email: _email,
                      name: _name,
                      password: _password,
                      role: _role,
                    ),
                    widget.user.id,
                    showCustomerEmailExistSnackbar,
                  );

                  widget.user.copyWith(
                    email: '',
                    name: '',
                    password: '',
                    role: '',
                  );
                  Navigator.of(context).pop();
                }
              },
              style: OversightButtonStyle(
                textStyle: OversightTextStyles.kBodyStrong.copyWith(
                  fontSize: 16,
                ),
                backgroundColor: OversightColors.primaryCian,
                width: 350,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
