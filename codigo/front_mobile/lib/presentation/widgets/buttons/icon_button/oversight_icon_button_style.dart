import '../../../../themes/oversight_colors.dart';
import 'package:flutter/material.dart';

class OversightIconButtonStyle {
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData icon;
  final double? iconSize;
  final double iconPadding;
  final BoxShape boxShape;
  final double borderWidth;
  final Color borderColor;
  final double? borderRadius;
  final double? size;
  final bool fitBox;

  const OversightIconButtonStyle({
    this.backgroundColor,
    this.iconColor = OversightColors.black,
    this.icon = Icons.person_outline_outlined,
    this.iconSize,
    this.iconPadding = 0,
    this.borderRadius,
    this.boxShape = BoxShape.circle,
    this.borderWidth = 0,
    this.borderColor = OversightColors.transparent,
    this.fitBox = true,
    this.size = 20,
  });

  OversightIconButtonStyle copyWith({
    final Color? backgroundColor,
    final Color? iconColor,
    final IconData? icon,
    final double? iconSize,
    final double? iconPadding,
    final BoxShape? boxShape,
    final double? borderWidth,
    final Color? borderColor,
    final double? borderRadius,
    final bool? fitBox,
    final double? size,
  }) {
    return OversightIconButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
      icon: icon ?? this.icon,
      iconSize: iconSize ?? this.iconSize,
      iconPadding: iconPadding ?? this.iconPadding,
      boxShape: boxShape ?? this.boxShape,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      fitBox: fitBox ?? this.fitBox,
      size: size ?? this.size,
    );
  }
}
