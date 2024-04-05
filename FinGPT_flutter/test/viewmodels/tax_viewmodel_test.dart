import 'package:flutter_test/flutter_test.dart';
import 'package:fintaxai/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('TaxViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
