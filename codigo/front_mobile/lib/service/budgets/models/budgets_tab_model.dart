import '../../../service/home/models/tab_model.dart';
import 'package:flutter/material.dart';

class BudgetsTabModel implements TabModel {
  @override
  final Widget tab;
  @override
  final String name;
  @override
  final IconData icon;
  @override
  final IconData? activeIcon;
  @override
  final bool hasPermission;

  const BudgetsTabModel({
    required this.tab,
    this.name = 'Orçamentos',
    this.icon = Icons.post_add_outlined,
    this.activeIcon = Icons.post_add_outlined,
    this.hasPermission = true,
  });

  BudgetsTabModel copyWith({
    Widget? tab,
    String? name,
    IconData? icon,
    IconData? activeIcon,
  }) {
    return BudgetsTabModel(
      tab: tab ?? this.tab,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      activeIcon: activeIcon ?? this.activeIcon,
    );
  }
}
