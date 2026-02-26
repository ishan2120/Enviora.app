import 'package:flutter_test/flutter_test.dart';
import 'package:enviora_profile/main.dart';

void main() {
  testWidgets('App launches and shows Profile screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const EnvioraApp());
    await tester.pump();

    // The app should launch and show the Profile screen
    expect(find.text('Profile'), findsOneWidget);
  });
}
