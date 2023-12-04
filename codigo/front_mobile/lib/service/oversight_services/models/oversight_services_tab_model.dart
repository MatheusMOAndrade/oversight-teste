import '../../../../service/home/models/tab_model.dart';
import 'package:flutter/material.dart';

class OversightServicesTabModel implements TabModel {
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

  const OversightServicesTabModel({
    required this.tab,
    this.name = 'Serviços',
    this.icon = Icons.handyman,
    this.activeIcon = Icons.handyman,
    this.hasPermission = true,
  });

  OversightServicesTabModel copyWith({
    Widget? tab,
    String? name,
    IconData? icon,
    IconData? activeIcon,
  }) {
    return OversightServicesTabModel(
      tab: tab ?? this.tab,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      activeIcon: activeIcon ?? this.activeIcon,
    );
  }
}
