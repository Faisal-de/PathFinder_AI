import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pathfinder_ai/main.dart';

void main() {
  testWidgets('Login screen is the first screen', (WidgetTester tester) async {
    await tester.pumpWidget(const PathFinderApp());

    expect(find.text('PathFinder AI'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });
}
