import 'package:flutter/material.dart';

import 'oversight_card_style.dart';

class OversightCard extends StatelessWidget {
  final Widget child;
  final OversightCardStyle style;

  const OversightCard({
    Key? key,
    this.style = const OversightCardStyle(),
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.margin,
      padding: style.padding,
      decoration: BoxDecoration(
        color: style.cardBackgroundColor,
        gradient: LinearGradient(
          stops: const [0.02, 0.02],
          colors: [
            style.borderColor,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(
          style.borderRadius,
        ),
        boxShadow: [
          style.boxShadow,
        ],
      ),
      child: child,
    );
  }
}
