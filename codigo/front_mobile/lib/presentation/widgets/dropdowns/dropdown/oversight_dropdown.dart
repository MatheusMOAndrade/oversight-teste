import 'package:flutter/material.dart';

import '../../buttons/icon_button/oversight_icon_button.dart';
import '../../buttons/icon_button/oversight_icon_button_style.dart';
import 'oversight_dropdown_style.dart';

class OversightDropdown extends StatefulWidget {
  final List<String> items;
  final void Function(String?)? onItemSelected;
  final bool enable;
  final OversightDropdownStyle style;
  final String? Function(String?)? validator;
  final VoidCallback? informationCallback;
  final String? topLabel;
  final String? placeholder;

  const OversightDropdown({
    super.key,
    this.placeholder,
    this.items = const [''],
    this.onItemSelected,
    this.enable = true,
    this.style = const OversightDropdownStyle(),
    this.validator,
    this.topLabel,
    this.informationCallback,
  });

  @override
  State<OversightDropdown> createState() => _OversightDropdownState();
}

class _OversightDropdownState extends State<OversightDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible:
              widget.informationCallback != null || widget.topLabel != null,
          child: Column(
            children: [
              _InputSearchHeader(
                labelTextStyle: widget.style.labelTextStyle,
                parentWidget: widget,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  // padding: EdgeInsets.zero,
                  child: DropdownButtonFormField<String>(
                    borderRadius: BorderRadius.circular(
                      widget.style.borderRadius,
                    ),
                    hint: Text(
                      widget.placeholder ?? '',
                      style: widget.style.textStyle,
                    ),
                    isDense: true,
                    isExpanded: true,
                    selectedItemBuilder: (_) => List.generate(
                      widget.items.length,
                      (i) => Text(
                        widget.items[i],
                        style: widget.style.textStyle,
                      ),
                    ),
                    validator: widget.validator,
                    icon: const Icon(Icons.arrow_drop_down),
                    decoration: InputDecoration(
                      focusedBorder: _focusedBorder(widget.style),
                      enabledBorder: _enabledBorder(widget.style),
                    ),
                    items: _itemsBuilder(widget.items, widget.style),
                    onChanged: widget.enable
                        ? (widget.onItemSelected ?? (v) {})
                        : null,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  _itemsBuilder(List<String> items, OversightDropdownStyle style) {
    return List.generate(
      items.length,
      (i) => DropdownMenuItem(
        alignment: AlignmentDirectional.centerStart,
        value: items[i],
        child: LayoutBuilder(builder: (_, __) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(items[i], style: style.textStyle),
                    Container(),
                  ],
                ),
              ),
              const Divider()
            ],
          );
        }),
      ),
    );
  }

  OutlineInputBorder _enabledBorder(OversightDropdownStyle style) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(style.borderRadius),
      borderSide: BorderSide(
        color: style.borderColor,
        width: style.borderWidth,
      ),
    );
  }

  OutlineInputBorder _focusedBorder(OversightDropdownStyle style) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(style.borderRadius),
      borderSide: BorderSide(
        color: style.focusedBorderColor,
        width: style.focusedBorderWidth,
      ),
    );
  }
}

class _InputSearchHeader extends StatelessWidget {
  final OversightDropdown parentWidget;
  final TextStyle labelTextStyle;

  const _InputSearchHeader({
    required this.parentWidget,
    required this.labelTextStyle,
    Key? key,
  }) : super(key: key);

  bool get _showTopInfoIcon => parentWidget.informationCallback != null;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (parentWidget.topLabel != null)
            Text(
              parentWidget.topLabel!,
              style: labelTextStyle,
            ),
          const Spacer(flex: 1),
          if (_showTopInfoIcon)
            OversightIconButton(
              onTap: parentWidget.informationCallback!,
              style: OversightIconButtonStyle(
                icon: Icons.info_outline,
                iconColor: labelTextStyle.color,
              ),
            ),
        ],
      ),
    );
  }
}
