import 'package:flutter/material.dart';

abstract class TabModel {
  final Widget tab;
  final String name;
  final IconData icon;
  final IconData? activeIcon;
  final bool hasPermission;

  TabModel({
    required this.tab,
    required this.name,
    required this.icon,
    required this.hasPermission,
    this.activeIcon,
  });
}
