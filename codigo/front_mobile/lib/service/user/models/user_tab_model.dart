import '../../../service/home/models/tab_model.dart';
import 'package:flutter/material.dart';

class OversightUserTabModel implements TabModel {
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

  const OversightUserTabModel({
    required this.tab,
    this.name = 'Usuários',
    this.icon = Icons.people_alt,
    this.activeIcon = Icons.people_alt,
    this.hasPermission = false,
  });

  OversightUserTabModel copyWith({
    Widget? tab,
    String? name,
    IconData? icon,
    IconData? activeIcon,
  }) {
    return OversightUserTabModel(
      tab: tab ?? this.tab,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      activeIcon: activeIcon ?? this.activeIcon,
    );
  }
}
