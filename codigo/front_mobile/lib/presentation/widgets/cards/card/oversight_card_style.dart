import '../../../../themes/oversight_colors.dart';
import 'package:flutter/material.dart';

class OversightCardStyle {
  final Color cardBackgroundColor;
  final Color borderColor;
  final BoxShadow boxShadow;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const OversightCardStyle({
    this.cardBackgroundColor = OversightColors.white,
    this.borderColor = OversightColors.white,
    this.boxShadow = const BoxShadow(
      blurRadius: 8.0,
      blurStyle: BlurStyle.outer,
      color: OversightColors.lightGrey,
    ),
    this.borderRadius = 4,
    this.borderWidth = 0,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
  });

  OversightCardStyle copyWith({
    Color? cardBackgroundColor,
    Color? borderColor,
    BoxShadow? boxShadow,
    double? borderRadius,
    double? borderWidth,
    EdgeInsets? padding,
    EdgeInsets? margin,
  }) {
    return OversightCardStyle(
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      boxShadow: boxShadow ?? this.boxShadow,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
    );
  }
}
