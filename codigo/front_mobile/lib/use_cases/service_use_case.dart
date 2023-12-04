import '../api/dio_exception.dart';

import '../../../service/oversight_services/models/oversight_service_model.dart';
import '../../../service/oversight_services/service_service.dart';
import 'package:flutter/material.dart';

class ServiceUseCase {
  final ServiceService serviceService;

  const ServiceUseCase({
    required this.serviceService,
  });

  Future<List<ServiceModel>> getList() async {
    try {
      return await serviceService.getServiceList();
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  List<ServiceModel> filterList(List<ServiceModel> serviceList, String query) {
    List<ServiceModel> filter = <ServiceModel>[];

    filter.addAll(serviceList);

    filter.retainWhere(
      (element) => element.name.toLowerCase().contains(
            query.toLowerCase(),
          ),
    );

    return filter;
  }

  Future<void> addService(
    ServiceModel service, {
    VoidCallback? serviceEmailExistCallback,
  }) async {
    try {
      if (await serviceService.checkServiceEmailExist(service.name)) {
        if (serviceEmailExistCallback != null) {
          serviceEmailExistCallback();
        }

        return;
      }
      await serviceService.addService(service);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> deleteService(String serviceId) async {
    try {
      await serviceService.deleteService(serviceId);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> editService(
    ServiceModel service,
    String serviceId,
  ) async {
    try {
      await serviceService.editService(service, serviceId);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }
}
