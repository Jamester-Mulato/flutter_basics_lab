import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_basics_lab/activity1_profile_card.dart';

void main() {
  testWidgets('Activity smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProfileApp());
    expect(find.byType(ProfileApp), findsOneWidget);
  });
}
