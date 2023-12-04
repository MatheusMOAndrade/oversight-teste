import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

import '../../widgets.dart';

class BubbleMenuItem {
  final String text;
  final VoidCallback action;

  const BubbleMenuItem({
    required this.text,
    required this.action,
  });
}

class OversightActionsCard extends StatefulWidget {
  final String status;
  final bool isBudget;
  final String itemName;
  final int? quantity;
  final int? price;
  final String? createdAt;
  final VoidCallback? onEdit;
  final List<BubbleMenuItem>? menuItemList;
  final VoidCallback? action;

  const OversightActionsCard({
    Key? key,
    this.status = '',
    required this.isBudget,
    required this.itemName,
    this.onEdit,
    this.quantity = 0,
    this.createdAt = '',
    this.price = 0,
    this.menuItemList,
    this.action,
  }) : super(key: key);

  @override
  State<OversightActionsCard> createState() => _OversightActionsCardState();
}

class _OversightActionsCardState extends State<OversightActionsCard> {
  final _menuKey = GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    final String budgetServiceQuantity = widget.quantity.toString();
    final String budgetPrice = widget.price.toString();

    return Padding(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        top: 12.0,
        bottom: 12.0,
      ),
      child: OversightCard(
        style: const OversightCardStyle().copyWith(
          borderColor: OversightColors.white,
          borderWidth: 8.0,
          borderRadius: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemName,
                    overflow: TextOverflow.ellipsis,
                    style: OversightTextStyles.kBodyHighlighted,
                  ),
                  if (widget.createdAt != '') ...[
                    const VSpace(10),
                    Text(
                      widget.createdAt ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: OversightTextStyles.kBodyHighlighted,
                    ),
                  ],
                  if (widget.price != 0.0) ...[
                    const VSpace(10),
                    Text(
                      'Preço unitário: $budgetPrice reais',
                      overflow: TextOverflow.ellipsis,
                      style: OversightTextStyles.kBodyHighlighted,
                    ),
                  ],
                  if (widget.quantity != 0) ...[
                    const VSpace(10),
                    Text(
                      'Quantidade: $budgetServiceQuantity',
                      overflow: TextOverflow.ellipsis,
                      style: OversightTextStyles.kBodyHighlighted,
                    ),
                  ],
                  if (widget.isBudget) ...[
                    Row(
                      children: [
                        _buildStatus(widget.status),
                        IconButton(
                          onPressed: widget.onEdit,
                          icon: const Icon(
                            color: OversightColors.primaryCian,
                            Icons.handyman,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Expanded(child: _menu())
          ],
        ),
      ),
    );
  }

  OversightTag _buildStatus(String status) {
    late String text;
    late Color color;

    switch (status) {
      case 'recusado':
        text = 'Recusado';
        color = OversightColors.darkRed;
        break;
      case 'aprovado':
        text = 'Aprovado';
        color = OversightColors.grassGreen;
        break;
      case 'budgeting':
        text = 'Adicione serviços';
        color = Color.fromARGB(255, 227, 198, 14);
        break;
      default:
        text = 'Indefinido';
        color = OversightColors.black;
        break;
    }
    return OversightTag(
      text: text,
      style: OversightTagStyle(
        color: color,
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  _menu() {
    if (widget.menuItemList != null && widget.menuItemList!.isNotEmpty) {
      return Listener(
        onPointerDown: (_) async {
          if (FocusScope.of(context).hasFocus) {
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 400));
          }
          _menuKey.currentState?.showButtonMenu();
        },
        child: PopupMenuButton(
          enabled: false,
          key: _menuKey,
          splashRadius: 0.1,
          tooltip: '',
          child: const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(
              Icons.more_vert,
              color: OversightColors.graniteGray,
            ),
          ),
          itemBuilder: (context) => widget.menuItemList!
              .map(
                (e) => PopupMenuItem<BubbleMenuItem>(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  value: e,
                  height: 0,
                  child: Text(
                    e.text,
                    style: OversightTextStyles.kBodyHighlighted
                        .copyWith(height: 0),
                  ),
                ),
              )
              .toList(),
          onSelected: (BubbleMenuItem value) => value.action(),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
