import '../../../../themes/oversight_text_styles.dart';
import 'oversight_bottom_navigation_item_style.dart';
import '../../../../themes/oversight_colors.dart';
import 'package:flutter/material.dart';

class OversightBottomNavigationBarStyle {
  final Color? backgroundColor;
  final double iconSize;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;

  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final double? elevation;
  final OversightBottomNavigationItemStyle itemStyle;
  final BottomNavigationBarType? bottomNavigationBarType;

  const OversightBottomNavigationBarStyle({
    this.backgroundColor = OversightColors.white,
    this.iconSize = 20.0,
    this.selectedIconColor = OversightColors.black,
    this.unselectedIconColor = OversightColors.darkCharcoal,
    this.selectedLabelStyle = OversightTextStyles.kCaption,
    this.unselectedLabelStyle = OversightTextStyles.kCaption,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
    this.elevation = 8.0,
    this.itemStyle = const OversightBottomNavigationItemStyle(),
    this.bottomNavigationBarType = BottomNavigationBarType.fixed,
  });

  OversightBottomNavigationBarStyle copyWith({
    Color? backgroundColor,
    double? iconSize,
    Color? selectedIconColor,
    Color? unselectedIconColor,
    TextStyle? selectedLabelStyle,
    TextStyle? unselectedLabelStyle,
    bool? showSelectedLabels,
    bool? showUnselectedLabels,
    double? elevation,
    OversightBottomNavigationItemStyle? itemStyle,
  }) {
    return OversightBottomNavigationBarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconSize: iconSize ?? this.iconSize,
      selectedIconColor: selectedIconColor ?? this.selectedIconColor,
      unselectedIconColor: unselectedIconColor ?? this.unselectedIconColor,
      selectedLabelStyle: selectedLabelStyle ?? this.selectedLabelStyle,
      unselectedLabelStyle: unselectedLabelStyle ?? this.unselectedLabelStyle,
      showSelectedLabels: showSelectedLabels ?? this.showSelectedLabels,
      showUnselectedLabels: showUnselectedLabels ?? this.showUnselectedLabels,
      elevation: elevation ?? this.elevation,
      itemStyle: itemStyle ?? this.itemStyle,
    );
  }
}
