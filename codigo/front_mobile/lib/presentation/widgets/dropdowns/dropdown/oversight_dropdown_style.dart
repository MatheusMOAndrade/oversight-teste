import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

class OversightDropdownStyle {
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final Color focusedBorderColor;
  final double focusedBorderWidth;
  final Color placeholderTextColor;
  final Color? backgroundColor;
  final TextStyle labelTextStyle;
  final TextStyle textStyle;

  const OversightDropdownStyle({
    this.borderColor = OversightColors.graniteGray,
    this.focusedBorderColor = OversightColors.darkCharcoal,
    this.placeholderTextColor = OversightColors.graniteGray,
    this.backgroundColor,
    this.labelTextStyle = OversightTextStyles.kEyebrowStrong,
    this.textStyle = OversightTextStyles.kBodyHighlighted,
    this.borderWidth = 1.0,
    this.focusedBorderWidth = 2.0,
    this.borderRadius = 12.0,
  });

  OversightDropdownStyle copyWith({
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
    Color? focusedBorderColor,
    double? focusedBorderWidth,
    Color? placeholderTextColor,
    Color? backgroundColor,
    TextStyle? labelTextStyle,
    TextStyle? textStyle,
  }) {
    return OversightDropdownStyle(
      borderRadius: borderRadius ?? this.borderRadius,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      focusedBorderWidth: focusedBorderWidth ?? this.focusedBorderWidth,
      placeholderTextColor: placeholderTextColor ?? this.placeholderTextColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
