import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

class OversightInputStyle {
  final Color? borderColor;
  final Color? disabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? disabledColor;
  final Color textColor;
  final Color? disabledTextColor;
  final Color? errorTextColor;
  final Color? placeholderTextColor;
  final Color? backgroundColor;
  final TextStyle labelTextStyle;
  final TextStyle textStyle;
  final TextStyle errorTextStyle;
  final double borderWidth;
  final double focusedBorderWidth;
  final double borderRadius;
  final double height;

  const OversightInputStyle({
    this.borderColor = OversightColors.graniteGray,
    this.disabledBorderColor,
    this.focusedBorderColor = OversightColors.darkCharcoal,
    this.errorBorderColor = OversightColors.darkRed,
    this.disabledColor = OversightColors.cultured,
    this.textColor = OversightColors.black,
    this.disabledTextColor = OversightColors.graniteGray,
    this.errorTextColor = OversightColors.darkRed,
    this.placeholderTextColor = OversightColors.graniteGray,
    this.backgroundColor,
    this.labelTextStyle = OversightTextStyles.kCaptionSubtitle,
    this.textStyle = OversightTextStyles.kBodyHighlighted,
    this.errorTextStyle = OversightTextStyles.kBodyHighlighted,
    this.borderWidth = 1.0,
    this.focusedBorderWidth = 2.0,
    this.borderRadius = 12.0,
    this.height = 48.0,
  });

  OversightInputStyle copyWith({
    final Color? borderColor,
    final Color? disabledBorderColor,
    final Color? focusedBorderColor,
    final Color? errorBorderColor,
    final Color? disabledColor,
    final Color? textColor,
    final Color? disabledTextColor,
    final Color? errorTextColor,
    final Color? placeholderTextColor,
    final Color? backgroundColor,
    final TextStyle? labelTextStyle,
    final TextStyle? textStyle,
    final TextStyle? errorTextStyle,
    final double? borderWidth,
    final double? focusedBorderWidth,
    final double? borderRadius,
    final double? height,
  }) {
    return OversightInputStyle(
      borderColor: borderColor ?? this.borderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      disabledColor: disabledColor ?? this.disabledColor,
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      errorTextColor: errorTextColor ?? this.errorTextColor,
      placeholderTextColor: placeholderTextColor ?? this.placeholderTextColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      textStyle: textStyle ?? this.textStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      focusedBorderWidth: focusedBorderWidth ?? this.focusedBorderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      height: height ?? this.height,
    );
  }
}
