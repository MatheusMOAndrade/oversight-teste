import 'package:flutter/material.dart';

import '../../../themes/oversight_colors.dart';
import '../../../themes/oversight_text_styles.dart';

enum OversightCheckBoxSizes { small, medium, large }

class OversightCheckBoxStyle {
  final Color activeColor;
  final Color disabledColor;
  final Color borderColor;
  final Color iconColor;
  final Color disabledIconColor;
  final Color selectedContainerBackgroundColor;
  final Color unselectedContainerBackgroundColor;
  final Color selectedContainerBorderColor;
  final Color unselectedContainerBorderColor;
  final double? checkBoxSize;
  final double checkBoxRadius;
  final double checkBoxBorderWidth;
  final double containerRadius;
  final double padding;

  final OversightCheckBoxSizes? oversightCheckBoxSize;
  final bool disableTextVariation;
  final TextStyle textStyle;
  final TextStyle descriptionStyle;
  final double descriptionSpace;

  const OversightCheckBoxStyle({
    this.activeColor = OversightColors.black,
    this.disabledColor = OversightColors.silverSand,
    this.borderColor = OversightColors.graniteGray,
    this.iconColor = OversightColors.white,
    this.disabledIconColor = OversightColors.white,
    this.selectedContainerBackgroundColor = OversightColors.transparent,
    this.unselectedContainerBackgroundColor = OversightColors.transparent,
    this.selectedContainerBorderColor = OversightColors.transparent,
    this.unselectedContainerBorderColor = OversightColors.transparent,
    this.checkBoxSize,
    this.checkBoxRadius = 4.0,
    this.checkBoxBorderWidth = 1,
    this.containerRadius = 12.0,
    this.padding = 12.0,
    this.oversightCheckBoxSize = OversightCheckBoxSizes.small,
    this.disableTextVariation = false,
    this.textStyle = OversightTextStyles.kBodyHighlighted,
    this.descriptionStyle = OversightTextStyles.kBodyHighlighted,
    this.descriptionSpace = 8.0,
  });

  OversightCheckBoxStyle copyWith({
    Color? activeColor,
    Color? disabledColor,
    Color? borderColor,
    Color? iconColor,
    Color? disabledIconColor,
    Color? selectedContainerBackgroundColor,
    Color? unselectedContainerBackgroundColor,
    Color? selectedContainerBorderColor,
    Color? unselectedContainerBorderColor,
    double? checkBoxSize,
    double? checkBoxRadius,
    double? checkBoxBorderWidth,
    double? containerRadius,
    double? padding,
    OversightCheckBoxSizes? oversightCheckBoxSize,
    bool? disableTextVariation,
    TextStyle? textStyle,
    TextStyle? descriptionStyle,
    double? descriptionSpace,
  }) {
    return OversightCheckBoxStyle(
      activeColor: activeColor ?? this.activeColor,
      disabledColor: disabledColor ?? this.disabledColor,
      borderColor: borderColor ?? this.borderColor,
      iconColor: iconColor ?? this.iconColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      selectedContainerBackgroundColor: selectedContainerBackgroundColor ??
          this.selectedContainerBackgroundColor,
      unselectedContainerBackgroundColor: unselectedContainerBackgroundColor ??
          this.unselectedContainerBackgroundColor,
      selectedContainerBorderColor:
          selectedContainerBorderColor ?? this.selectedContainerBorderColor,
      unselectedContainerBorderColor:
          unselectedContainerBorderColor ?? this.unselectedContainerBorderColor,
      checkBoxSize: checkBoxSize ?? this.checkBoxSize,
      checkBoxRadius: checkBoxRadius ?? this.checkBoxRadius,
      checkBoxBorderWidth: checkBoxBorderWidth ?? this.checkBoxBorderWidth,
      containerRadius: containerRadius ?? this.containerRadius,
      padding: padding ?? this.padding,
      oversightCheckBoxSize:
          oversightCheckBoxSize ?? this.oversightCheckBoxSize,
      disableTextVariation: disableTextVariation ?? this.disableTextVariation,
      textStyle: textStyle ?? this.textStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      descriptionSpace: descriptionSpace ?? this.descriptionSpace,
    );
  }
}
