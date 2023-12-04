part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> userList;

  UserLoaded(this.userList);
}

class UserSkeletonLoading extends UserState {
  final List<UserModel> userList;

  UserSkeletonLoading(this.userList);
}

class UserListChanged extends UserState {
  final List<UserModel> userList;

  UserListChanged(this.userList);
}
