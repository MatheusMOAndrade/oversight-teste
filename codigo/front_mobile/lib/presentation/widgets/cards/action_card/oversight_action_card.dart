import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

import '../card/oversight_card.dart';
import '../card/oversight_card_style.dart';

class OversightActionCard extends StatefulWidget {
  final String itemName;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const OversightActionCard({
    Key? key,
    required this.itemName,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  State<OversightActionCard> createState() => _OversightActionCardState();
}

class _OversightActionCardState extends State<OversightActionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: OversightCard(
        style: const OversightCardStyle(
          borderColor: OversightColors.secondaryGreen,
          borderWidth: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 96.0,
                ),
                child: Column(
                  children: [
                    Text(
                      widget.itemName,
                      overflow: TextOverflow.ellipsis,
                      style: OversightTextStyles.kBodyHighlighted,
                    ),
                    const Text(
                      '03/05/2023',
                      overflow: TextOverflow.ellipsis,
                      style: OversightTextStyles.kBodyHighlighted,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: widget.onEdit,
              icon: const Icon(
                color: OversightColors.darkCharcoal,
                Icons.edit,
              ),
            ),
            IconButton(
              onPressed: widget.onDelete,
              icon: const Icon(
                color: OversightColors.darkCharcoal,
                Icons.delete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
