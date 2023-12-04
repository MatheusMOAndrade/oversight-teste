import 'package:oversight/use_cases/address_use_case.dart';

import '../../../service/customer/models/customer_model.dart';
import '../../api/dio_exception.dart';
import '../../di/locator.dart';
import '../../service/address/models/address_model.dart';
import '../../service/user/cache_service.dart';
import '../../use_cases/customer_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final CacheService cacheService = locator.get<CacheService>();
  final CustomerUseCase customerUseCase;
  final AddressUseCase addressUseCase = locator.get<AddressUseCase>();

  CustomerCubit({
    required this.customerUseCase,
  }) : super(CustomerInitial());

  void init() async {
    emit(CustomerLoading());

    emit(CustomerLoadingSkeleton(customerList: mockedList));

    final customerList = await customerUseCase.getList();

    final addressList = await _getAddressList(customerList);

    emit(CustomerLoaded(
      customerList: customerList,
      addressList: addressList,
    ));
  }

  void filter(List<CustomerModel> customerList, String query) {
    emit(CustomerLoading());

    final filteredList = customerUseCase.filterList(customerList, query);

    emit(CustomerListChanged(customerList: customerList));

    emit(CustomerLoaded(customerList: filteredList));
  }

  Future<void> addCustomer(
    CustomerModel customer,
    AddressModel address, {
    VoidCallback? customerEmailExistCallback,
  }) async {
    emit(CustomerLoading());

    try {
      await customerUseCase.addCustomer(
        customer,
        address,
        customerEmailExistCallback: customerEmailExistCallback,
      );
    } on DioExceptions catch (e) {
      throw e.message;
    }

    final customerList = await customerUseCase.getList();

    emit(CustomerListChanged(customerList: customerList));
    emit(CustomerLoaded(customerList: customerList));
  }

  void deleteCustomer(String customerId) async {
    emit(CustomerLoading());

    await customerUseCase.deleteCustomer(customerId);

    final customerList = await customerUseCase.getList();

    emit(CustomerListChanged(customerList: customerList));
    emit(CustomerLoaded(customerList: customerList));
  }

  void editCustomer(
    CustomerModel customer,
    AddressModel address,
    String customerId,
    VoidCallback? customerEmailExistCallback,
  ) async {
    emit(CustomerLoading());

    await customerUseCase.editCustomer(
      customer,
      address,
      customerId,
    );

    final customerList = await customerUseCase.getList();

    emit(CustomerListChanged(customerList: customerList));
    emit(CustomerLoaded(customerList: customerList));
  }

  Future<List<AddressModel>> _getAddressList(
      List<CustomerModel> customers) async {
    final List<AddressModel> addressList = [];

    for (var customer in customers) {
      AddressModel currentAddress =
          await addressUseCase.getAddressByCustomerId(customer.id);

      print("Current address: $currentAddress");

      addressList.add(currentAddress);
    }

    return addressList;
  }

  List<CustomerModel> get mockedList {
    return [
      const CustomerModel(
        name: 'MockName1',
        email: 'MockEmail1',
        createdAt: 'MockCreatedAt1',
      ),
      const CustomerModel(
        name: 'MockName2',
        email: 'MockEmail2',
        createdAt: 'MockCreatedAt2',
      ),
      const CustomerModel(
        name: 'MockName3',
        email: 'MockEmail3',
        createdAt: 'MockCreatedAt3',
      ),
      const CustomerModel(
        name: 'MockName4',
        email: 'MockEmail4',
        createdAt: 'MockCreatedAt4',
      )
    ];
  }
}
