import '../../../../themes/oversight_colors.dart';
import 'package:flutter/material.dart';

import 'styles/oversight_bottom_navigation_item_style.dart';

class OversightBottomNavigationBarBase extends BottomNavigationBarItem {
  final bool locked;
  final bool enabled;

  OversightBottomNavigationBarBase({
    required Widget icon,
    String? label,
    Widget? activeIcon,
    Color? backgroundColor,
    String? tooltip,
    this.locked = false,
    this.enabled = true,
  }) : super(
          icon: icon,
          label: label,
          backgroundColor: backgroundColor,
          tooltip: tooltip,
          activeIcon: activeIcon,
        );

  bool get isEnabled => !locked && enabled;
}

class OversightBottomNavigationItem extends OversightBottomNavigationBarBase {
  OversightBottomNavigationItem({
    required IconData icon,
    IconData? activeIcon,
    String? label,
    Color? backgroundColor,
    String? tooltip,
    IconData? badgeIcon,
    int? notificationNumber,
    bool showBadge = false,
    bool locked = false,
    bool enabled = true,
  }) : super(
          icon: OversightBottomNavigationBarIcon(
            icon: Icon(
              icon,
              color: locked || !enabled ? OversightColors.platinum : null,
            ),
            badgeIcon: locked ? Icons.lock : badgeIcon,
            notificationNumber: notificationNumber,
            showBadge: showBadge || locked,
            enabled: !locked && enabled,
          ),
          label: label,
          backgroundColor: backgroundColor,
          tooltip: tooltip,
          activeIcon: OversightBottomNavigationBarIcon(
            icon: Icon(activeIcon ?? icon),
            badgeIcon: badgeIcon,
            notificationNumber: notificationNumber,
            showBadge: showBadge,
            enabled: !locked && enabled,
          ),
          enabled: enabled,
          locked: locked,
        );
}

class OversightBottomNavigationBarIcon extends StatelessWidget {
  final Widget icon;
  final IconData? badgeIcon;
  final int? notificationNumber;
  final bool showBadge;
  final bool enabled;
  final OversightBottomNavigationItemStyle style;

  const OversightBottomNavigationBarIcon({
    Key? key,
    required this.icon,
    this.badgeIcon,
    this.notificationNumber,
    this.showBadge = false,
    this.enabled = true,
    this.style = const OversightBottomNavigationItemStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        icon,
        if (showBadge)
          Positioned(
            right: 0,
            child: badgeIcon != null
                ? Icon(
                    badgeIcon,
                    size: style.iconSize,
                    color: style.iconColor,
                  )
                : Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: style.badgeColor,
                      borderRadius:
                          BorderRadius.circular(style.badgeBorderRadius),
                    ),
                    constraints: BoxConstraints(
                      minWidth: notificationNumber != null
                          ? style.badgeWithTextSize
                          : style.badgeSize,
                      minHeight: notificationNumber != null
                          ? style.badgeWithTextSize
                          : style.badgeSize,
                    ),
                    child: notificationNumber != null
                        ? Text(
                            notificationNumber! >= 999
                                ? '999'
                                : notificationNumber!.toString(),
                            style: style.badgeTextStyle,
                            textAlign: TextAlign.center,
                          )
                        : null,
                  ),
          ),
      ],
    );
  }
}
