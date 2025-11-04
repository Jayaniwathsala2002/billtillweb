// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ✅ Now this WORKS after analyzer refresh
import 'package:billtillweb/main.dart';
import 'package:billtillweb/language_manager.dart';

void main() {
  testWidgets('App loads without errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      const BillTillWeb(initialLanguage: AppLanguage.english), // ✅ const added
    );

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
