import 'package:flutter/material.dart';

import 'oversight_app_bar_style.dart';

class OversightAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? flexibleSpace;
  final List<Widget>? action;
  final PreferredSizeWidget? bottom;
  final OversightAppBarStyle style;

  @override
  final Size preferredSize;

  const OversightAppBar({
    Key? key,
    this.leading,
    this.title,
    this.flexibleSpace,
    this.action,
    this.bottom,
    this.style = const OversightAppBarStyle(),
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
      flexibleSpace: flexibleSpace,
      actions: action,
      backgroundColor: style.backgroundColor,
      foregroundColor: style.foregroundColor,
      shadowColor: style.shadowColor,
      surfaceTintColor: style.surfaceTintColor,
      elevation: style.elevation,
      scrolledUnderElevation: style.scrolledUnderElevation,
      titleSpacing: style.titleSpacing,
      toolbarOpacity: style.toolbarOpacity,
      bottomOpacity: style.bottomOpacity,
      leadingWidth: style.leadingWidth,
      automaticallyImplyLeading: style.automaticallyImplyLeading,
      primary: style.primary,
      centerTitle: style.centerTitle,
      excludeHeaderSemantics: style.excludeHeaderSemantics,
      toolbarTextStyle: style.toolbarTextStyle,
      titleTextStyle: style.titleTextStyle,
      shape: style.shape,
      iconTheme: style.iconTheme,
      actionsIconTheme: style.actionsIconTheme,
      systemOverlayStyle: style.systemOverlayStyle,
      bottom: bottom,
    );
  }
}
