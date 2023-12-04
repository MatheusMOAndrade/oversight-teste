import 'package:flutter/material.dart';
import 'package:oversight/service/address/models/address_model.dart';
import 'package:oversight/service/customer/customer_service.dart';

import '../../api/dio_client.dart';
import '../../api/dio_exception.dart';
import '../../api/endpoints.dart';
import '../../di/locator.dart';
import '../../../service/user/cache_service.dart';
import 'package:dio/dio.dart';

abstract class IAddressService {
  Future<AddressModel> getAddress();

  Future<AddressModel> getAddressByCustomerId(String customerId);

  Future<void> addAddress(AddressModel address);

  Future<void> editAddress(AddressModel address);
}

class AddressService implements IAddressService {
  final DioClient dioClient = locator.get<DioClient>();
  final CacheService cacheService = locator.get<CacheService>();
  final CustomerService customerService = locator.get<CustomerService>();

  @override
  Future<AddressModel> getAddress() async {
    final token = await cacheService.getData(key: "token");
    final customerId = await cacheService.getData(key: "customerId");

    final query = await dioClient.get(
      '${Endpoints.customers}/$customerId/address',
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    final jsonData = query.data;

    return AddressModel.fromJson(jsonData);
  }

  @override
  Future<void> addAddress(AddressModel address) async {
    final token = await cacheService.getData(key: "token");
    final customerId = await cacheService.getData(key: "customerId");
    final linkedAddress = address.copyWith(customerId: customerId);

    try {
      await dioClient
          .post(
        '${Endpoints.customers}/$customerId/address',
        data: linkedAddress.toJson(),
        options: Options(
          headers: {
            "session-token": token,
          },
        ),
      )
          .catchError((e) {
        customerService.callCustomerDamageControl(customerId);
        throw e;
      });
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  @override
  Future<void> editAddress(AddressModel address) async {
    final token = await cacheService.getData(key: "token");
    final customerId = await cacheService.getData(key: "customerId");

    await dioClient.put(
      '${Endpoints.customers}/$customerId/address',
      data: address.toJson(),
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );
  }

  @override
  Future<AddressModel> getAddressByCustomerId(String customerId) async {
    final token = await cacheService.getData(key: "token");

    final query = await dioClient.get(
      '${Endpoints.customers}/$customerId/address',
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    final jsonData = query.data["data"];

    print(jsonData);

    return AddressModel.fromJson(jsonData);
  }
}
