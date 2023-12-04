import 'package:flutter/material.dart';

class HSpace extends StatelessWidget {
  final double size;

  // ignore: use_key_in_widget_constructors
  const HSpace(this.size);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
    );
  }
}
