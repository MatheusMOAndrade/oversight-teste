import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:oversight/presentation/widgets/spacer/spacer.dart';

import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import '../../input/form_field_input/oversight_input.dart';
import '../../input/form_field_input/oversight_input_style.dart';
import '../card/oversight_card.dart';
import '../card/oversight_card_style.dart';

class OversightExpandedCard extends StatelessWidget {
  final String? title;
  final String? details;
  final VoidCallback? onPressed;
  final Function(String)? onInputChanged;

  const OversightExpandedCard({
    super.key,
    //required this.cardB,
    required this.title,
    required this.details,
    this.onPressed,
    this.onInputChanged,
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
        subtitle: Text(
          details ?? '',
          overflow: TextOverflow.ellipsis,
          style: OversightTextStyles.kBodyHighlighted,
        ),
        baseColor: OversightColors.white,
        shadowColor: OversightColors.transparent,
        children: <Widget>[
          const Divider(
            thickness: 2.0,
            height: 2.0,
          ),
          const VSpace(18),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24),
              child: OversightInput(
                topLabel: 'Quantidade',
                initialValue: '',
                placeholder: 'Digite a quantidade do serviço',
                validator: FormBuilderValidators.required(),
                keyboardType: TextInputType.number,
                style: const OversightInputStyle(
                  height: 40,
                  borderColor: OversightColors.black,
                ),
                onChanged: onInputChanged,
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  onPressed;
                },
                child: const Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Remover'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
