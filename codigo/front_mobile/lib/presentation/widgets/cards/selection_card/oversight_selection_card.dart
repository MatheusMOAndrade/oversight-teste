import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

import '../../checkbox/oversight_checkbox.dart';
import '../card/oversight_card.dart';
import '../card/oversight_card_style.dart';

class OversightSelectionCard extends StatefulWidget {
  final String itemName;
  final String? details;
  final Function(bool)? onCheck;

  const OversightSelectionCard({
    Key? key,
    required this.itemName,
    required this.onCheck,
    this.details,
  }) : super(key: key);

  @override
  State<OversightSelectionCard> createState() => _OversightSelectionCardState();
}

class _OversightSelectionCardState extends State<OversightSelectionCard> {
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemName,
                    overflow: TextOverflow.ellipsis,
                    style: OversightTextStyles.kBodyHighlighted,
                  ),
                  Text(
                    widget.details ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: OversightTextStyles.kBodyHighlighted,
                  ),
                ],
              ),
            ),
            Expanded(
              child: OversightCheckBox(
                hoverEnabled: false,
                onChanged: widget.onCheck,
                value: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
