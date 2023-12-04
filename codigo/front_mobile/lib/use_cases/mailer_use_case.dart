import '../api/dio_exception.dart';

import '../service/mailer/mailer_service.dart';
import '../service/mailer/models/mailer_model.dart';

class MailerUseCase {
  final MailerService mailerService;

  const MailerUseCase({
    required this.mailerService,
  });

  Future<String> getToken(String budgetId) async {
    try {
      return await mailerService.getToken(budgetId);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> postMail(MailerModel customer) async {
    try {
      await mailerService.postMail(customer);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }
}
