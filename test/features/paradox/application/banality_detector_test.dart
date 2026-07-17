import 'package:flutter_test/flutter_test.dart';
import 'package:paradox_engine_swarm/features/paradox/application/banality_detector.dart';

void main() {
  group('BanalityDetector', () {
    late BanalityDetector detector;

    setUp(() {
      detector = BanalityDetector();
    });

    test('detects banal statement', () {
      expect(
        detector.isBanal('It depends on the perspective. '
            'Both sides have a point here.'),
        isTrue,
      );
    });

    test('does not flag non-banal statement', () {
      expect(
        detector.isBanal('The paradox reveals a fundamental '
            'contradiction in our assumptions.'),
        isFalse,
      );
    });
  });
}
