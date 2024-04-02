import 'dart:async';

import '../../api/dio_client.dart';
import '../../api/endpoints.dart';
import '../../di/locator.dart';
import '../../../service/user/cache_service.dart';
import '../../../service/user/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/subjects.dart';

abstract class IAuthService {
  bool get isLoggedIn;

  UserModel? get currentUser;

  Future<void> signIn(String email, String password);

  Future<void> signOut();

  Future<void> signUp(String email, String password);

  Future<UserModel?> getUser({required String token});

  Future<void> updateUser(
      {required String token, required String field, required String newValue});
}

class AuthService implements IAuthService {
  final DioClient dioClient = locator.get<DioClient>();
  final CacheService cacheService = locator.get<CacheService>();

  final _userSubject = BehaviorSubject<UserModel?>();

  @override
  UserModel? get currentUser => _userSubject.valueOrNull;

  @override
  bool get isLoggedIn => currentUser != null;

  @override
  Future<void> signUp(String email, String password) async {
    await dioClient.post(Endpoints.login, data: {
      'username': email,
      'password': password,
    });
  }

  @override
  Future<Response?> signIn(String email, String password) async {
    try {
      Response response = await dioClient.post(
        Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        await cacheService.saveData(
            key: "token", value: response.data["sessionToken"]);
        await cacheService.saveData(
            key: "role", value: response.data["user"]["role"]);
      }

      return response;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Future<UserModel?> getUser({required String token}) async {
    final response = await dioClient.get(
      Endpoints.login,
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );
    print('The api response is $response');
    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> updateUser(
      {required String token,
      required String field,
      required String newValue}) async {
    final response = await dioClient.put(
      Endpoints.login,
      data: {field: newValue},
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );
    print('The api response is $response');
  }

  @override
  Future<void> signOut() async {
    await cacheService.deleteData(key: "token");
  }
}
