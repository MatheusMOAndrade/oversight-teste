class Endpoints {
  Endpoints._();
  // TODO - Change to your IP for testing

  static const String baseUrl =
      "http://ec2-3-83-212-243.compute-1.amazonaws.com:3000/";
  static const Duration receiveTimeout = Duration(milliseconds: 30000);
  static const Duration connectionTimeout = Duration(milliseconds: 30000);
  static const String customers = 'customers';
  static const String companies = 'companies';
  static const String budgets = 'budgets';
  static const String services = 'services';
  static const String login = 'login';
  static const String home = 'home';
  static const String message = 'message';
  static const String users = 'users';
  static const String userById = 'users/';
  static const String mailer = 'mail';
  static const String mailerToken = 'mail/token';
}
