import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oversight/presentation/widgets/widgets.dart';
import 'package:oversight/themes/oversight_colors.dart';

import '../widget_test_wrapper.dart';

void main() {
  group("Build Oversight CheckBox with default values", () {
    testWidgets('Checkbox Should Build with no parameters',
        (WidgetTester tester) async {
      // Build the widget.
      await tester.pumpWidget(
        widgetTestWrap(
          widget: const OversightCheckBox(),
        ),
      );

      // Ensure that the button is on the screen.
      expect(find.byType(OversightCheckBox), findsOneWidget);
    });

    testWidgets('The checkbox default values ​​must match and not be null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        widgetTestWrap(
          widget: const OversightCheckBox(),
        ),
      );

      final Container checkBox =
          tester.firstWidget<Container>(find.byType(Container).last);
      final BoxDecoration checkBoxDecoration =
          checkBox.decoration as BoxDecoration;
      final Icon icon = tester.firstWidget<Icon>(find.byType(Icon));
      final Size checkBoxSize = tester.getSize(find.byType(Container).last);

      expect(checkBoxDecoration.color, OversightColors.transparent);
      expect(checkBoxDecoration.borderRadius, BorderRadius.circular(4));
      expect(checkBoxDecoration.border,
          Border.all(color: OversightColors.graniteGray, width: 1));
      expect(icon.icon, Icons.check);
      expect(icon.color, OversightColors.transparent);
      expect(icon.size, equals(24 / 1.2));
      expect(checkBoxSize.width, equals(24.0));
      expect(find.byType(OversightCheckBox), findsOneWidget);
    });
  });
}
