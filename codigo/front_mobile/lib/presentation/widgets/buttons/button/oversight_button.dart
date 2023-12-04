import '../../../../themes/oversight_colors.dart';
import '../../responsive_text/perioclass_responsive_text.dart';
import 'package:flutter/material.dart';
import 'oversight_button_style.dart';

class OversightButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String? title;
  final IconData? icon;
  final bool responsiveText;
  final IconPosition iconPosition;
  final String? tooltip;
  final OversightButtonStyle style;

  const OversightButton({
    super.key,
    this.onPressed,
    this.style = const OversightButtonStyle(),
    this.isLoading = false,
    this.title,
    this.icon,
    this.responsiveText = true,
    this.iconPosition = IconPosition.left,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final _textStyle = style.textStyle;

    final _textPadding = style.textPadding ??
        EdgeInsets.symmetric(horizontal: title != null ? 20 : 0);
    return Tooltip(
      message: tooltip ?? '',
      child: Container(
        width: style.width,
        constraints: BoxConstraints(
            minWidth: 36,
            minHeight: style.height,
            maxHeight: style.height + 50),
        child: Material(
          key: const Key('oversight_button_material'),
          color: buttonBackgroundColor(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(style.borderRadius),
            side: BorderSide(
              color: buttonBorderColor(),
              width: style.borderWidth,
            ),
          ),
          child: InkWell(
            onTap: isLoading ? () {} : onPressed,
            splashColor: isLoading
                ? OversightColors.transparent
                : OversightColors.grey.withOpacity(0.05),
            hoverColor: style.hoverColor,
            highlightColor: style.highlightColor,
            child: Padding(
              padding: _textPadding,
              child: _TextIcon(
                icon: icon,
                responsiveText: responsiveText,
                iconPosition: iconPosition,
                title: title,
                secondaryColor: style.secondaryColor,
                isLoading: isLoading,
                width: style.width,
                textStyle: _textStyle.copyWith(
                  color: isLoading
                      ? OversightColors.transparent
                      : style.secondaryColor,
                ),
                iconSize: style.iconSize,
                maxLines: style.maxLines,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color buttonBackgroundColor() =>
      onPressed == null ? style.disabledColor : style.backgroundColor;

  Color buttonBorderColor() =>
      onPressed == null ? style.disabledBorderColor : style.borderColor;

  Color textColor() => onPressed == null && style.disabledTextColor != null
      ? style.disabledTextColor!
      : style.secondaryColor;
}

class _TextIcon extends StatelessWidget {
  const _TextIcon({
    Key? key,
    required this.iconPosition,
    this.icon,
    this.title,
    this.width,
    this.isLoading = false,
    required this.secondaryColor,
    required this.textStyle,
    required this.iconSize,
    required this.responsiveText,
    this.maxLines = 1,
  }) : super(key: key);

  final IconPosition iconPosition;
  final IconData? icon;
  final String? title;
  final double? width;
  final bool isLoading;
  final Color secondaryColor;
  final TextStyle textStyle;
  final double iconSize;
  final int maxLines;
  final bool responsiveText;

  final _minIconPadding = 4.0;
  final _maxIconPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null && iconPosition == IconPosition.left)
              Padding(
                padding: leftIconPadding(),
                child: Icon(
                  icon,
                  size: iconSize,
                  color:
                      isLoading ? OversightColors.transparent : secondaryColor,
                ),
              ),
            Flexible(
              fit: FlexFit.loose,
              child: PerioclassResponsiveText(
                isResponsive: responsiveText,
                text: Text(
                  title != null ? title! : "",
                  textAlign: TextAlign.left,
                  maxLines: maxLines,
                  style: textStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (icon != null && iconPosition == IconPosition.right)
              Padding(
                padding: rightIconPadding(),
                child: Icon(icon,
                    size: iconSize,
                    color: isLoading
                        ? OversightColors.transparent
                        : secondaryColor),
              ),
          ],
        ),
        if (isLoading)
          SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              color: secondaryColor,
              strokeWidth: 2.5,
            ),
          )
      ],
    );
  }

  EdgeInsets rightIconPadding() {
    return EdgeInsets.only(
        left: title != null
            ? _maxIconPadding
            : width != null
                ? 0
                : _minIconPadding,
        right: title != null
            ? 0
            : width != null
                ? 0
                : _minIconPadding);
  }

  EdgeInsets leftIconPadding() {
    return EdgeInsets.only(
      right: title != null
          ? _maxIconPadding
          : width != null
              ? 0
              : _minIconPadding,
      left: title != null
          ? 0
          : width != null
              ? 0
              : _minIconPadding,
    );
  }
}
