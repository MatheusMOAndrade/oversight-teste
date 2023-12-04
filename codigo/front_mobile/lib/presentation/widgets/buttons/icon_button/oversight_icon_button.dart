
import 'package:flutter/material.dart';
import 'oversight_icon_button_style.dart';


class OversightIconButton extends StatelessWidget {
  final VoidCallback onTap;

  final OversightIconButtonStyle style;

  const OversightIconButton({
    Key? key,
    required this.onTap,
    this.style = const OversightIconButtonStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: style.size,
        width: style.size,
        padding: EdgeInsets.all(style.iconPadding),
        decoration: BoxDecoration(
          shape:
              style.borderRadius == null ? style.boxShape : BoxShape.rectangle,
          color: style.backgroundColor,
          border: Border.all(
            color: style.borderColor,
            width: style.borderWidth,
          ),
          borderRadius: style.borderRadius == null
              ? null
              : BorderRadius.circular(style.borderRadius!),
        ),
        child: style.fitBox
            ? FittedBox(
                fit: BoxFit.fill,
                child: GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    style.icon,
                    color: style.iconColor,
                    size: style.iconSize,
                  ),
                ),
              )
            : GestureDetector(
                onTap: onTap,
                child: Icon(
                  style.icon,
                  color: style.iconColor,
                  size: style.iconSize,
                ),
              ),
      ),
    );
  }
}
