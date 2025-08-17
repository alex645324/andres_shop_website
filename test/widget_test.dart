// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:andres_shop_website/main.dart';

void main() {
  testWidgets('Travel app displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the main UI elements are present.
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('Amazing places around the world'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Beautiful Place'), findsOneWidget);
    expect(find.text('Scenic View'), findsOneWidget);

    // Verify that category filter works
    await tester.tap(find.text('Beach'));
    await tester.pump();
    
    // Verify navigation icons are present
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });
}
