import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:oversight/presentation/widgets/spacer/spacer.dart';

import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';

import '../card/oversight_card.dart';
import '../card/oversight_card_style.dart';

class DetailsExpandedCard extends StatelessWidget {
  final String? title;
  final Widget details;

  final VoidCallback? onPressed;

  const DetailsExpandedCard({
    super.key,
    required this.title,
    required this.details,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OversightCard(
      style: const OversightCardStyle(
        borderColor: OversightColors.white,
        borderWidth: 8.0,
        borderRadius: 10.0,
      ),
      child: ExpansionTileCard(
        //leading: const CircleAvatar(child: Text('A')),

        title: Text(
          title ?? '',
          overflow: TextOverflow.ellipsis,
          style: OversightTextStyles.kBodyStrong.copyWith(
            fontSize: 18,
          ),
        ),

        baseColor: OversightColors.white,
        shadowColor: OversightColors.transparent,
        children: <Widget>[
          const Divider(
            thickness: 2.0,
            height: 2.0,
          ),
          const VSpace(18),
          details,
        ],
      ),
    );
  }
}
