import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oversight/presentation/widgets/dropdowns/dropdown/dropdown.dart';

import '../widget_test_wrapper.dart';

void main() {
  const kItems = ["item1", "item2"];
  group('Oversight Dropdown', () {
    testWidgets('should build', (tester) async {
      await tester
          .pumpWidget(widgetTestWrap(widget: const OversightDropdown()));

      expect(find.byType(OversightDropdown), findsOneWidget);
    });
    testWidgets('should build with items and they should be selectable',
        (tester) async {
      String value = '';
      await tester.pumpWidget(
        widgetTestWrap(
          widget: OversightDropdown(
            items: kItems,
            onItemSelected: (d) {
              value = d ?? '';
            },
          ),
        ),
      );

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byType(OversightDropdown), findsOneWidget);

      expect(find.text(kItems[0]), findsWidgets);
      expect(find.text(kItems[1]), findsWidgets);
      await tester.tap(find.text(kItems[0]).last);
      expect(value, kItems[0]);
    });
    testWidgets('should build uusing themes by default', (tester) async {
      // ignore: unused_local_variable
      String value = '';
      await tester.pumpWidget(
        widgetTestWrap(
          widget: OversightDropdown(
            items: kItems,
            onItemSelected: (d) {
              value = d ?? '';
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byType(OversightDropdown), findsOneWidget);

      final DropdownButtonFormField<String> dropdown =
          tester.firstWidget(find.byType(DropdownButtonFormField<String>));
      expect(dropdown.decoration.enabledBorder?.borderSide.color,
          const OversightDropdownStyle().borderColor);
      expect(dropdown.decoration.enabledBorder?.borderSide.width,
          const OversightDropdownStyle().borderWidth);
      expect(
        (dropdown.decoration.enabledBorder as OutlineInputBorder).borderRadius,
        BorderRadius.circular(const OversightDropdownStyle().borderRadius),
      );
    });
  });
}
