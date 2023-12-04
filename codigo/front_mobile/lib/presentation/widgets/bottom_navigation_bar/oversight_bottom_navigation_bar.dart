import '../../../presentation/widgets/bottom_navigation_bar/oversight_bottom_navigation_item.dart';
import '../../../../themes/oversight_colors.dart';
import 'package:flutter/material.dart';

import 'styles/oversight_bottom_navigation_bar_style.dart';

class OversightBottomNavigationBar extends StatelessWidget {
  final Function(int)? onTap;
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final OversightBottomNavigationBarStyle style;

  final BottomNavigationBarType bottomNavigationBarType;
  const OversightBottomNavigationBar({
    Key? key,
    this.onTap,
    required this.items,
    this.currentIndex = 0,
    this.style = const OversightBottomNavigationBarStyle(),
    this.bottomNavigationBarType = BottomNavigationBarType.fixed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: OversightColors.transparent,
        highlightColor: OversightColors.transparent,
        hoverColor: OversightColors.transparent,
      ),
      child: BottomNavigationBar(
        type: bottomNavigationBarType,
        backgroundColor: style.backgroundColor,
        iconSize: style.iconSize,
        selectedLabelStyle: style.selectedLabelStyle,
        unselectedLabelStyle: style.unselectedLabelStyle,
        showSelectedLabels: style.showSelectedLabels,
        showUnselectedLabels: style.showUnselectedLabels,
        selectedItemColor: style.selectedIconColor,
        unselectedItemColor: style.unselectedIconColor,
        currentIndex: currentIndex,
        onTap: (index) {
          var enabled = true;
          if (items[index] is OversightBottomNavigationBarBase) {
            final currentItem =
                items[index] as OversightBottomNavigationBarBase;
            enabled = currentItem.isEnabled;
          }

          if (onTap != null && enabled) {
            onTap!(index);
          }
        },
        elevation: style.elevation,
        items: items,
      ),
    );
  }
}
