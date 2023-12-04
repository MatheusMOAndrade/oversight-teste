part of 'home_cubit.dart';

class HomeState {
  final int notificationsCount;
  final int currentTab;
  final bool isMaster;

  String get currentTabName => PageNames.values[currentTab].name;

  const HomeState({
    this.notificationsCount = 0,
    this.currentTab = 0,
    this.isMaster = false,
  });

  HomeState copyWith({
    int? notificationsCount,
    int? currentTab,
    bool? isMaster,
  }) {
    return HomeState(
      notificationsCount: notificationsCount ?? this.notificationsCount,
      currentTab: currentTab ?? this.currentTab,
      isMaster: isMaster ?? this.isMaster,
    );
  }
}

class HomeInitialState extends HomeState {}
