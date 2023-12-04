import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oversight/presentation/widgets/widgets.dart';

import '../widget_test_wrapper.dart';

void main() {
  group("OversightAlert Build", () {
    testWidgets('alert Should show without optional parameters',
        (WidgetTester tester) async {
      // Build the widget.
      var _contextKey = const Key('context_key');
      // pumpWidget
      await tester.pumpWidget(
        widgetTestWrap(
          widget: Container(key: _contextKey),
        ),
      );
      // get context
      final BuildContext context = tester.element(
        find.byKey(_contextKey),
      );
      // call the alert
      OversightAlert().showOversightAlert(
        context,
      );
      // pump and settle
      await tester.pumpAndSettle();
      // find the widget by key
      expect(find.byKey(const Key('oversight_alert')), findsOneWidget);
    });
    testWidgets('alert Should show with title', (WidgetTester tester) async {
      var _contextKey = const Key('context_key');
      await tester.pumpWidget(
        widgetTestWrap(
          widget: Container(key: _contextKey),
        ),
      );
      final BuildContext context = tester.element(
        find.byKey(_contextKey),
      );
      OversightAlert().showOversightAlert(
        context,
        title: 'title_test',
      );
      await tester.pumpAndSettle();

      expect(find.text('title_test'), findsOneWidget);
    });
    testWidgets('alert Should show with body', (WidgetTester tester) async {
      var _contextKey = const Key('context_key');
      await tester.pumpWidget(
        widgetTestWrap(
          widget: Container(key: _contextKey),
        ),
      );
      final BuildContext context = tester.element(
        find.byKey(_contextKey),
      );
      OversightAlert().showOversightAlert(
        context,
        title: 'title_test',
        body: const Text('body_test'),
      );
      await tester.pumpAndSettle();

      expect(find.text('body_test'), findsOneWidget);
    });

    group("Oversight Alert Functionality", () {
      testWidgets('alert Main Button Action', (WidgetTester tester) async {
        var _contextKey = const Key('context_key');
        await tester.pumpWidget(
          widgetTestWrap(
            widget: Container(key: _contextKey),
          ),
        );
        final BuildContext context = tester.element(
          find.byKey(_contextKey),
        );

        var _test = false;

        OversightAlert().showOversightAlert(
          context,
          title: 'title_test',
          body: const Text('body_test'),
          mainButtonAction: () {
            _test = !_test;
          },
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('ENTER'));
        await tester.pumpAndSettle();

        expect(_test, true);
      });
    });
  });
}
