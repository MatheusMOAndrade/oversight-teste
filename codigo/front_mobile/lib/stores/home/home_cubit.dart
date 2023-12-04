import '../../../presentation/widgets/navigation/page_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/locator.dart';
import '../../service/user/cache_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CacheService cacheService = locator.get<CacheService>();

  HomeCubit()
      : super(
          const HomeState(),
        );

  bool canNavigate(int newIndex) => newIndex != state.currentTab;

  void setActiveTab(int index) => emit(state.copyWith(currentTab: index));

  void verifyRole() async {
    String role = await cacheService.getData(key: "role");
    role == "admin" || role == "master"
        ? emit(state.copyWith(isMaster: true))
        : emit(state.copyWith(isMaster: false));
  }
}
