import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

class OversightBottomNavigationItemStyle {
  final double iconSize;
  final Color? iconColor;
  final Color? badgeColor;
  final double badgeBorderRadius;
  final double badgeSize;
  final double badgeWithTextSize;
  final TextStyle badgeTextStyle;

  const OversightBottomNavigationItemStyle({
    this.iconSize = 18,
    this.iconColor = OversightColors.black,
    this.badgeColor = OversightColors.primaryCian,
    this.badgeBorderRadius = 50,
    this.badgeSize = 8,
    this.badgeWithTextSize = 14,
    this.badgeTextStyle = OversightTextStyles.kCaptionMini,
  });

  OversightBottomNavigationItemStyle copyWith({
    double? iconSize,
    Color? iconColor,
    Color? badgeColor,
    double? badgeBorderRadius,
    double? badgeSize,
    double? badgeWithTextSize,
    TextStyle? badgeTextStyle,
  }) {
    return OversightBottomNavigationItemStyle(
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor,
      badgeColor: badgeColor ?? this.badgeColor,
      badgeBorderRadius: badgeBorderRadius ?? this.badgeBorderRadius,
      badgeSize: badgeSize ?? this.badgeSize,
      badgeWithTextSize: badgeWithTextSize ?? this.badgeWithTextSize,
      badgeTextStyle: badgeTextStyle ?? this.badgeTextStyle,
    );
  }
}
