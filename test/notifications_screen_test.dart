import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:enviora_profile/notifications_screen.dart';

void main() {
  testWidgets('Notifications Screen renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: NotificationsScreen()));

    // Check Header
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Check Settings Section
    expect(find.text('Notification Settings'), findsOneWidget);
    expect(find.text('Pickup Reminders'), findsOneWidget);
    expect(find.text('Truck Tracking'), findsOneWidget);
    expect(find.text('Special Pickups'), findsOneWidget);
    expect(find.text('System Updates'), findsOneWidget);

    // Check Toggles
    expect(find.byType(Switch), findsNWidgets(4));

    // Check History Section
    final recentNotificationsHeader = find.text('Recent Notifications');
    await tester.scrollUntilVisible(
      recentNotificationsHeader,
      500.0,
      scrollable: find.byType(Scrollable),
    );
    expect(recentNotificationsHeader, findsOneWidget);
    // Check History Section
    expect(find.text('Recent Notifications'), findsOneWidget);

    final clearAllText = find.text('Clear All');
    await tester.scrollUntilVisible(
      clearAllText,
      500.0,
      scrollable: find.byType(Scrollable),
    );
    expect(clearAllText, findsOneWidget);
  });

  testWidgets('Toggles change state', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: NotificationsScreen()));

    // Find the switch tile for Special Pickups
    final specialPickupTile = find.byKey(const Key('specialPickupsTile'));
    expect(specialPickupTile, findsOneWidget);

    // Verify initial state (false)
    // We check the Switch widget descendant
    final switchFinder = find.descendant(
      of: specialPickupTile,
      matching: find.byType(Switch),
    );
    expect(
      tester.widget<Switch>(switchFinder).value,
      isFalse,
    );

    // Tap to toggle
    await tester.tap(specialPickupTile);
    await tester.pump();

    // Verify it's now true
    expect(
      tester.widget<Switch>(switchFinder).value,
      isTrue,
    );
  });

  testWidgets('Clear All shows dialog and clears notifications',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: NotificationsScreen()));

    // Verify notifications are present
    final notificationItem = find.text('Garbage Collection Tomorrow');
    await tester.scrollUntilVisible(
      notificationItem,
      500.0,
      scrollable: find.byType(Scrollable),
    );
    expect(notificationItem, findsOneWidget);

    // Tap Clear All
    final clearAllButton = find.text('Clear All');
    await tester.ensureVisible(clearAllButton);
    await tester.tap(clearAllButton);
    await tester.pumpAndSettle();

    // Check Dialog
    expect(find.text('Clear All Notifications?'), findsOneWidget);

    // Confirm Clear
    await tester.tap(find
        .text('Clear All')
        .last); // .last because duplicate text in dialog button
    await tester.pumpAndSettle();

    // Verify notifications are gone
    expect(find.text('Garbage Collection Tomorrow'), findsNothing);
    expect(find.text('No notifications'), findsOneWidget);
  });
}
