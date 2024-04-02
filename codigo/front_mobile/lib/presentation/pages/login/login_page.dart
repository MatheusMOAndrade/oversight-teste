import '../../../constants/app_image_asset.dart';
import '../../../stores/auth/auth_cubit.dart';
import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import '../../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthCubit _cubit;
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  String _email = '';
  String _password = '';

  @override
  void initState() {
    _cubit = GetIt.I.get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cubit,
      listener: (context, state) {
        if (state is AuthSuccessState) {
          state.onLoginSuccessfull();
          showToast(
            context,
            'Bem vindo ao Oversight!',
            Icons.check,
            OversightColors.grassGreen,
          );
        }

        if (state is AuthFailureState) {
          showToast(
            context,
            'Falha na autenticação',
            Icons.close,
            OversightColors.darkRed,
          );
        }
      },
      child: Scaffold(
        backgroundColor: OversightColors.cultured,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SafeArea(
            child: Stack(children: [
              const Positioned(
                left: -80,
                top: -100,
                child: SizedBox(
                  height: 2030,
                  width: 450,
                  child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1000),
                        child: Image(
                          image: AssetImage(
                            AppImageAsset.loginElipses,
                          ),
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ),
              Column(children: [
                const VSpace(64),
                // const VSpace(32),
                const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: SizedBox(
                      height: 128,
                      width: 256,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Image(
                          image: AssetImage(
                            AppImageAsset.logoExtense,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Gerenciamento como visão',
                    style: OversightTextStyles.kCaptionSubtitle,
                  ),
                ),
                const VSpace(40),
                FormBuilder(
                  key: _formKey,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        30.0,
                        10.0,
                        30.0,
                        10.0,
                      ),
                      child: OversightFormFieldInput(
                        name: 'email',
                        topLabel: 'Email',
                        placeholder: 'Digite o email',
                        keyboardType: TextInputType.emailAddress,
                        validator: FormBuilderValidators.email(
                          errorText: 'Informe um e-mail válido',
                        ),
                        style: const OversightInputStyle(
                          backgroundColor: OversightColors.white,
                          height: 40,
                          borderColor: OversightColors.transparent,
                        ),
                        onChanged: (value) {
                          _email = value;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      child: OversightFormFieldInput(
                        name: 'password',
                        topLabel: 'Password',
                        placeholder: 'Digite a senha',
                        obscure: true,
                        style: const OversightInputStyle(
                          backgroundColor: OversightColors.white,
                          height: 40,
                          borderColor: OversightColors.transparent,
                        ),
                        validator: FormBuilderValidators.required(
                          errorText: 'Insira uma senha',
                        ),
                        onChanged: (value) {
                          _password = value;
                        },
                      ),
                    ),
                    const VSpace(16),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: BlocBuilder<AuthCubit, AuthState>(
                              bloc: _cubit,
                              builder: (context, state) {
                                return OversightButton(
                                  title: 'Entrar',
                                  style: OversightButtonStyle.primary(
                                    backgroundColor:
                                        OversightColors.primaryCian,
                                    textStyle: OversightTextStyles.kBodyStrong
                                        .copyWith(
                                      fontSize: 16,
                                    ),
                                    width: 200,
                                  ),
                                  isLoading: false,
                                  responsiveText: true,
                                  iconPosition: IconPosition.left,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _cubit.signIn(_email, _password);
                                      //_cubit.onSuccessfullSignIn();
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const VSpace(20),
                  ]),
                ),
                const VSpace(20),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    height: 240,
                    width: 240,
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 100),
                          child: Image(
                            image: AssetImage(
                              AppImageAsset.logoRaven,
                            ),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
