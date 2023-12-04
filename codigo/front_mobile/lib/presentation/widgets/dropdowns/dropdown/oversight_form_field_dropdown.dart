import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'oversight_dropdown.dart';
import 'oversight_dropdown_style.dart';

class OversightFormFieldDropdown extends StatefulWidget {
  final Key? formKey;
  final String name;
  final String? initialValue;
  final List<String> items;
  final void Function(String?)? onItemSelected;
  final bool enable;
  final OversightDropdownStyle style;
  final String? Function(String?)? validator;
  final VoidCallback? informationCallback;
  final String? topLabel;
  final String? placeholder;

  const OversightFormFieldDropdown({
    Key? key,
    this.formKey,
    required this.name,
    this.placeholder,
    this.initialValue,
    this.items = const [''],
    this.onItemSelected,
    this.enable = true,
    this.style = const OversightDropdownStyle(),
    this.validator,
    this.topLabel,
    this.informationCallback,
  }) : super(key: key);
  @override
  State<OversightFormFieldDropdown> createState() =>
      _OversightFormFieldDropdownState();
}

class _OversightFormFieldDropdownState
    extends State<OversightFormFieldDropdown> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      key: widget.formKey,
      name: widget.name,
      validator: widget.validator,
      initialValue: widget.initialValue,
      builder: (state) {
        return OversightDropdown(
          informationCallback: widget.informationCallback,
          placeholder: widget.placeholder,
          topLabel: widget.topLabel,
          enable: widget.enable,
          style: OversightDropdownStyle(
            backgroundColor: widget.style.backgroundColor,
            borderColor: widget.style.borderColor,
            borderRadius: widget.style.borderRadius,
            borderWidth: widget.style.borderWidth,
            focusedBorderColor: widget.style.focusedBorderColor,
            focusedBorderWidth: widget.style.focusedBorderWidth,
            labelTextStyle: widget.style.labelTextStyle,
            placeholderTextColor: widget.style.placeholderTextColor,
            textStyle: widget.style.textStyle,
          ),
          items: widget.items,
          onItemSelected: (value) {
            widget.onItemSelected?.call(value);
          },
        );
      },
    );
  }
}
