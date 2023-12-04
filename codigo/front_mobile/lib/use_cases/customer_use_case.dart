import '../api/dio_exception.dart';

import '../../../service/customer/models/customer_model.dart';
import '../../../service/customer/customer_service.dart';
import 'package:flutter/material.dart';

import '../service/address/address_service.dart';
import '../service/address/models/address_model.dart';

class CustomerUseCase {
  final CustomerService customerService;
  final AddressService addressService;

  const CustomerUseCase({
    required this.customerService,
    required this.addressService,
  });

  Future<List<CustomerModel>> getList() async {
    try {
      return await customerService.getCustomerList();
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  List<CustomerModel> filterList(
      List<CustomerModel> customerList, String query) {
    List<CustomerModel> filter = <CustomerModel>[];

    filter.addAll(customerList);

    filter.retainWhere(
      (element) => element.name.toLowerCase().contains(
            query.toLowerCase(),
          ),
    );

    return filter;
  }

  Future<void> addCustomer(
    CustomerModel customer,
    AddressModel address, {
    VoidCallback? customerEmailExistCallback,
  }) async {
    try {
      if (await customerService.checkCustomerEmailExist(customer.email)) {
        if (customerEmailExistCallback != null) {
          customerEmailExistCallback();
        }

        return;
      }
      await customerService.addCustomer(customer);
      await addressService.addAddress(address);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> deleteCustomer(String customerId) async {
    try {
      await customerService.deleteCustomer(customerId);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> editCustomer(
    CustomerModel customer,
    AddressModel address,
    String customerId,
  ) async {
    try {
      await customerService.editCustomer(customer, customerId);

      await addressService.editAddress(address);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }
}
