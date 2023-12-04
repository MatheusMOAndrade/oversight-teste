import '../../../service/address/models/address_model.dart';
import '../../use_cases/address_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressUseCase addressUseCase;

  AddressCubit({
    required this.addressUseCase,
  }) : super(AddressInitial());

  void init() async {
    emit(AddressLoading());
  }

  Future<AddressModel> getAddress() async {
    emit(AddressLoading());
    AddressModel model;

    model = await addressUseCase.get();

    emit(AddressLoaded());
    return model;
  }

  void addAddress(AddressModel address) async {
    emit(AddressLoading());

    await addressUseCase.addAddress(address);
    emit(AddressLoaded());
  }

  void editAddress(AddressModel address, String addressId) async {
    emit(AddressLoading());

    await addressUseCase.editAddress(address);
    emit(AddressLoaded());
  }

  Future<AddressModel> getAddressByCustomerId(String customerId) async {
    emit(AddressLoading());

    emit(AddressLoaded());
    return await addressUseCase.getAddressByCustomerId(customerId);
  }
}
