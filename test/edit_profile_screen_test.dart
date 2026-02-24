import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:enviora_profile/edit_profile_screen.dart';

void main() {
  testWidgets('Edit Profile Screen renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EditProfileScreen()));

    // Check Header
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Check Form Fields by Key
    expect(find.byKey(const Key('fullNameField')), findsOneWidget);
    expect(find.byKey(const Key('mobileField')), findsOneWidget);
    expect(find.byKey(const Key('emailField')), findsOneWidget);
    expect(find.byKey(const Key('addressField')), findsOneWidget);

    // Check Buttons
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Save Changes'), findsOneWidget);
    expect(find.text('Change Password?'), findsOneWidget);
  });

  testWidgets('Input fields allow text entry', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EditProfileScreen()));

    await tester.enterText(find.byKey(const Key('fullNameField')), 'John Doe');
    expect(find.text('John Doe'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('mobileField')), '1234567890');
    expect(find.text('1234567890'), findsOneWidget);
  });

  testWidgets('Cancel button pops navigation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => TextButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const EditProfileScreen())),
          child: const Text('Go'),
        ),
      ),
    ));

    await tester.tap(find.text('Go'));
    await tester.pumpAndSettle();

    expect(find.byType(EditProfileScreen), findsOneWidget);

    final cancelButton = find.text('Cancel');
    await tester.ensureVisible(cancelButton);
    await tester.tap(cancelButton);
    await tester.pumpAndSettle();

    expect(find.byType(EditProfileScreen), findsNothing);
  });

  testWidgets('Save button shows snackbar on valid input',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EditProfileScreen()));

    // Enter valid mobile number
    await tester.enterText(find.byKey(const Key('mobileField')), '1234567890');

    final saveButton = find.text('Save Changes');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(find.text('Profile updated successfully!'), findsOneWidget);
  });
}
