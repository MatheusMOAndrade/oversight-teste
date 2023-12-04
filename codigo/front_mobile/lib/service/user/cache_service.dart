import 'package:shared_preferences/shared_preferences.dart';

abstract class ICacheService {
  Future<void> saveData({required String key, required String value});

  Future getData({required String key});

  Future<void> deleteData({required String key});
}

class CacheService implements ICacheService {
  //final storage = SharedPreferences.getInstance();

  @override
  Future<void> saveData({required String key, required String value}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(key, value);
  }

  @override
  Future getData({required String key}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString(key);
  }

  @override
  Future<void> deleteData({required String key}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(key, '');
  }
}
