import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

class OversightTagStyle {
  final Color color;
  final double borderRadius;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final double iconPadding;
  final Color iconColor;
  final double iconSize;
  final double bubbleSize;
  final bool upperCase;

  const OversightTagStyle({
    this.color = OversightColors.black,
    this.borderRadius = 12.0,
    this.textStyle = OversightTextStyles.kTagLightStrong,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    this.iconPadding = 8,
    this.iconColor = OversightColors.white,
    this.iconSize = 24,
    this.bubbleSize = 12,
    this.upperCase = true,
  });

  OversightTagStyle copyWith({
    Color? color,
    double? borderRadius,
    TextStyle? textStyle,
    EdgeInsets? padding,
    double? iconPadding,
    Color? iconColor,
    double? iconSize,
    double? bubbleSize,
    bool? upperCase,
  }) {
    return OversightTagStyle(
      color: color ?? this.color,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      iconPadding: iconPadding ?? this.iconPadding,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      bubbleSize: bubbleSize ?? this.bubbleSize,
      upperCase: upperCase ?? this.upperCase,
    );
  }
}

const kTagMiniStyle = OversightTagStyle(
  color: OversightColors.white,
  borderRadius: 12.0,
  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  textStyle: OversightTextStyles.kTagMini,
);
