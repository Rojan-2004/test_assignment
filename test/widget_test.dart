import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aqua_life/app/app.dart';
import 'package:aqua_life/core/services/storage/user_session_service.dart';

void main() {
  testWidgets('Splash page renders correctly', (WidgetTester tester) async {
    // Initialize mock SharedPreferences values
    SharedPreferences.setMockInitialValues({});
    final sharedPrefs = await SharedPreferences.getInstance();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        ],
        child: const App(),
      ),
    );

    // Verify that the splash page shows the text AQUALIFE
    expect(find.text('AQUALIFE'), findsOneWidget);

    // Let the splash screen timer complete (2 seconds delay)
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
  });
}
