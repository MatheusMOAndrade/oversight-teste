import 'package:flutter_test/flutter_test.dart';
import 'package:oversight/presentation/widgets/widgets.dart';

import '../widget_test_wrapper.dart';

void main() {
  // ignore: no_leading_underscores_for_local_identifiers
  const String _title = "test fake title";

  group('Oversight Actions Card Build', () {
    testWidgets('should Build with no parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        widgetTestWrap(
          widget: const OversightActionsCard(
            isBudget: false,
            itemName: _title,
          ),
        ),
      );

      // Ensure that the button is on the screen.
      expect(find.byType(OversightActionsCard), findsOneWidget);
    });

    testWidgets('should build the widget with parameters',
        (WidgetTester tester) async {
      // Build the widget.
      await tester.pumpWidget(
        widgetTestWrap(
          widget: OversightActionsCard(
            isBudget: false,
            itemName: 'Test name',
            status: 'Aguardando',
            menuItemList: [BubbleMenuItem(text: 'Deletar', action: () {})],
          ),
        ),
      );
      // Ensure that the button is on the screen.
      expect(find.byType(OversightActionsCard), findsOneWidget);
    });
  });
}
