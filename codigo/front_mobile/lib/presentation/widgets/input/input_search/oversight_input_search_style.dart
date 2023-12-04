import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

class OversightInputSearchStyle {
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final Color focusedBorderColor;
  final double focusedBorderWidth;
  final Color placeholderTextColor;
  final Color? backgroundColor;
  final Color? hoverColor;
  final TextStyle labelTextStyle;
  final TextStyle textStyle;
  final TextStyle suggestionsTitleTextStyle;
  final double prefixIconSize;
  final double suffixIconSize;
  final double height;

  const OversightInputSearchStyle({
    this.borderRadius = 12.0,
    this.borderColor = OversightColors.graniteGray,
    this.borderWidth = 1.0,
    this.focusedBorderColor = OversightColors.darkCharcoal,
    this.focusedBorderWidth = 2.0,
    this.placeholderTextColor = OversightColors.graniteGray,
    this.backgroundColor,
    this.hoverColor,
    this.labelTextStyle = OversightTextStyles.kEyebrowStrong,
    this.textStyle = OversightTextStyles.kBodyHighlighted,
    this.suggestionsTitleTextStyle = OversightTextStyles.kEyebrowStrong,
    this.prefixIconSize = 20.0,
    this.suffixIconSize = 20.0,
    this.height = 68.0,
  });

  OversightInputSearchStyle copyWith({
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
    Color? focusedBorderColor,
    double? focusedBorderWidth,
    Color? placeholderTextColor,
    Color? backgroundColor,
    Color? hoverColor,
    TextStyle? labelTextStyle,
    TextStyle? textStyle,
    TextStyle? suggestionsTitleTextStyle,
    double? prefixIconSize,
    double? suffixIconSize,
    double? height,
  }) {
    return OversightInputSearchStyle(
      borderRadius: borderRadius ?? this.borderRadius,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      placeholderTextColor: placeholderTextColor ?? this.placeholderTextColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hoverColor: hoverColor ?? this.hoverColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      textStyle: textStyle ?? this.textStyle,
      suggestionsTitleTextStyle:
          suggestionsTitleTextStyle ?? this.suggestionsTitleTextStyle,
      prefixIconSize: prefixIconSize ?? this.prefixIconSize,
      suffixIconSize: suffixIconSize ?? this.suffixIconSize,
      height: height ?? this.height,
    );
  }
}
