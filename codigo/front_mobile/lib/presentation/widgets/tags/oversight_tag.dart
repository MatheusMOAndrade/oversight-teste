import '../../../presentation/widgets/tags/oversight_tag_style.dart';
import 'package:flutter/material.dart';

class OversightTag extends StatelessWidget {
  final String? text;
  final OversightTagStyle style;
  final VoidCallback? iconAction;
  final IconData? icon;
  final bool bubble;

  const OversightTag({
    Key? key,
    this.text,
    this.style = const OversightTagStyle(),
    this.iconAction,
    this.icon,
    this.bubble = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: style.color,
            borderRadius: BorderRadius.circular(style.borderRadius),
          ),
          child: Padding(
            padding: style.padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (text != null)
                  Flexible(
                    child: Text(
                      style.upperCase ? (text!).toUpperCase() : text!,
                      style: style.textStyle,
                    ),
                  ),
                if (icon != null)
                  Padding(
                    padding: EdgeInsets.only(left: style.iconPadding),
                    child: InkWell(
                      onTap: iconAction,
                      child: Icon(
                        icon,
                        color: style.iconColor,
                        size: style.iconSize,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (bubble)
          CustomPaint(
            painter: TrianglePainter(
              strokeColor: style.color,
              strokeWidth: 10,
              paintingStyle: PaintingStyle.fill,
            ),
            child: SizedBox(
              height: style.bubbleSize,
              width: style.bubbleSize,
            ),
          ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x, 0)
      ..lineTo(x / 2, y)
      ..lineTo(0, 0);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
