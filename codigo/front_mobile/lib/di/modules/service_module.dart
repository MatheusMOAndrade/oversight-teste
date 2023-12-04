import 'package:oversight/service/user/user_service.dart';

import '../../../service/customer/customer_service.dart';
import '../../../service/route_service.dart';
import '../../../service/user/auth_service.dart';
import 'package:injectable/injectable.dart';

import '../../service/address/address_service.dart';
import '../../service/budget_service/budget_service_service.dart';
import '../../service/budgets/budget_service.dart';
import '../../service/company/company_service.dart';
import '../../service/mailer/mailer_service.dart';
import '../../service/oversight_services/service_service.dart';

@module
abstract class ServiceModule {
  @lazySingleton
  CustomerService customerService() => CustomerService();

  @lazySingleton
  BudgetService budgetService() => BudgetService();

  @lazySingleton
  BudgetServiceService budgetServiceService() => BudgetServiceService();

  @lazySingleton
  AddressService addressService() => AddressService();

  @lazySingleton
  ServiceService serviceService() => ServiceService();

  @lazySingleton
  UserService userService() => UserService();

  @lazySingleton
  CompanyService companyService() => CompanyService();

  @lazySingleton
  MailerService mailerService() => MailerService();

  @lazySingleton
  AuthService authService() => AuthService();

  @lazySingleton
  RouteService routeService(
    AuthService authService,
  ) =>
      RouteService(authService);
}
