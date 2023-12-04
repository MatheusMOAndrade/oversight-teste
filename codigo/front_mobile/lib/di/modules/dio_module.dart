import '../../api/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio() => Dio();

  @lazySingleton
  DioClient dioClient(Dio dio) => DioClient(dio);
}
