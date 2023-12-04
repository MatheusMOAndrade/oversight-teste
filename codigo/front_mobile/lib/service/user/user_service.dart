import 'dart:async';
import '../../api/dio_client.dart';
import '../../api/endpoints.dart';
import '../../di/locator.dart';
import '../../../service/user/cache_service.dart';

import '../../../service/user/models/user_model.dart';
import 'package:dio/dio.dart';

class UserService {
  final DioClient dioClient = locator.get<DioClient>();
  final CacheService cacheService = locator.get<CacheService>();

  Future<String> getTokenCache() async {
    return await cacheService.getData(key: "token");
  }

  Future<List<UserModel>> getUserList() async {
    final token = await cacheService.getData(key: "token");
    final query = await dioClient.get(
      Endpoints.users,
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    final jsonData = query.data as List;

    return jsonData.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<bool> checkUserEmailExist(String email) async {
    final token = await cacheService.getData(key: "token");
    final query = await dioClient.get(
      Endpoints.users,
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    return (query.data as List).where((element) => element == email).isNotEmpty;
  }

  Future<void> addUser(UserModel user) async {
    final token = await cacheService.getData(key: "token");
    await dioClient.post(
      Endpoints.users,
      data: user.toJson(),
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );
  }

  Future<void> deleteUser(String userId) async {
    final token = await cacheService.getData(key: "token");
    await dioClient.delete(
      Endpoints.userById + userId,
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );
  }

  Future<void> editUser(UserModel user, String userId) async {
    final token = await cacheService.getData(key: "token");
    await dioClient.put(
      Endpoints.userById + userId,
      data: user.toJson(),
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );
  }
}
