import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../themes/oversight_colors.dart';
import '../../buttons/icon_button/oversight_icon_button.dart';
import '../../buttons/icon_button/oversight_icon_button_style.dart';
import '../../spacer/vspace.dart';
import 'oversight_input_style.dart';

typedef StringValue = void Function(String);

class OversightInput extends StatefulWidget {
  /// The callback provided to onChanged should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt;
  final StringValue? onChanged;
  final StringValue? onSubmit;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final String? placeholder;
  final String? topLabel;
  final String? sideLabel;
  final String? bottomLabel;

  /// [errorMessage] have priority over the [bottomLabel].
  /// The border color will change to [OversightInputStyle.errorBorcerColor] if the [errorMessage] is not null.
  final String? errorMessage;
  final bool enabled;
  final bool obscure;
  final bool locked;
  final bool autocorrect;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  /// Will show a information button when not null.
  final VoidCallback? informationCallback;

  /// The text mask
  ///
  /// ## Example
  ///
  /// var maskFormatter = new MaskTextInputFormatter(
  ///   mask: '+# (###) ###-##-##',
  ///   filter: { "#": RegExp(r'[0-9]') },
  ///   type: MaskAutoCompletionType.lazy
  /// );
  final TextInputFormatter? textMask;
  final List<TextInputFormatter>? formatters;
  final bool multiLine;
  final int? maxChar;
  final int? minChar;
  final int? maxLines;
  final int? minLines;
  final int errorMaxLines;
  final OversightInputStyle style;

  const OversightInput({
    super.key,
    this.onChanged,
    this.onSubmit,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.placeholder,
    this.topLabel,
    this.sideLabel,
    this.bottomLabel,
    this.errorMessage,
    this.enabled = true,
    this.obscure = false,
    this.locked = false,
    this.multiLine = false,
    this.minLines,
    this.maxLines = 3,
    this.errorMaxLines = 2,
    this.informationCallback,
    this.textMask,
    this.formatters,
    this.keyboardType,
    this.validator,
    this.maxChar = 500,
    this.autocorrect = true,
    this.minChar,
    this.style = const OversightInputStyle(),
  });

  @override
  State<OversightInput> createState() => _OversightInputState();
}

class _OversightInputState extends State<OversightInput> {
  late bool _textVisible;

  @override
  void initState() {
    _textVisible = widget.obscure;

    super.initState();
  }

  bool get _enabled {
    if (widget.locked) return false;

    return widget.enabled;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible:
              widget.topLabel != null || widget.informationCallback != null,
          child: Column(
            children: [
              _OversightInputHeader(
                parentWidget: widget,
                labelTextStyle: widget.style.labelTextStyle,
                textColor: widget.style.textColor,
              ),
              const VSpace(8),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    widget.style.borderRadius,
                  ),
                ),
                child: TextFormField(
                  focusNode: widget.focusNode,
                  minLines: widget.minLines,
                  maxLines: widget.multiLine ? widget.maxLines : 1,
                  inputFormatters: widget.formatters,
                  autocorrect: widget.autocorrect,
                  onChanged: widget.onChanged,
                  onFieldSubmitted: widget.onSubmit,
                  validator: widget.validator,
                  controller: widget.controller,
                  initialValue: widget.initialValue,
                  enabled: _enabled,
                  keyboardType: widget.keyboardType,
                  obscureText: _textVisible,
                  cursorColor: widget.style.textColor,
                  decoration: InputDecoration(
                    suffixIcon: _SuffixInputWidget(
                      iconColor: OversightColors.grey,
                      parentWidget: widget,
                      visible: _textVisible,
                      onTap: () => setState(() => _textVisible = !_textVisible),
                    ),
                    prefixIconConstraints: const BoxConstraints(maxWidth: 40),
                    suffixIconConstraints: const BoxConstraints(maxWidth: 40),
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: widget.style.height / 2,
                      horizontal: 7,
                    ),
                    hintText: widget.placeholder,
                    hintStyle: widget.style.textStyle.copyWith(
                      color: widget.style.placeholderTextColor,
                    ),
                    errorStyle: widget.style.errorTextStyle.copyWith(
                      color: widget.style.errorTextColor,
                    ),
                    errorMaxLines: widget.errorMaxLines,
                    filled: true,
                    fillColor: _enabled
                        ? widget.style.backgroundColor
                        : widget.style.disabledColor,
                    disabledBorder: _disabledBorder(widget),
                    errorBorder: _errorBorder(widget),
                    focusedErrorBorder: _errorBorder(widget),
                    focusedBorder: _focusedBorder(widget),
                    enabledBorder: _enabledBorder(widget),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

OutlineInputBorder _errorBorder(widget) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      widget.style.borderRadius,
    ),
    borderSide: BorderSide(
      color: widget.style.errorBorderColor,
      width: widget.style.focusedBorderWidth,
    ),
  );
}

OutlineInputBorder _enabledBorder(widget) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      widget.style.borderRadius,
    ),
    borderSide: BorderSide(
      color: widget.errorMessage != null
          ? widget.style.errorBorderColor
          : widget.style.borderColor,
      width: widget.style.borderWidth,
    ),
  );
}

OutlineInputBorder _focusedBorder(widget) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      widget.style.borderRadius,
    ),
    borderSide: BorderSide(
      color: widget.errorMessage != null
          ? widget.style.errorBorderColor
          : widget.style.focusedBorderColor,
      width: widget.style.focusedBorderWidth,
    ),
  );
}

OutlineInputBorder _disabledBorder(widget) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      widget.style.borderRadius,
    ),
    borderSide: BorderSide(
      color: widget.style.disabledBorderColor ?? widget.style.disabledColor,
      width: widget.style.borderWidth,
    ),
  );
}

class _OversightInputHeader extends StatelessWidget {
  const _OversightInputHeader({
    Key? key,
    required this.parentWidget,
    required this.labelTextStyle,
    required this.textColor,
  }) : super(key: key);

  final OversightInput parentWidget;
  final TextStyle labelTextStyle;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (parentWidget.topLabel != null)
            Flexible(
              child: Text(
                parentWidget.topLabel!,
                style: labelTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

class _SuffixInputWidget extends StatelessWidget {
  const _SuffixInputWidget({
    Key? key,
    required this.parentWidget,
    required this.visible,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);
  final OversightInput parentWidget;
  final bool visible;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return parentWidget.obscure
        ? Padding(
            padding: const EdgeInsets.only(
              left: 6,
              right: 14,
            ),
            child: OversightIconButton(
                onTap: onTap,
                style: OversightIconButtonStyle(
                  size: 20,
                  iconColor: iconColor,
                  icon: visible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                )),
          )
        : const SizedBox(width: 14);
  }
}
