import 'package:oversight/stores/user/user_cubit.dart';

import '../../../stores/auth/auth_cubit.dart';
import '../../../stores/customer/customer_cubit.dart';
import '../../../stores/home/home_cubit.dart';
import '../../stores/address/address_cubit.dart';
import '../../stores/budget/budget_cubit.dart';
import '../../stores/budget_service/budget_service_cubit.dart';
import '../../stores/service/service_cubit.dart';
import '../../use_cases/address_use_case.dart';
import '../../use_cases/budget_service_use_case.dart';
import '../../use_cases/budget_use_case.dart';
import '../../use_cases/company_use_case.dart';
import '../../use_cases/customer_use_case.dart';
import '../../use_cases/auth_use_case.dart';

import 'package:injectable/injectable.dart';

import '../../use_cases/mailer_use_case.dart';
import '../../use_cases/service_use_case.dart';
import '../../use_cases/user_use_case.dart';

@module
abstract class CubitsModule {
  CustomerCubit customerCubit(
    CustomerUseCase customerUseCase,
  ) =>
      CustomerCubit(customerUseCase: customerUseCase);

  BudgetCubit budgetCubit(
    BudgetUseCase budgetUseCase,
  ) =>
      BudgetCubit(budgetUseCase: budgetUseCase);

  UserCubit userCubit(
    UserUseCase userUseCase,
  ) =>
      UserCubit(userUseCase: userUseCase);

  AddressCubit addressCubit(
    AddressUseCase addressUseCase,
  ) =>
      AddressCubit(addressUseCase: addressUseCase);

  ServiceCubit serviceCubit(
    ServiceUseCase serviceUseCase,
  ) =>
      ServiceCubit(serviceUseCase: serviceUseCase);

  BudgetServiceCubit budgetServiceCubit(
    BudgetServiceUseCase budgetServiceUseCase,
    ServiceUseCase serviceUseCase,
    MailerUseCase mailerUseCase,
    CustomerUseCase customerUseCase,
    CompanyUseCase companyUseCase,
  ) =>
      BudgetServiceCubit(
        budgetServiceUseCase: budgetServiceUseCase,
        serviceUseCase: serviceUseCase,
        mailerUseCase: mailerUseCase,
        customerUseCase: customerUseCase,
        companyUseCase: companyUseCase,
      );

  AuthCubit authCubit(
    AuthUseCase authUseCase,
  ) =>
      AuthCubit(
        authUseCase: authUseCase,
      );

  HomeCubit homeCubit() => HomeCubit();
}
