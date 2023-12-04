import 'package:flutter/material.dart';

import '../../../themes/oversight_colors.dart';
import '../container/oversight_circular_container.dart';
import '../container/oversight_circular_container_style.dart';
import '../spacer/vspace.dart';
import 'oversight_checkbox_style.dart';

class OversightCheckBox extends StatefulWidget {
  final bool value;
  final bool enabled;
  final bool hoverEnabled;
  final String? label;
  final String? description;
  final Function(bool)? onChanged;
  final OversightCheckBoxStyle style;

  const OversightCheckBox({
    Key? key,
    this.value = false,
    this.enabled = true,
    this.hoverEnabled = false,
    this.label,
    this.description,
    this.onChanged,
    this.style = const OversightCheckBoxStyle(),
  }) : super(key: key);

  @override
  State<OversightCheckBox> createState() => _OversightCheckBoxState();
}

class _OversightCheckBoxState extends State<OversightCheckBox> {
  late bool _inFocus = false;
  late bool _checkValue;
  late bool enabled = widget.enabled;
  late double _borderWidth = 1;

  @override
  void initState() {
    _checkValue = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OversightCheckBox oldWidget) {
    if (oldWidget.value != widget.value) {
      _checkValue = widget.value;
      if (!widget.value) {
        _inFocus = false;
      }
    }
    if (oldWidget.enabled != widget.enabled) {
      enabled = widget.enabled;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: !enabled || !widget.hoverEnabled
          ? null
          : ((event) => setState(() {
                _borderWidth = 2;
                _inFocus = true;
              })),
      onExit: !enabled
          ? null
          : ((event) => setState(() {
                _borderWidth = 1;
                _inFocus = false;
              })),
      child: InkWell(
        onTap: !enabled ? null : () => toggle(),
        child: OversightCircularContainer(
          style: OversightCircularContainerStyle(
            padding: EdgeInsets.all(widget.style.padding),
            backgroundColor: containerBackgroundColor(widget.style),
            borderColor: containerBorderColor(widget.style),
            borderRadius: widget.style.containerRadius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: widget.hoverEnabled
                    ? EdgeInsets.all(6 - _borderWidth)
                    : EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: OversightColors.transparent,
                  borderRadius: BorderRadius.circular(
                    widget.style.checkBoxRadius,
                  ),
                  border: Border.all(
                    color: _inFocus && _checkValue && widget.hoverEnabled
                        ? borderColor(widget.style)
                        : OversightColors.transparent,
                    width: widget.style.checkBoxBorderWidth,
                  ),
                ),
                child: Container(
                  height: checkBoxSize(widget.style),
                  width: checkBoxSize(widget.style),
                  decoration: BoxDecoration(
                    color: checkBoxColor(widget.style),
                    borderRadius: BorderRadius.circular(
                      widget.style.checkBoxRadius,
                    ),
                    border: Border.all(
                      color: _inFocus
                          ? widget.style.activeColor
                          : borderColor(widget.style),
                      width: widget.style.checkBoxBorderWidth,
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    color: checkIconColor(widget.style),
                    size: checkBoxSize(widget.style) / 1.2,
                  ),
                ),
              ),
              if (widget.label != null) ...[
                const SizedBox(width: 10),
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        widget.label ?? "",
                        style: textStyle(widget.style),
                      ),
                      if (widget.description != null) ...[
                        VSpace(widget.style.descriptionSpace),
                        Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          widget.description ?? "",
                          style: descriptionTextStyle(widget.style),
                        ),
                      ],
                    ],
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  void toggle() {
    return setState(() {
      _checkValue = !_checkValue;
      _inFocus = _checkValue;
      if (widget.onChanged != null) {
        widget.onChanged!(_checkValue);
      }
    });
  }

  Color checkBoxColor(OversightCheckBoxStyle style) => !enabled && !_checkValue
      ? style.disabledColor
      : !enabled
          ? style.disabledColor
          : _checkValue
              ? style.activeColor
              : OversightColors.transparent;
  Color checkIconColor(OversightCheckBoxStyle style) => !enabled && !_checkValue
      ? OversightColors.transparent
      : !enabled
          ? style.disabledIconColor
          : _checkValue
              ? style.iconColor
              : OversightColors.transparent;
  Color borderColor(OversightCheckBoxStyle style) => !enabled
      ? style.disabledColor
      : _checkValue
          ? style.activeColor
          : style.borderColor;
  Color containerBackgroundColor(OversightCheckBoxStyle style) => _checkValue
      ? style.selectedContainerBackgroundColor
      : style.unselectedContainerBackgroundColor;
  Color containerBorderColor(OversightCheckBoxStyle style) => _checkValue
      ? style.selectedContainerBorderColor
      : style.unselectedContainerBorderColor;
  TextStyle textStyle(OversightCheckBoxStyle style) =>
      style.disableTextVariation
          ? style.textStyle
          : !enabled
              ? style.textStyle.copyWith(color: style.disabledColor)
              : _inFocus
                  ? style.textStyle.copyWith(color: style.activeColor)
                  : style.textStyle;
  TextStyle descriptionTextStyle(OversightCheckBoxStyle style) =>
      style.disableTextVariation
          ? style.descriptionStyle
          : !enabled
              ? style.descriptionStyle.copyWith(color: style.disabledColor)
              : _inFocus
                  ? style.descriptionStyle.copyWith(color: style.activeColor)
                  : style.descriptionStyle;

  double checkBoxSize(OversightCheckBoxStyle style) =>
      style.checkBoxSize ?? returnSizeCheckBox(style);

  double returnSizeCheckBox(OversightCheckBoxStyle style) {
    switch (style.oversightCheckBoxSize) {
      case OversightCheckBoxSizes.small:
        return 24;
      case OversightCheckBoxSizes.medium:
        return 32;
      case OversightCheckBoxSizes.large:
        return 40;
      default:
        return 24;
    }
  }
}
