import 'package:flutter/material.dart';

class OversightImage extends StatelessWidget {
  /// Aspect Ratio can be provided as '16 / 9' for example.
  final double aspectRatio;
  final ImageProvider image;
  final bool circle;
  final BoxFit fit;
  final double? borderRadius;
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;

  const OversightImage({
    Key? key,
    required this.aspectRatio,
    required this.image,
    this.circle = false,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.loadingBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: circle ? 1 : aspectRatio,
      child: _buildImage(),
    );
  }

  _buildImage() {
    if (circle) {
      return ClipOval(
        child: Image(
          image: image,
          fit: fit,
        ),
      );
    } else {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 0)),
        child: Image(
          image: image,
          fit: fit,
          loadingBuilder: loadingBuilder,
        ),
      );
    }
  }
}
