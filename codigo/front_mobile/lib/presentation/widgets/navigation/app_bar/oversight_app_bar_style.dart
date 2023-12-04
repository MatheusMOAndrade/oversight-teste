import '../../../../themes/oversight_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OversightAppBarStyle {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final double? scrolledUnderElevation;
  final double? titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  final double? leadingWidth;
  final bool automaticallyImplyLeading;
  final bool primary;
  final bool? centerTitle;
  final bool excludeHeaderSemantics;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final ShapeBorder? shape;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final SystemUiOverlayStyle? systemOverlayStyle;

  const OversightAppBarStyle({
    this.backgroundColor = OversightColors.primaryBlue,
    this.foregroundColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation = 0,
    this.scrolledUnderElevation,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.leadingWidth,
    this.automaticallyImplyLeading = true,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.shape,
    this.iconTheme,
    this.actionsIconTheme,
    this.systemOverlayStyle,
  });

  OversightAppBarStyle copyWith({
    final Color? backgroundColor,
    final Color? foregroundColor,
    final Color? shadowColor,
    final Color? surfaceTintColor,
    final double? elevation,
    final double? scrolledUnderElevation,
    final double? titleSpacing,
    final double? toolbarOpacity,
    final double? bottomOpacity,
    final double? leadingWidth,
    final bool? automaticallyImplyLeading,
    final bool? primary,
    final bool? centerTitle,
    final bool? excludeHeaderSemantics,
    final TextStyle? toolbarTextStyle,
    final TextStyle? titleTextStyle,
    final ShapeBorder? shape,
    final IconThemeData? iconTheme,
    final IconThemeData? actionsIconTheme,
    final SystemUiOverlayStyle? systemOverlayStyle,
  }) {
    return OversightAppBarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      elevation: elevation ?? this.elevation,
      scrolledUnderElevation:
          scrolledUnderElevation ?? this.scrolledUnderElevation,
      titleSpacing: titleSpacing ?? this.titleSpacing,
      toolbarOpacity: toolbarOpacity ?? this.toolbarOpacity,
      bottomOpacity: bottomOpacity ?? this.bottomOpacity,
      leadingWidth: leadingWidth ?? this.leadingWidth,
      automaticallyImplyLeading:
          automaticallyImplyLeading ?? this.automaticallyImplyLeading,
      primary: primary ?? this.primary,
      centerTitle: centerTitle ?? this.centerTitle,
      excludeHeaderSemantics:
          excludeHeaderSemantics ?? this.excludeHeaderSemantics,
      toolbarTextStyle: toolbarTextStyle ?? this.toolbarTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      shape: shape ?? this.shape,
      iconTheme: iconTheme ?? this.iconTheme,
      actionsIconTheme: actionsIconTheme ?? this.actionsIconTheme,
      systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
    );
  }
}
