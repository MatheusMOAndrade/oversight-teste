import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'oversight_input.dart';
import 'oversight_input_style.dart';

class OversightFormFieldInput extends StatefulWidget {
  final Key? formKey;
  final String name;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? topLabel;
  final String? sideLabel;
  final String? bottonLabel;
  final String? placeholder;
  final bool enabled;
  final bool locked;
  final bool? obscure;
  final bool multiLine;
  final VoidCallback? informationCallback;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final Function(String)? onChanged;
  final TextInputFormatter? textMask;
  final List<TextInputFormatter>? formatters;
  final int? maxChar;
  final int? minChar;
  final int? maxLines;
  final int? minLines;
  final int errorMaxLines;
  final OversightInputStyle style;
  final TextInputType? keyboardType;
  final bool autocorrect;

  const OversightFormFieldInput({
    Key? key,
    this.formKey,
    required this.name,
    this.controller,
    this.focusNode,
    this.topLabel,
    this.sideLabel,
    this.bottonLabel,
    this.placeholder,
    this.enabled = true,
    this.locked = false,
    this.obscure = false,
    this.multiLine = false,
    this.informationCallback,
    this.validator,
    this.initialValue,
    this.onChanged,
    this.minLines,
    this.maxLines = 3,
    this.errorMaxLines = 2,
    this.textMask,
    this.formatters,
    this.keyboardType,
    this.maxChar = 500,
    this.autocorrect = true,
    this.style = const OversightInputStyle(),
    this.minChar,
  }) : super(key: key);
  @override
  State<OversightFormFieldInput> createState() =>
      _OversightFormFieldInputState();
}

class _OversightFormFieldInputState extends State<OversightFormFieldInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        TextEditingController(
          text: widget.initialValue,
        );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      key: widget.formKey,
      name: widget.name,
      validator: widget.validator,
      initialValue: widget.initialValue,
      builder: (state) {
        return OversightInput(
          bottomLabel: widget.bottonLabel,
          enabled: widget.enabled,
          errorMessage: state.errorText,
          informationCallback: widget.informationCallback,
          locked: widget.locked,
          obscure: widget.obscure ?? false,
          multiLine: widget.multiLine,
          placeholder: widget.placeholder,
          sideLabel: widget.sideLabel,
          topLabel: widget.topLabel,
          controller: _controller,
          focusNode: widget.focusNode,
          style: OversightInputStyle(
            height: widget.style.height,
            backgroundColor: widget.style.backgroundColor,
            borderColor: widget.style.borderColor,
          ),
          onChanged: (value) {
            state.didChange(value);
            widget.onChanged?.call(value);
          },
        );
      },
    );
  }
}
