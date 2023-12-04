import '../api/dio_exception.dart';
import '../api/endpoints.dart';
import '../../di/locator.dart';
import '../../../service/route_service.dart';
import '../../../service/user/auth_service.dart';
import '../../../service/user/cache_service.dart';
import 'package:dio/dio.dart';

class AuthUseCase {
  final AuthService authService;

  const AuthUseCase({
    required this.authService,
  });

  Future<Response?> signIn(String login, String password) async {
    try {
      final responseData = await authService.signIn(login, password);

      return responseData;
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> onLoginSuccessfull() async {
    final routeService = locator<RouteService>();
    routeService.pushAndClearRoute(Endpoints.home);
  }

  Future<String?> _getUserToken() async {
    return await locator<CacheService>().getData(key: 'token');
  }

  Future<bool> validateUserToken() async {
    String? token = await _getUserToken();
    if (token == null || token.isEmpty) {
      return false;
    }
    return true;
  }
}
