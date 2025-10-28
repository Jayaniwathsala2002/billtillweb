// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:billtill/main.dart';

void main() {
  testWidgets('Navbar and sections render correctly',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester
        .pumpWidget(const BillTillWeb()); // ✅ Changed from MyApp to BillTillWeb

    // Verify that the home section is visible (e.g., contains "Home")
    expect(find.text('Home'), findsOneWidget);

    // Optional: Add more meaningful tests for your app
  });
}
