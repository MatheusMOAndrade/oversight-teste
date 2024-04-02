import '../../../service/oversight_services/models/oversight_service_model.dart';
import '../../di/locator.dart';
import '../../service/user/cache_service.dart';
import '../../use_cases/service_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  final CacheService cacheService = locator.get<CacheService>();
  final ServiceUseCase serviceUseCase;

  ServiceCubit({
    required this.serviceUseCase,
  }) : super(ServiceInitial());

  void init() async {
    emit(ServiceSkeletonLoading(serviceList: mockedList));

    final serviceList = await serviceUseCase.getList();

    emit(ServiceLoaded(serviceList: serviceList));
  }

  void filter(List<ServiceModel> serviceList, String query) {
    emit(ServiceLoading());

    final filteredList = serviceUseCase.filterList(serviceList, query);

    emit(ServiceListChanged(serviceList: serviceList));

    emit(ServiceLoaded(serviceList: filteredList));
  }

  Future<void> addService(
    ServiceModel service, {
    VoidCallback? serviceEmailExistCallback,
  }) async {
    emit(ServiceLoading());

    await serviceUseCase.addService(
      service,
      serviceEmailExistCallback: serviceEmailExistCallback,
    );

    final serviceList = await serviceUseCase.getList();

    emit(ServiceListChanged(serviceList: serviceList));
    emit(ServiceLoaded(serviceList: serviceList));
  }

  void deleteService(
    String serviceId, {
    VoidCallback? serviceIsUsedCallback,
  }) async {
    emit(ServiceLoading());

    await serviceUseCase.deleteService(
      serviceId,
      serviceIsUsedCallback: serviceIsUsedCallback,
    );

    final serviceList = await serviceUseCase.getList();

    emit(ServiceListChanged(serviceList: serviceList));
    emit(ServiceLoaded(serviceList: serviceList));
  }

  void editService(
    ServiceModel service,
    String serviceId,
    VoidCallback? serviceEmailExistCallback,
  ) async {
    emit(ServiceLoading());

    await serviceUseCase.editService(
      service,
      serviceId,
    );

    final serviceList = await serviceUseCase.getList();

    emit(ServiceListChanged(serviceList: serviceList));
    emit(ServiceLoaded(serviceList: serviceList));
  }

  List<ServiceModel> get mockedList {
    return [
      const ServiceModel(
        name: 'MockName1',
        description: 'description1',
        value: 0,
        errorMargin: 10,
        mesureUnit: 'm',
      ),
      const ServiceModel(
        name: 'MockName2',
        description: 'description2',
        value: 0,
        errorMargin: 10,
        mesureUnit: 'm',
      ),
      const ServiceModel(
        name: 'MockName3',
        description: 'description3',
        value: 0,
        errorMargin: 10,
        mesureUnit: 'm',
      ),
    ];
  }
}
