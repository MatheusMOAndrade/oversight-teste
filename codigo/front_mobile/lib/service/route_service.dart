import '../api/endpoints.dart';
import '../../../navigation/navigation.dart';
import '../../../service/user/auth_service.dart';

class RouteService {
  final AuthService _authService;

  const RouteService(
    this._authService,
  );

  void pushAndClearRoute(String targetRoute) async {
    final routeName = await _getClearRoute(
      targetRoute,
    );
    navigator?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }

  Future<String> _getClearRoute(String targetRoute) async {
    if (targetRoute == Endpoints.login) {
      targetRoute = _processSignedState();
    }

    return targetRoute;
  }

  String _processSignedState() {
    if (!_authService.isLoggedIn) {
      return Endpoints.login;
    }
    return Endpoints.home;
  }
}
