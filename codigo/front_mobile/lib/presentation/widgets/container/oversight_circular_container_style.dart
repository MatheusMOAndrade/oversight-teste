import '../../../../themes/oversight_colors.dart';
import 'package:flutter/material.dart';

class OversightCircularContainerStyle {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color borderColor;
  final Color backgroundColor;
  final double borderWidth;
  final double borderRadius;

  const OversightCircularContainerStyle({
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(12.0),
    this.borderColor = OversightColors.graniteGray,
    this.backgroundColor = OversightColors.transparent,
    this.borderWidth = 1.0,
    this.borderRadius = 12.0,
  });

  OversightCircularContainerStyle copyWith({
    final EdgeInsets? margin,
    final EdgeInsets? padding,
    final Color? borderColor,
    final Color? backgroundColor,
    final double? borderWidth,
    final double? borderRadius,
  }) {
    return OversightCircularContainerStyle(
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      borderColor: borderColor ?? this.borderColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
