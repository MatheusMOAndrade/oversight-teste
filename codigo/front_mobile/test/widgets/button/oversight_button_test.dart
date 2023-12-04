import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oversight/presentation/widgets/widgets.dart';

import '../widget_test_wrapper.dart';

void main() {
  group("OversightButton Build", () {
    testWidgets('Oversight Button should Build with no parameters',
        (WidgetTester tester) async {
      // Build the widget.
      await tester.pumpWidget(widgetTestWrap(widget: const OversightButton()));

      // Ensure that the button is on the screen.
      expect(find.byType(OversightButton), findsOneWidget);
    });
  });
  group("OversightButton Size", () {
    testWidgets('Width should be 48px when width and text parameter is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        widgetTestWrap(
          widget: const OversightButton(),
        ),
      );

      final Size baseSize = tester.getSize(find.byType(OversightButton));

      // Ensure that the min width is 48px
      expect(baseSize.width, equals(48.0));
    });
  });

  group("OversightButtonTheme ", () {
    testWidgets(
        'Button Theme should fill the properties when no other parameters are assigned',
        (WidgetTester tester) async {
      const tButtonTheme = OversightButtonStyle.outlined();
      // Build the widget.
      await tester.pumpWidget(
        widgetTestWrap(
          widget: OversightButton(
            style: tButtonTheme,
            icon: Icons.android,
            onPressed: () {},
          ),
        ),
      );

      final Size baseSize = tester.getSize(find.byType(OversightButton));

      // Ensure that the height is 56px
      expect(baseSize.height, equals(tButtonTheme.height));

      // Ensure that the theme is applied
      expect(tester.firstWidget<Icon>(find.byIcon(Icons.android)).color,
          equals(tButtonTheme.secondaryColor));
    });

    testWidgets(
        'Button parameters should fill the assigned properties even when a theme is assigned',
        (WidgetTester tester) async {
      var _color = Colors.red;
      var _size = 32.0;
      var _height = 42.0;

      // Build the widget.
      await tester.pumpWidget(
        widgetTestWrap(
          widget: OversightButton(
            onPressed: () {},
            icon: Icons.android,
            style: OversightButtonStyle.outlined(
              backgroundColor: _color,
              borderColor: _color,
              secondaryColor: _color,
              borderRadius: _size,
              borderWidth: _size,
              height: _height,
            ),
          ),
        ),
      );

      final Size baseSize = tester.getSize(find.byType(OversightButton));

      // Ensure that the height is 56px
      expect(baseSize.height, equals(_height));

      // Ensure that the parameter is applied over the theme
      expect(tester.firstWidget<Icon>(find.byIcon(Icons.android)).color,
          equals(_color));
    });
  });
}
