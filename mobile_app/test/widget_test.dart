import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/main.dart';

void main() {
  testWidgets('App launches and renders HomeScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const Enviora());
    await tester.pump();

    // App should launch without errors and show the Enviora title
    expect(find.text('Enviora'), findsOneWidget);
  });
}
