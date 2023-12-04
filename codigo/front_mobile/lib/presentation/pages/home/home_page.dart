import '../../../presentation/widgets/widgets.dart';
import '../../../service/home/models/tab_model.dart';
import '../../../stores/home/home_cubit.dart';
import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  final List<TabModel> tabs;

  const HomePage({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit _cubit;

  @override
  void initState() {
    _cubit = GetIt.I<HomeCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      builder: (context, state) {
        _cubit.verifyRole();

        return Scaffold(
          body: _buildBody(state),
          bottomNavigationBar: _buildBottomNavBar(state),
        );
      },
    );
  }

  Widget _buildBody(HomeState state) {
    return Column(
      children: [
        Expanded(
          child: widget.tabs[state.currentTab].tab,
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(HomeState state) {
    return OversightBottomNavigationBar(
      style: OversightBottomNavigationBarStyle(
        backgroundColor: OversightColors.primaryCian,
        elevation: 6.0,
        selectedIconColor: OversightColors.white,
        unselectedIconColor: OversightColors.graniteGray,
        iconSize: 30.0,
        selectedLabelStyle: OversightTextStyles.kCaptionStrong.copyWith(
          fontSize: 14,
        ),
      ),
      currentIndex: state.currentTab,
      onTap: (index) {
        if (_cubit.canNavigate(index)) {
          _cubit.setActiveTab(index);
        }
      },
      items: state.isMaster ? _buildMasterUserTabs() : _buildGeneralUserTabs(),
    );
  }

  List<BottomNavigationBarItem> _buildMasterUserTabs() {
    return widget.tabs
        .map(
          (tab) => OversightBottomNavigationItem(
            icon: tab.icon,
            activeIcon: tab.activeIcon,
            label: tab.name,
          ),
        )
        .toList();
  }

  List<BottomNavigationBarItem> _buildGeneralUserTabs() {
    return widget.tabs
        .map(
          (tab) => OversightBottomNavigationItem(
            icon: tab.icon,
            activeIcon: tab.activeIcon,
            label: tab.name,
            enabled: tab.hasPermission,
          ),
        )
        .where((element) => element.enabled)
        .toList();
  }
}
