import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  final double size;

  // ignore: use_key_in_widget_constructors
  const VSpace(this.size);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}
