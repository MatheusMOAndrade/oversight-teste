import '../../api/dio_client.dart';
import '../../api/endpoints.dart';
import '../../di/locator.dart';
import '../../../service/user/cache_service.dart';
import 'package:dio/dio.dart';

import 'models/mailer_model.dart';

abstract class IMailerService {
  Future<void> postMail(MailerModel mail);
}

class MailerService implements IMailerService {
  final DioClient dioClient = locator.get<DioClient>();
  final CacheService cacheService = locator.get<CacheService>();

  @override
  Future<String> getToken(String budgetId) async {
    final token = await cacheService.getData(key: "token");
    print("sending budgetId: $budgetId");
    final response = await dioClient.get(
      Endpoints.mailerToken,
      options: Options(
        headers: {"session-token": token, "budget-id": budgetId},
      ),
    );

    return response.data['message-token'];
  }

  @override
  Future<void> postMail(MailerModel mail) async {
    final token = await cacheService.getData(key: "token");

    await dioClient.post(
      Endpoints.mailer,
      data: mail.toJson(),
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );
  }
}
