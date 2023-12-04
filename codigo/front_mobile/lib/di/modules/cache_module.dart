import '../../../service/user/cache_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class CacheModule {
  @lazySingleton
  CacheService cacheService() => CacheService();
}
