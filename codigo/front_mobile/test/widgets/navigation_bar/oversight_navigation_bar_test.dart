import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oversight/presentation/widgets/widgets.dart';

import '../widget_test_wrapper.dart';

void main() {
  testWidgets(
    'oversight bottom navigation bar should use values from theme',
    (tester) async {
      await tester.pumpWidget(
        widgetTestWrap(
          widget: const OversightBottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "option1"),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "option2"),
            ],
          ),
        ),
      );
      final tWidget = tester
          .firstWidget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      final widgetStyle = OversightBottomNavigationBarStyle();
      expect(tWidget.backgroundColor, widgetStyle.backgroundColor);
      expect(tWidget.iconSize, widgetStyle.iconSize);
      expect(tWidget.selectedLabelStyle, widgetStyle.selectedLabelStyle);
      expect(tWidget.unselectedLabelStyle, widgetStyle.unselectedLabelStyle);
      expect(tWidget.showSelectedLabels, widgetStyle.showSelectedLabels);
      expect(tWidget.showUnselectedLabels, widgetStyle.showUnselectedLabels);
      expect(tWidget.selectedItemColor, widgetStyle.selectedIconColor);
    },
  );
}
