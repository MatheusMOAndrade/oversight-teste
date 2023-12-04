import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

enum IconPosition { left, right }

class OversightButtonStyle {
  final double width;
  final double height;
  final double maxHeight;
  final double borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final Color secondaryColor;
  final EdgeInsets? textPadding;
  final TextStyle textStyle;
  final double iconSize;
  final Color? disabledTextColor;
  final int maxLines;
  final Color pressedColor;
  final Color disabledColor;
  final Color disabledBorderColor;
  final Color? hoverColor;
  final Color? highlightColor;

  const OversightButtonStyle({
    this.width = 48.0,
    this.height = 48.0,
    this.maxHeight = 48.0,
    this.borderRadius = 12.0,
    this.backgroundColor = OversightColors.black,
    this.borderColor = OversightColors.transparent,
    this.borderWidth = 0,
    this.secondaryColor = OversightColors.white,
    this.textStyle = OversightTextStyles.kBodyStrong,
    this.iconSize = 16,
    this.disabledTextColor,
    this.maxLines = 1,
    this.pressedColor = OversightColors.transparent,
    this.disabledColor = OversightColors.silverSand,
    this.textPadding,
    this.disabledBorderColor = OversightColors.transparent,
    this.hoverColor,
    this.highlightColor,
  });

  const OversightButtonStyle.primary({
    this.borderColor = OversightColors.transparent,
    this.backgroundColor = OversightColors.black,
    this.borderRadius = 12,
    this.borderWidth = 0,
    this.disabledColor = OversightColors.silverSand,
    this.pressedColor = OversightColors.graniteGray,
    this.height = 56,
    this.secondaryColor = OversightColors.white,
    this.width = 48,
    this.maxHeight = 56.0,
    this.textStyle = OversightTextStyles.kBodyStrong,
    this.iconSize = 16,
    this.disabledTextColor,
    this.maxLines = 1,
    this.textPadding,
    this.disabledBorderColor = OversightColors.transparent,
    this.hoverColor = OversightColors.transparent,
    this.highlightColor = OversightColors.transparent,
  });

  const OversightButtonStyle.secondary({
    this.borderColor = OversightColors.transparent,
    this.backgroundColor = OversightColors.cultured,
    this.borderRadius = 12,
    this.borderWidth = 0,
    this.disabledColor = OversightColors.cultured,
    this.pressedColor = OversightColors.silverSand,
    this.height = 56,
    this.secondaryColor = OversightColors.black,
    this.width = 48,
    this.maxHeight = 56.0,
    this.textStyle = OversightTextStyles.kBodyStrong,
    this.iconSize = 16,
    this.disabledTextColor = OversightColors.graniteGray,
    this.maxLines = 1,
    this.textPadding,
    this.disabledBorderColor = OversightColors.transparent,
    this.hoverColor = OversightColors.transparent,
    this.highlightColor = OversightColors.transparent,
  });

  const OversightButtonStyle.outlined({
    this.borderColor = OversightColors.black,
    this.disabledBorderColor = OversightColors.silverSand,
    this.backgroundColor = OversightColors.transparent,
    this.borderRadius = 12,
    this.borderWidth = 2,
    this.disabledColor = OversightColors.white,
    this.pressedColor = OversightColors.cultured,
    this.height = 56,
    this.secondaryColor = OversightColors.black,
    this.width = 48,
    this.maxHeight = 56.0,
    this.textStyle = OversightTextStyles.kBodyStrong,
    this.iconSize = 16,
    this.disabledTextColor = OversightColors.silverSand,
    this.maxLines = 1,
    this.textPadding,
    this.hoverColor = OversightColors.transparent,
    this.highlightColor = OversightColors.transparent,
  });

  const OversightButtonStyle.textButton({
    this.borderColor = OversightColors.transparent,
    this.backgroundColor = OversightColors.transparent,
    this.borderRadius = 2,
    this.borderWidth = 0,
    this.disabledColor = OversightColors.transparent,
    this.pressedColor = OversightColors.cultured,
    this.height = 56,
    this.secondaryColor = OversightColors.secondaryBlue,
    this.width = 48,
    this.maxHeight = 56.0,
    this.textStyle = OversightTextStyles.kBodyStrong,
    this.iconSize = 16,
    this.disabledTextColor = OversightColors.silverSand,
    this.maxLines = 2,
    this.disabledBorderColor = OversightColors.transparent,
    this.textPadding,
    this.hoverColor = OversightColors.transparent,
    this.highlightColor = OversightColors.transparent,
  });

  const OversightButtonStyle.iconButton({
    this.borderColor = OversightColors.transparent,
    this.backgroundColor = OversightColors.black,
    this.borderRadius = 12,
    this.borderWidth = 0,
    this.disabledColor = OversightColors.silverSand,
    this.pressedColor = OversightColors.graniteGray,
    this.height = 36,
    this.secondaryColor = OversightColors.white,
    this.width = 36,
    this.maxHeight = 36,
    this.iconSize = 16,
    this.disabledTextColor,
    this.maxLines = 1,
    this.disabledBorderColor = OversightColors.transparent,
    this.hoverColor = OversightColors.transparent,
    this.highlightColor = OversightColors.transparent,
    this.textPadding,
    this.textStyle = OversightTextStyles.kBodyStrong,
  });
  const OversightButtonStyle.closeButton({
    this.borderColor = OversightColors.transparent,
    this.backgroundColor = OversightColors.cultured,
    this.borderRadius = 12,
    this.borderWidth = 0,
    this.disabledColor = OversightColors.silverSand,
    this.pressedColor = OversightColors.graniteGray,
    this.height = 36,
    this.secondaryColor = OversightColors.black,
    this.width = 36,
    this.maxHeight = 36,
    this.maxLines = 1,
    this.disabledBorderColor = OversightColors.transparent,
    this.textStyle = OversightTextStyles.kBodyStrong,
    this.iconSize = 16,
    this.disabledTextColor,
    this.textPadding,
    this.hoverColor = OversightColors.transparent,
    this.highlightColor = OversightColors.transparent,
  });

  OversightButtonStyle copyWith({
    double? width,
    double? height,
    double? maxHeight,
    IconData? icon,
    double? borderRadius,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    Color? secondaryColor,
    EdgeInsets? textPadding,
    TextStyle? textStyle,
    double? iconSize,
    Color? disabledTextColor,
    int? maxLines,
    Color? pressedColor,
    Color? disabledColor,
    Color? disabledBorderColor,
    Color? hoverColor,
    Color? highlightColor,
  }) {
    return OversightButtonStyle(
      width: width ?? this.width,
      height: height ?? this.height,
      maxHeight: maxHeight ?? this.maxHeight,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      textPadding: textPadding ?? this.textPadding,
      textStyle: textStyle ?? this.textStyle,
      iconSize: iconSize ?? this.iconSize,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      maxLines: maxLines ?? this.maxLines,
      pressedColor: pressedColor ?? this.pressedColor,
      disabledColor: disabledColor ?? this.disabledColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      hoverColor: hoverColor ?? this.hoverColor,
      highlightColor: highlightColor ?? this.highlightColor,
    );
  }
}
