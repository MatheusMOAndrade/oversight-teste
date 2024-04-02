part of 'service_cubit.dart';

abstract class ServiceState {}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final List<ServiceModel> serviceList;
  ServiceLoaded({
    required this.serviceList,
  });
}

class ServiceSkeletonLoading extends ServiceState {
  final List<ServiceModel> serviceList;
  ServiceSkeletonLoading({
    required this.serviceList,
  });
}

class ServiceListChanged extends ServiceState {
  final List<ServiceModel> serviceList;

  ServiceListChanged({
    required this.serviceList,
  });
}

class DeleteServiceFailureState extends ServiceState {}
