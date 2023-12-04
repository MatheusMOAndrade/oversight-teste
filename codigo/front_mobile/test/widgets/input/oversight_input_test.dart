import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oversight/presentation/widgets/widgets.dart';

import '../widget_test_wrapper.dart';

void main() {
  group("OversightInput Build", () {
    testWidgets('Input should build without parameters',
        (WidgetTester tester) async {
      // Build the widget.
      await tester.pumpWidget(
        widgetTestWrap(
          widget: const OversightInput(),
        ),
      );

      expect(find.byType(OversightInput), findsOneWidget);
    });
    testWidgets('Input should build with 1 line by default',
        (WidgetTester tester) async {
      // Build the widget.
      await tester.pumpWidget(
        widgetTestWrap(
          widget: const OversightInput(),
        ),
      );

      expect(
        tester.firstWidget<TextField>(find.byType(TextField)).maxLines,
        equals(1),
      );
    });
  });
  group("OversightInput placeholder and initial value", () {
    testWidgets('Input should build with initial value',
        (WidgetTester tester) async {
      // Build the widget.
      await tester.pumpWidget(
        widgetTestWrap(
          widget: const OversightInput(
            initialValue: 'initial value',
          ),
        ),
      );

      expect(find.byType(OversightInput), findsOneWidget);

      expect(find.text('initial value'), findsOneWidget);
    });
    testWidgets('Input should build with placeholder',
        (WidgetTester tester) async {
      // Build the widget.
      await tester.pumpWidget(
        widgetTestWrap(
          widget: const OversightInput(
            placeholder: 'placeholder',
          ),
        ),
      );

      expect(find.byType(OversightInput), findsOneWidget);

      expect(find.text('placeholder'), findsOneWidget);
    });
  });

  group("OversightInput Labels", () {
    testWidgets('Input should build with top label',
        (WidgetTester tester) async {
      // Build the widget.
      await tester.pumpWidget(
        widgetTestWrap(
          widget: const OversightInput(
            topLabel: 'top label',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(OversightInput), findsOneWidget);

      expect(find.text('top label'), findsOneWidget);
    });
  });

  group("OversightInput Obscured", () {
    testWidgets(
        'Input should show a OversightIconButton when parameter obscure is true',
        (WidgetTester tester) async {
      // Build the widget.
      await tester.pumpWidget(
        widgetTestWrap(
          widget: const OversightInput(
            obscure: true,
          ),
        ),
      );

      expect(find.byType(OversightInput), findsOneWidget);
      expect(find.byType(OversightIconButton), findsOneWidget);
    });
    testWidgets(
        'OversightIconButton should be invisible when parameter obscure is true by default',
        (WidgetTester tester) async {
      // Build the widget.
      await tester.pumpWidget(
        widgetTestWrap(
          widget: const OversightInput(
            obscure: true,
          ),
        ),
      );

      expect(find.byType(OversightInput), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });
  });

  testWidgets(
      'Input should change the icon when the OversightIconButton is tapped',
      (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(
      widgetTestWrap(
        widget: const OversightInput(
          obscure: true,
        ),
      ),
    );

    expect(find.byType(OversightInput), findsOneWidget);

    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

    expect(find.byType(OversightIconButton), findsOneWidget);

    await tester.tap(find.byType(OversightIconButton));
    await tester.pump();

    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
  });
  group("OversightInput Functionality", () {
    testWidgets('Input should change its value', (WidgetTester tester) async {
      // Build the widget.
      await tester.pumpWidget(
        widgetTestWrap(
          widget: OversightInput(
            informationCallback: () {},
          ),
        ),
      );

      expect(find.byType(OversightInput), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'typed on OversightInput');

      expect(find.text('typed on OversightInput'), findsOneWidget);
    });
  });
}
