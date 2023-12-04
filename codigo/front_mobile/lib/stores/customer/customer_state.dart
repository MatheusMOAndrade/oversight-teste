part of 'customer_cubit.dart';

abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final List<CustomerModel> customerList;
  final List<AddressModel>? addressList;
  CustomerLoaded({
    required this.customerList,
    this.addressList,
  });
}

class CustomerLoadingSkeleton extends CustomerState {
  final List<CustomerModel> customerList;
  CustomerLoadingSkeleton({
    required this.customerList,
  });
}

class CustomerListChanged extends CustomerState {
  final List<CustomerModel> customerList;
  final List<AddressModel>? addressList;

  CustomerListChanged({
    required this.customerList,
    this.addressList,
  });
}
