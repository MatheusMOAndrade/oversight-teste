import 'package:flutter/material.dart';

import '../../../themes/oversight_colors.dart';
import '../../../themes/oversight_text_styles.dart';
import '../buttons/button/oversight_button_style.dart';

class OversightAlertStyle {
  final TextStyle titleTextStyle;
  final OversightButtonStyle closeButtonStyle;
  final OversightButtonStyle mainButtonStyle;
  final OversightButtonStyle secondaryButtonStyle;
  final IconData topButtonIcon;
  final Color backgroundColor;
  final double bottomSheetRadius;
  final double paddingCloseButton;
  final double paddingButtons;

  const OversightAlertStyle({
    this.closeButtonStyle = const OversightButtonStyle(
      borderColor: OversightColors.transparent,
      backgroundColor: OversightColors.cultured,
      borderRadius: 12,
      borderWidth: 0,
      disabledColor: OversightColors.silverSand,
      pressedColor: OversightColors.graniteGray,
      height: 36,
      secondaryColor: OversightColors.black,
      width: 36,
      maxHeight: 36,
      maxLines: 1,
      disabledBorderColor: OversightColors.transparent,
    ),
    this.titleTextStyle = OversightTextStyles.kH1,
    this.mainButtonStyle = const OversightButtonStyle(
      borderColor: OversightColors.transparent,
      backgroundColor: OversightColors.primaryCian,
      borderRadius: 12,
      borderWidth: 0,
      disabledColor: OversightColors.silverSand,
      pressedColor: OversightColors.graniteGray,
      height: 56,
      secondaryColor: OversightColors.black,
      maxHeight: 48.0,
      maxLines: 1,
      disabledBorderColor: OversightColors.transparent,
    ),
    this.secondaryButtonStyle = const OversightButtonStyle(
      borderColor: OversightColors.transparent,
      backgroundColor: OversightColors.cultured,
      borderRadius: 12,
      borderWidth: 0,
      disabledColor: OversightColors.silverSand,
      pressedColor: OversightColors.graniteGray,
      height: 56,
      secondaryColor: OversightColors.black,
      maxHeight: 48.0,
      maxLines: 1,
      disabledBorderColor: OversightColors.transparent,
    ),
    this.backgroundColor = OversightColors.white,
    this.topButtonIcon = Icons.close,
    this.bottomSheetRadius = 12,
    this.paddingButtons = 16,
    this.paddingCloseButton = 16,
  });

  OversightAlertStyle copyWith({
    TextStyle? titleTextStyle,
    OversightButtonStyle? closeButtonStyle,
    OversightButtonStyle? mainButtonStyle,
    OversightButtonStyle? secondaryButtonStyle,
    IconData? topButtonIcon,
    Color? backgroundColor,
    double? bottomSheetRadius,
  }) {
    return OversightAlertStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      closeButtonStyle: closeButtonStyle ?? this.closeButtonStyle,
      mainButtonStyle: mainButtonStyle ?? this.mainButtonStyle,
      secondaryButtonStyle: secondaryButtonStyle ?? this.secondaryButtonStyle,
      topButtonIcon: topButtonIcon ?? this.topButtonIcon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      bottomSheetRadius: bottomSheetRadius ?? this.bottomSheetRadius,
    );
  }
}
