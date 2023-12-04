import 'package:oversight/service/address/models/address_model.dart';

import '../api/dio_exception.dart';
import '../../../service/address/address_service.dart';

class AddressUseCase {
  final AddressService addressService;

  const AddressUseCase({
    required this.addressService,
  });

  Future<AddressModel> get() async {
    try {
      return await addressService.getAddress();
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<AddressModel> getAddressByCustomerId(String customerId) async {
    try {
      return await addressService.getAddressByCustomerId(customerId);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  List<AddressModel> filterList(List<AddressModel> addressList, String query) {
    List<AddressModel> filter = <AddressModel>[];

    filter.addAll(addressList);

    filter.retainWhere(
      (element) => element.customerId.toLowerCase().contains(
            query.toLowerCase(),
          ),
    );

    return filter;
  }

  Future<void> addAddress(AddressModel address) async {
    try {
      await addressService.addAddress(address);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }

  Future<void> editAddress(AddressModel address) async {
    try {
      await addressService.editAddress(address);
    } on DioExceptions catch (e) {
      throw e.message;
    }
  }
}
