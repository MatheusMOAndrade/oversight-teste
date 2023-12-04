import 'package:flutter/material.dart';

import '../buttons/button/oversight_button.dart';
import '../spacer/hspace.dart';
import '../spacer/vspace.dart';
import 'oversight_alert_style.dart';

class OversightAlert {
  void showOversightAlert(
    BuildContext context, {
    bool barrierDismissible = true,
    String? title,
    Widget? body,
    String? mainButtonTitle,
    IconData? mainButtonIcon,
    String? secondaryButtonTitle,
    IconData? secondaryButtonIcon,
    VoidCallback? mainButtonAction,
    VoidCallback? secondaryButtonAction,
    VoidCallback? topButtonAction,
    VoidCallback? onDismissAlert,
    OversightAlertStyle style = const OversightAlertStyle(),
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            onDismissAlert?.call();
            return true;
          },
          child: Dialog(
            insetPadding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                style?.bottomSheetRadius ?? 12,
              ),
            ),
            backgroundColor: style?.backgroundColor,
            child: _OversightAlertBody(
              key: const Key('oversight_alert'),
              title: title,
              body: body,
              mainButtonTitle: mainButtonTitle,
              mainButtonAction: mainButtonAction,
              topButtonAction: topButtonAction,
              style: style,
              secondaryButtonAction: secondaryButtonAction,
              secondaryButtonTitle: secondaryButtonTitle,
              mainButtonIcon: mainButtonIcon,
              secondaryButtonIcon: secondaryButtonIcon,
            ),
          ),
        );
      },
    );
  }
}

class _OversightAlertBody extends StatelessWidget {
  final String? title;
  final Widget? body;
  final String? mainButtonTitle;
  final IconData? mainButtonIcon;
  final String? secondaryButtonTitle;
  final IconData? secondaryButtonIcon;
  final VoidCallback? mainButtonAction;
  final VoidCallback? secondaryButtonAction;
  final VoidCallback? topButtonAction;
  final OversightAlertStyle style;

  const _OversightAlertBody({
    Key? key,
    this.title,
    this.body,
    this.mainButtonTitle,
    this.mainButtonIcon,
    this.secondaryButtonTitle,
    this.secondaryButtonIcon,
    this.mainButtonAction,
    this.secondaryButtonAction,
    this.topButtonAction,
    this.style = const OversightAlertStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 22.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (topButtonAction != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OversightButton(
                  icon: style.topButtonIcon,
                  onPressed: topButtonAction,
                  style: style.closeButtonStyle,
                ),
              ],
            ),
          VSpace(style.paddingCloseButton),
          if (title != null)
            Text(
              title!,
              style: style.titleTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          if (body != null) body!,
          Row(
            children: [
              if (secondaryButtonAction != null)
                Expanded(
                  flex: 1,
                  child: OversightButton(
                    title: secondaryButtonTitle ?? 'CLOSE',
                    onPressed: secondaryButtonAction,
                    style: style.secondaryButtonStyle,
                    icon: secondaryButtonIcon,
                  ),
                ),
              if (mainButtonAction != null && secondaryButtonAction != null)
                HSpace(style.paddingButtons),
              if (mainButtonAction != null)
                Expanded(
                  flex: 1,
                  child: OversightButton(
                    title: mainButtonTitle ?? 'ENTER',
                    onPressed: mainButtonAction,
                    style: style.mainButtonStyle,
                    icon: mainButtonIcon,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
