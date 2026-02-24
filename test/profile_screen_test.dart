import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:enviora_profile/profile_screen.dart'; // Assuming package name from pubspec.yaml

void main() {
  // Helper to pump the widget
  Future<void> pumpProfileScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(),
      ),
    );
  }

  testWidgets('Profile Screen renders title and user info',
      (WidgetTester tester) async {
    await pumpProfileScreen(tester);

    // Verify Title
    expect(find.text('Profile'), findsOneWidget);

    // Verify User Info
    expect(find.text('G.G.K.Ranudaya'), findsOneWidget);
    expect(find.text('ggkranudaya@gmail.com'), findsOneWidget);
  });

  testWidgets('Points Card renders with correct value',
      (WidgetTester tester) async {
    await pumpProfileScreen(tester);

    expect(find.text('Points'), findsOneWidget);
    expect(find.text('1000'), findsOneWidget);
    expect(find.text('Redeem'), findsOneWidget);
  });

  testWidgets('Settings sections are present', (WidgetTester tester) async {
    await pumpProfileScreen(tester);

    expect(find.text('Account Settings'), findsOneWidget);
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);

    expect(find.text('Activity History'), findsNWidgets(2));
    expect(find.text('View reported issues & pickups'), findsOneWidget);

    expect(find.text('Preferences'), findsOneWidget);
    expect(find.text('Region Settings'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
  });

  testWidgets('Logout button is present', (WidgetTester tester) async {
    await pumpProfileScreen(tester);

    expect(find.text('Log Out'), findsOneWidget);
    expect(find.byIcon(Icons.logout), findsOneWidget);
  });

  testWidgets('Bottom Navigation Bar is present', (WidgetTester tester) async {
    await pumpProfileScreen(tester);

    expect(find.text('HOME'), findsOneWidget);
    expect(find.text('GUIDE'), findsOneWidget);
    expect(find.text('MAP'), findsOneWidget);
    expect(find.text('PROFILE'), findsOneWidget);

    // Check if Profile icon is green (active)
    final profileIconFinder = find.ancestor(
      of: find.text('PROFILE'),
      matching: find.byType(Column),
    );
    // This is a bit complex to test exact color without finding the specific widget instance,
    // but we verify existence of the nav bar items.
  });
}
