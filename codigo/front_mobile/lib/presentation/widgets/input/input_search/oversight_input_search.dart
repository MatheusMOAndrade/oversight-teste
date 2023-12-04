import 'dart:math';
import '../../../../themes/oversight_colors.dart';
import 'package:flutter/material.dart';

import '../../buttons/icon_button/oversight_icon_button.dart';
import '../../buttons/icon_button/oversight_icon_button_style.dart';
import '../../spacer/hspace.dart';
import 'oversight_input_search_style.dart';

enum InputSearchLeadingIconType {
  none,
  search;

  IconData? _iconData() {
    switch (this) {
      case InputSearchLeadingIconType.none:
        return null;
      case InputSearchLeadingIconType.search:
        return Icons.search;
    }
  }
}

class OversightInputSearch extends StatefulWidget {
  final Function(String)? onQueryChanged;
  final Function(String)? onSuggestionSelected;
  final List<String>? suggestions;
  final TextEditingController? controller;
  final String? initialValue;
  final String? placeholder;
  final String? topLabel;
  final String? suggestionsTitle;
  final int searchThreshold;
  final int maxSuggestionCount;
  final InputSearchLeadingIconType leadingIconType;
  final bool withCleaning;
  final IconData? suffixIcon;
  final VoidCallback? informationCallback;
  final GlobalKey? parentKey;
  final OversightInputSearchStyle style;

  const OversightInputSearch({
    Key? key,
    this.onQueryChanged,
    this.onSuggestionSelected,
    this.suggestions = const [],
    this.controller,
    this.initialValue,
    this.placeholder,
    this.topLabel,
    this.suggestionsTitle,
    this.searchThreshold = 3,
    this.maxSuggestionCount = 3,
    this.leadingIconType = InputSearchLeadingIconType.search,
    this.withCleaning = true,
    this.suffixIcon,
    this.informationCallback,
    this.parentKey,
    this.style = const OversightInputSearchStyle(),
  }) : super(key: key);

  @override
  _OversightInputSearchState createState() => _OversightInputSearchState();
}

class _OversightInputSearchState extends State<OversightInputSearch> {
  final FocusNode _focusNode = FocusNode();

  late final GlobalKey _key;
  late Offset _fieldPosition;
  late Size _fieldSize;

  OverlayEntry? _overlayEntry;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _hideSuggestions();
  }

  @override
  void initState() {
    super.initState();
    _key = GlobalKey();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _hideSuggestions();
    }
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    _focusNode.dispose();
    _hideSuggestions();
    super.dispose();
  }

  void _showSuggestions(BuildContext context) {
    RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return;
    }
    _fieldSize = renderBox.size;
    final ancestor = widget.parentKey?.currentContext?.findRenderObject();
    _fieldPosition = renderBox.localToGlobal(
      Offset.zero,
      ancestor: ancestor,
    );

    final suggestions = widget.suggestions;
    if (suggestions != null && suggestions.isNotEmpty) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _overlayEntry = _overlayEntryBuilder(suggestions);

      final overlayEntry = _overlayEntry;
      if (overlayEntry != null) {
        Overlay.of(context).insert(overlayEntry);
      }
    }
  }

  void _hideSuggestions() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _onQueryChanged(String query) {
    setState(() {
      widget.onQueryChanged?.call(query);
      if (query.length >= widget.searchThreshold) {
        _showSuggestions(context);
      } else {
        _hideSuggestions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: _key,
      children: [
        Visibility(
          visible:
              widget.topLabel != null || widget.informationCallback != null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _InputSearchHeader(
                parentWidget: widget,
                labelTextStyle: widget.style.labelTextStyle,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.style.backgroundColor,
                  borderRadius: BorderRadius.circular(
                    widget.style.borderRadius,
                  ),
                ),
                child: _textFormField(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _textFormField() {
    bool _prefix = widget.leadingIconType._iconData() != null;
    final minIconHeight =
        max(widget.style.prefixIconSize, widget.style.suffixIconSize);
    final verticalContentPadding = (widget.style.height - minIconHeight) / 2;

    return TextFormField(
      onChanged: _onQueryChanged,
      controller: widget.controller,
      initialValue: widget.initialValue,
      style: widget.style.textStyle.copyWith(color: _textColor(widget)),
      cursorColor: widget.style.textStyle.color,
      focusNode: _focusNode,
      decoration: InputDecoration(
        // constraints: BoxConstraints(maxHeight: 48),
        filled: true,
        prefixIcon: _PrefixInputWidget(
          textColor: _textColor(widget),
          size: widget.style.prefixIconSize,
          icon: widget.leadingIconType._iconData(),
          containsPrefix: _prefix,
        ),
        prefixIconConstraints: const BoxConstraints(maxWidth: 40),
        suffixIcon: Visibility(
          visible: widget.withCleaning
              ? widget.controller?.value.text.isNotEmpty ?? false
              : true,
          child: _SuffixInputWidget(
            iconColor: _textColor(widget),
            size: widget.style.suffixIconSize,
            icon: widget.suffixIcon,
            onTap: widget.withCleaning
                ? () {
                    widget.controller?.clear();
                    _onQueryChanged('');
                  }
                : null,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(maxWidth: 40),
        isCollapsed: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: verticalContentPadding,
        ),
        hintText: widget.placeholder,
        hintStyle: widget.style.textStyle.copyWith(
          color: widget.style.placeholderTextColor,
        ),
        fillColor: OversightColors.transparent,
        hoverColor: widget.style.hoverColor,
        focusedBorder: _focusedBorder(widget),
        enabledBorder: _enabledBorder(widget),
      ),
    );
  }

  OverlayEntry? _overlayEntryBuilder(List<String> suggestions) {
    const double topPadding = 16.0;
    const double suggestionHeight = 44.0;
    final String? suggestionsTitle = widget.suggestionsTitle;
    final List<String> allSuggestions;
    if (suggestionsTitle != null && suggestionsTitle.isNotEmpty) {
      allSuggestions = [suggestionsTitle, ...suggestions];
    } else {
      allSuggestions = suggestions;
    }

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top:
              _fieldPosition.dy + _fieldSize.height - widget.style.borderRadius,
          left: _fieldPosition.dx,
          width: _fieldSize.width,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipBehavior: Clip.antiAlias,
                  clipper: _SuggestionContainerClipper(
                    borderRadius: widget.style.borderRadius,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: OversightColors.white,
                      borderRadius:
                          BorderRadius.circular(widget.style.borderRadius),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: widget.maxSuggestionCount * suggestionHeight +
                          topPadding,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: allSuggestions.length,
                      itemBuilder: (_, index) {
                        if (suggestionsTitle != null && index == 0) {
                          return _SuggestionsTitle(
                            width: _fieldSize.width,
                            topPadding: topPadding,
                            suggestionTitle: suggestionsTitle,
                            suggestionsTitleTextStyle:
                                widget.style.suggestionsTitleTextStyle,
                          );
                        }

                        return GestureDetector(
                          onTap: () {
                            widget.onSuggestionSelected
                                ?.call(allSuggestions.elementAt(index));
                            _hideSuggestions();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 12.0,
                              top: index == 0 ? 10.0 + topPadding : 10.0,
                              right: 12.0,
                              bottom: index == allSuggestions.length - 1
                                  ? 18.0
                                  : 10.0,
                            ),
                            child: SizedBox(
                              width: _fieldSize.width,
                              child: Text(
                                allSuggestions.elementAt(index),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: widget.style.textStyle,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.5),
                  child: CustomPaint(
                    foregroundPainter: _SuggestionListBorderPainter(
                      borderColor: widget.style.focusedBorderColor,
                      borderWidth: 1.0,
                      borderRadius: widget.style.borderRadius,
                    ),
                    child: SizedBox(
                      width: _fieldSize.width - 1,
                      height: topPadding +
                          min(allSuggestions.length,
                                  widget.maxSuggestionCount) *
                              suggestionHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color? _textColor(OversightInputSearchStylewidget) =>
      widget.style.textStyle.color;

  OutlineInputBorder _enabledBorder(OversightInputSearchStylewidget) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.style.borderRadius,
      ),
      borderSide: BorderSide(
        color: widget.style.borderColor,
        width: widget.style.borderWidth,
      ),
    );
  }

  OutlineInputBorder _focusedBorder(OversightInputSearchStylewidget) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.style.borderRadius,
      ),
      borderSide: BorderSide(
        color: widget.style.focusedBorderColor,
        width: widget.style.focusedBorderWidth,
      ),
    );
  }
}

class _SuggestionsTitle extends StatelessWidget {
  final double width;
  final double topPadding;
  final String suggestionTitle;
  final TextStyle suggestionsTitleTextStyle;

  const _SuggestionsTitle({
    required this.width,
    required this.topPadding,
    required this.suggestionTitle,
    required this.suggestionsTitleTextStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.0,
        top: 10.0 + topPadding,
        right: 12.0,
        bottom: 10.0,
      ),
      child: SizedBox(
        width: width,
        child: Text(
          suggestionTitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: suggestionsTitleTextStyle,
        ),
      ),
    );
  }
}

class _SuffixInputWidget extends StatelessWidget {
  final Color? iconColor;
  final IconData? icon;
  final double size;
  final VoidCallback? onTap;

  const _SuffixInputWidget({
    Key? key,
    required this.iconColor,
    this.icon,
    required this.size,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 6,
        right: 14,
      ),
      child: OversightIconButton(
        onTap: onTap ?? () {},
        style: OversightIconButtonStyle(
          iconColor: iconColor ?? OversightColors.black,
          icon: icon ?? Icons.clear,
        ),
      ),
    );
  }
}

class _PrefixInputWidget extends StatelessWidget {
  final Color? textColor;
  final IconData? icon;
  final double size;
  final bool containsPrefix;

  const _PrefixInputWidget({
    Key? key,
    required this.textColor,
    this.icon,
    required this.size,
    required this.containsPrefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return containsPrefix
        ? Padding(
            padding: const EdgeInsets.only(
              left: 14,
              right: 6,
            ),
            child: Icon(
              icon,
              size: size,
              color: textColor,
            ),
          )
        : const HSpace(8);
  }
}

class _InputSearchHeader extends StatelessWidget {
  final OversightInputSearch parentWidget;
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
            ),
        ],
      ),
    );
  }
}

class _SuggestionListBorderPainter extends CustomPainter {
  final double borderWidth;
  final Color borderColor;
  final double borderRadius;

  const _SuggestionListBorderPainter({
    required this.borderWidth,
    required this.borderColor,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const Offset p1 = Offset.zero;
    final Offset p2 = Offset(0, size.height - borderRadius);
    final Offset p3 = Offset(borderRadius, size.height);
    final Offset p4 = Offset(size.width - borderRadius, size.height);
    final Offset p5 = Offset(size.width, size.height - borderRadius);
    final Offset p6 = Offset(size.width, 0);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..color = borderColor;

    canvas.drawLine(p1, p2, paint);
    canvas.drawArc(
      Offset(p2.dx, p2.dy - borderRadius) &
          Size(borderRadius * 2, borderRadius * 2),
      pi / 2,
      pi / 2,
      false,
      paint,
    );
    canvas.drawLine(p3, p4, paint);
    canvas.drawArc(
      Offset(p4.dx - borderRadius, p4.dy - 2 * borderRadius) &
          Size(borderRadius * 2, borderRadius * 2),
      0,
      pi / 2,
      false,
      paint,
    );
    canvas.drawLine(p5, p6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _SuggestionContainerClipper extends CustomClipper<Path> {
  final double borderRadius;

  const _SuggestionContainerClipper({required this.borderRadius});

  @override
  Path getClip(Size size) {
    const Offset p1 = Offset.zero;
    final Offset p2 = Offset(0, size.height - borderRadius);
    final Offset p3 = Offset(borderRadius, size.height);
    final Offset p4 = Offset(size.width - borderRadius, size.height);
    final Offset p5 = Offset(size.width, size.height - borderRadius);
    final Offset p6 = Offset(size.width, 0);
    final Offset p7 = Offset(size.width - borderRadius, borderRadius);
    final Offset p8 = Offset(borderRadius, borderRadius);

    return Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..arcToPoint(
        p3,
        clockwise: false,
        radius: Radius.circular(borderRadius),
      )
      ..lineTo(p4.dx, p4.dy)
      ..arcToPoint(
        p5,
        clockwise: false,
        radius: Radius.circular(borderRadius),
      )
      ..lineTo(p6.dx, p6.dy)
      ..arcToPoint(
        p7,
        clockwise: true,
        radius: Radius.circular(borderRadius),
      )
      ..lineTo(p8.dx, p8.dy)
      ..arcToPoint(
        p1,
        clockwise: true,
        radius: Radius.circular(borderRadius),
      )
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
