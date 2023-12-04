import 'dart:ui';

import '../../../service/user/models/user_model.dart';
import '../../../service/user/user_service.dart';
import '../api/dio_exception.dart';

class UserUseCase {
  final UserService userService;

  const UserUseCase({
    required this.userService,
  });

  Future<List<UserModel>> getList() async {
    try {
      return await userService.getUserList();
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  List<UserModel> filterList(List<UserModel> userList, String query) {
    List<UserModel> filter = <UserModel>[];
    filter.addAll(userList);

    filter.retainWhere(
        (element) => element.name.toLowerCase().contains(query.toLowerCase()));

    return filter;
  }

  Future<void> addUser(
      UserModel user, VoidCallback? userEmailExistCallback) async {
    try {
      if (await userService.checkUserEmailExist(user.email)) {
        if (userEmailExistCallback != null) {
          userEmailExistCallback();
        }
        return;
      }
      await userService.addUser(user);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await userService.deleteUser(userId);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> editUser(UserModel user, String userId) async {
    try {
      await userService.editUser(user, userId);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }
}
