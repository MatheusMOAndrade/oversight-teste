import '../../../presentation/widgets/container/oversight_circular_container_style.dart';
import 'package:flutter/material.dart';

class OversightCircularContainer extends StatelessWidget {
  final Widget child;
  final OversightCircularContainerStyle style;

  const OversightCircularContainer({
    Key? key,
    required this.child,
    this.style = const OversightCircularContainerStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: style.backgroundColor,
          border: Border.all(
            color: style.borderColor,
            width: style.borderWidth,
          ),
          borderRadius: BorderRadius.circular(style.borderRadius)),
      padding: style.padding,
      margin: style.margin,
      child: child,
    );
  }
}
