import 'package:oversight/service/user/user_service.dart';
import 'package:oversight/use_cases/user_use_case.dart';

import '../../../service/customer/customer_service.dart';
import '../../../service/user/auth_service.dart';
import '../../service/address/address_service.dart';
import '../../service/budget_service/budget_service_service.dart';
import '../../service/budgets/budget_service.dart';
import '../../service/company/company_service.dart';
import '../../service/mailer/mailer_service.dart';
import '../../service/oversight_services/service_service.dart';
import '../../use_cases/address_use_case.dart';
import '../../use_cases/auth_use_case.dart';
import '../../use_cases/budget_service_use_case.dart';
import '../../use_cases/budget_use_case.dart';
import '../../use_cases/company_use_case.dart';
import '../../use_cases/customer_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../use_cases/mailer_use_case.dart';
import '../../use_cases/service_use_case.dart';

@module
abstract class UseCasesModule {
  @lazySingleton
  CustomerUseCase customerUseCase(
    CustomerService customerService,
    AddressService addressService,
  ) =>
      CustomerUseCase(
        customerService: customerService,
        addressService: addressService,
      );

  @lazySingleton
  BudgetUseCase budgetUseCase(
    BudgetService budgetService,
    BudgetServiceService budgetServiceService,
  ) =>
      BudgetUseCase(
        budgetService: budgetService,
        budgetServiceService: budgetServiceService,
      );

  @lazySingleton
  BudgetServiceUseCase budgetServiceUseCase(
    BudgetServiceService budgetServiceService,
  ) =>
      BudgetServiceUseCase(
        budgetServiceService: budgetServiceService,
      );

  @lazySingleton
  ServiceUseCase serviceUseCase(
    ServiceService serviceService,
  ) =>
      ServiceUseCase(
        serviceService: serviceService,
      );

  @lazySingleton
  UserUseCase userUseCase(UserService userService) =>
      UserUseCase(userService: userService);

  @lazySingleton
  AddressUseCase addressUseCase(
    AddressService addressService,
  ) =>
      AddressUseCase(addressService: addressService);

  @lazySingleton
  CompanyUseCase companyUseCase(
    CompanyService companyService,
  ) =>
      CompanyUseCase(
        companyService: companyService,
      );

  @lazySingleton
  MailerUseCase mailerUseCase(
    MailerService mailerService,
  ) =>
      MailerUseCase(
        mailerService: mailerService,
      );

  @lazySingleton
  AuthUseCase authUseCase(
    AuthService authService,
  ) =>
      AuthUseCase(authService: authService);
}
