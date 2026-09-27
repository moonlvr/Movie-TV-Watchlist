// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movie_watchlist_app/main.dart';
import 'package:movie_watchlist_app/screens/account_store.dart';
import 'package:movie_watchlist_app/screens/home_screen.dart';

void main() {
  setUp(() {
    UserSession.clear();
    AccountStore.register(
      Account(
        name: 'Alice Johnson',
        email: 'alice@example.com',
        password: 'secret123',
      ),
    );
  });

  testWidgets('login updates the current profile session', (tester) async {
    await tester.pumpWidget(const MovieWatchlistApp());

    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'alice@example.com');
    await tester.enterText(textFields.at(1), 'secret123');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Log In'));
    await tester.pumpAndSettle();

    expect(UserSession.displayName, 'Alice Johnson');
    expect(UserSession.email, 'alice@example.com');
    expect(UserSession.initials, 'AJ');
  });
}
