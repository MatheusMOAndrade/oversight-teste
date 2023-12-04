import 'package:flutter/cupertino.dart';

class PerioclassResponsiveText extends StatelessWidget {
  final Text text;
  final bool isResponsive;

  const PerioclassResponsiveText({
    Key? key,
    required this.text,
    this.isResponsive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isResponsive) {
      return text;
    }

    return LayoutBuilder(builder: (context, constraints) {
      final overflowed = _isTextOverflowed(
        title: text.data ?? "",
        style: text.style,
        width: constraints.maxWidth,
      );
      if (overflowed) {
        return FittedBox(
          fit: BoxFit.contain,
          child: text,
        );
      }
      return text;
    });
  }

  bool _isTextOverflowed({
    String title = "",
    required TextStyle? style,
    required double width,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: style,
      ),
      maxLines: text.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: width,
        maxWidth: width,
      );

    return textPainter.didExceedMaxLines;
  }
}
