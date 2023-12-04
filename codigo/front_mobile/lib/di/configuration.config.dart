// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i16;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/dio_client.dart' as _i17;
import '../service/address/address_service.dart' as _i3;
import '../service/budget_service/budget_service_service.dart' as _i8;
import '../service/budgets/budget_service.dart' as _i7;
import '../service/company/company_service.dart' as _i12;
import '../service/customer/customer_service.dart' as _i14;
import '../service/mailer/mailer_service.dart' as _i19;
import '../service/oversight_services/service_service.dart' as _i22;
import '../service/route_service.dart' as _i21;
import '../service/user/auth_service.dart' as _i5;
import '../service/user/cache_service.dart' as _i11;
import '../service/user/user_service.dart' as _i24;
import '../stores/address/address_cubit.dart' as _i26;
import '../stores/auth/auth_cubit.dart' as _i27;
import '../stores/budget/budget_cubit.dart' as _i28;
import '../stores/budget_service/budget_service_cubit.dart' as _i29;
import '../stores/customer/customer_cubit.dart' as _i30;
import '../stores/home/home_cubit.dart' as _i18;
import '../stores/service/service_cubit.dart' as _i31;
import '../stores/user/user_cubit.dart' as _i32;
import '../use_cases/address_use_case.dart' as _i4;
import '../use_cases/auth_use_case.dart' as _i6;
import '../use_cases/budget_service_use_case.dart' as _i9;
import '../use_cases/budget_use_case.dart' as _i10;
import '../use_cases/company_use_case.dart' as _i13;
import '../use_cases/customer_use_case.dart' as _i15;
import '../use_cases/mailer_use_case.dart' as _i20;
import '../use_cases/service_use_case.dart' as _i23;
import '../use_cases/user_use_case.dart' as _i25;
import 'modules/cache_module.dart' as _i35;
import 'modules/cubits_module.dart' as _i37;
import 'modules/dio_module.dart' as _i36;
import 'modules/service_module.dart' as _i33;
import 'modules/use_cases_module.dart' as _i34;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $configureDependencies(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final serviceModule = _$ServiceModule();
  final useCasesModule = _$UseCasesModule();
  final cacheModule = _$CacheModule();
  final dioModule = _$DioModule();
  final cubitsModule = _$CubitsModule();
  gh.lazySingleton<_i3.AddressService>(() => serviceModule.addressService());
  gh.lazySingleton<_i4.AddressUseCase>(
      () => useCasesModule.addressUseCase(gh<_i3.AddressService>()));
  gh.lazySingleton<_i5.AuthService>(() => serviceModule.authService());
  gh.lazySingleton<_i6.AuthUseCase>(
      () => useCasesModule.authUseCase(gh<_i5.AuthService>()));
  gh.lazySingleton<_i7.BudgetService>(() => serviceModule.budgetService());
  gh.lazySingleton<_i8.BudgetServiceService>(
      () => serviceModule.budgetServiceService());
  gh.lazySingleton<_i9.BudgetServiceUseCase>(() =>
      useCasesModule.budgetServiceUseCase(gh<_i8.BudgetServiceService>()));
  gh.lazySingleton<_i10.BudgetUseCase>(() => useCasesModule.budgetUseCase(
        gh<_i7.BudgetService>(),
        gh<_i8.BudgetServiceService>(),
      ));
  gh.lazySingleton<_i11.CacheService>(() => cacheModule.cacheService());
  gh.lazySingleton<_i12.CompanyService>(() => serviceModule.companyService());
  gh.lazySingleton<_i13.CompanyUseCase>(
      () => useCasesModule.companyUseCase(gh<_i12.CompanyService>()));
  gh.lazySingleton<_i14.CustomerService>(() => serviceModule.customerService());
  gh.lazySingleton<_i15.CustomerUseCase>(() => useCasesModule.customerUseCase(
        gh<_i14.CustomerService>(),
        gh<_i3.AddressService>(),
      ));
  gh.lazySingleton<_i16.Dio>(() => dioModule.dio());
  gh.lazySingleton<_i17.DioClient>(() => dioModule.dioClient(gh<_i16.Dio>()));
  gh.factory<_i18.HomeCubit>(() => cubitsModule.homeCubit());
  gh.lazySingleton<_i19.MailerService>(() => serviceModule.mailerService());
  gh.lazySingleton<_i20.MailerUseCase>(
      () => useCasesModule.mailerUseCase(gh<_i19.MailerService>()));
  gh.lazySingleton<_i21.RouteService>(
      () => serviceModule.routeService(gh<_i5.AuthService>()));
  gh.lazySingleton<_i22.ServiceService>(() => serviceModule.serviceService());
  gh.lazySingleton<_i23.ServiceUseCase>(
      () => useCasesModule.serviceUseCase(gh<_i22.ServiceService>()));
  gh.lazySingleton<_i24.UserService>(() => serviceModule.userService());
  gh.lazySingleton<_i25.UserUseCase>(
      () => useCasesModule.userUseCase(gh<_i24.UserService>()));
  gh.factory<_i26.AddressCubit>(
      () => cubitsModule.addressCubit(gh<_i4.AddressUseCase>()));
  gh.factory<_i27.AuthCubit>(
      () => cubitsModule.authCubit(gh<_i6.AuthUseCase>()));
  gh.factory<_i28.BudgetCubit>(
      () => cubitsModule.budgetCubit(gh<_i10.BudgetUseCase>()));
  gh.factory<_i29.BudgetServiceCubit>(() => cubitsModule.budgetServiceCubit(
        gh<_i9.BudgetServiceUseCase>(),
        gh<_i23.ServiceUseCase>(),
        gh<_i20.MailerUseCase>(),
        gh<_i15.CustomerUseCase>(),
        gh<_i13.CompanyUseCase>(),
      ));
  gh.factory<_i30.CustomerCubit>(
      () => cubitsModule.customerCubit(gh<_i15.CustomerUseCase>()));
  gh.factory<_i31.ServiceCubit>(
      () => cubitsModule.serviceCubit(gh<_i23.ServiceUseCase>()));
  gh.factory<_i32.UserCubit>(
      () => cubitsModule.userCubit(gh<_i25.UserUseCase>()));
  return getIt;
}

class _$ServiceModule extends _i33.ServiceModule {}

class _$UseCasesModule extends _i34.UseCasesModule {}

class _$CacheModule extends _i35.CacheModule {}

class _$DioModule extends _i36.DioModule {}

class _$CubitsModule extends _i37.CubitsModule {}
