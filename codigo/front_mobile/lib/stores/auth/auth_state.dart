part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final VoidCallback onLoginSuccessfull;

  AuthSuccessState({
    required this.onLoginSuccessfull,
  });
}

class AuthFailureState extends AuthState {}
