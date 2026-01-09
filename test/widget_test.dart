import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jizhang/main.dart';

void main() {
  testWidgets('App shell loads', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.text('Ledger'), findsOneWidget);
    expect(find.byIcon(Icons.receipt_long), findsOneWidget);
  });
}
