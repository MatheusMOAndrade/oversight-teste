import '../../../service/user/models/user_model.dart';
import '../../di/locator.dart';
import '../../service/user/cache_service.dart';
import '../../use_cases/user_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserUseCase userUseCase;

  UserCubit({required this.userUseCase}) : super(UserInitial());

  void init() async {
    emit(UserSkeletonLoading(mockedList));

    final userList = await userUseCase.getList();

    emit(UserLoaded(userList));
  }

  void filter(List<UserModel> userList, String query) {
    emit(UserLoading());

    final filteredList = userUseCase.filterList(userList, query);

    emit(UserLoaded(filteredList));
  }

  void addUser(UserModel user, {VoidCallback? userEmailExistCallback}) async {
    emit(UserLoading());

    await userUseCase.addUser(user, userEmailExistCallback);

    _updateList();
  }

  void deleteUser(String userId) async {
    emit(UserLoading());

    await userUseCase.deleteUser(userId);

    _updateList();
  }

  void editUser(
      UserModel user, String userId, VoidCallback userEmalExistCallback) async {
    emit(UserLoading());

    await userUseCase.editUser(user, userId);

    _updateList();
  }

  void _updateList() async {
    final userList = await userUseCase.getList();

    emit(UserListChanged(userList));
    emit(UserLoaded(userList));
  }

  Future<bool> isAdmin() async {
    return await locator.get<CacheService>().getData(key: "role") == "master";
  }

  List<UserModel> get mockedList {
    return [
      const UserModel(
        name: 'MockName1',
        email: 'email@email.com',
      ),
      const UserModel(
        name: 'MockName2',
        email: 'email@email.com',
      ),
      const UserModel(
        name: 'MockName3',
        email: 'email@email.com',
      ),
    ];
  }
}
