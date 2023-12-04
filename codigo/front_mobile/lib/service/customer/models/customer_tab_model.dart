import '../../../service/home/models/tab_model.dart';
import 'package:flutter/material.dart';

class CustomerTabModel implements TabModel {
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

  const CustomerTabModel({
    required this.tab,
    this.name = 'Clientes',
    this.icon = Icons.groups,
    this.activeIcon = Icons.groups,
    this.hasPermission = true,
  });

  CustomerTabModel copyWith({
    Widget? tab,
    String? name,
    IconData? icon,
    IconData? activeIcon,
  }) {
    return CustomerTabModel(
      tab: tab ?? this.tab,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      activeIcon: activeIcon ?? this.activeIcon,
    );
  }
}
