import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:talha_portfilo/main.dart';

void main() {
  // visibility_detector normally polls on a periodic Timer; that timer
  // outlives a single pump cycle and trips the test framework's "no
  // pending timers at teardown" check. Zero disables the timer and makes
  // it check synchronously after each frame instead — the package's own
  // documented fix for widget tests.
  setUpAll(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets('Home page renders the hero headline', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    // Not pumpAndSettle: the hero's background glow animates forever
    // (AnimationController..repeat), so settle() would never return.
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    // "Senior Flutter Developer" legitimately appears twice (hero headline
    // + the matching job title in the Experience timeline), so assert on
    // the hero's unique tagline instead.
    expect(
      find.text('I design and ship polished, production-grade Flutter apps — from first commit to store launch.'),
      findsOneWidget,
    );
  });
}
