import '../../use_cases/auth_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase authUseCase;

  AuthCubit({
    required this.authUseCase,
  }) : super(AuthInitialState());

  Future<void> signIn(
    String email,
    String password,
  ) async {
    emit(AuthLoadingState());
    try {
      final responseStatus = await authUseCase.signIn(
        email,
        password,
      );

      if (responseStatus != null && responseStatus.statusCode == 200) {
        emit(AuthSuccessState(
          onLoginSuccessfull: authUseCase.onLoginSuccessfull,
        ));
      }

      if (responseStatus == null || responseStatus.statusCode != 200) {
        emit(AuthFailureState());
      }
    } catch (e) {
      emit(AuthFailureState());
    }
  }

  Future<void> signOut() async {
    await authUseCase.signOut();
  }
}
