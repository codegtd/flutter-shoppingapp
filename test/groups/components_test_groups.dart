import 'package:flutter_test/flutter_test.dart';

import '../app/core/components/drawwer_test.dart';
import '../app/core/components/progres_indicator_test.dart';
import '../config/titles/components_test_titles.dart';

class ComponentsTestGroups {
  void groups(bool skipGroup) {
    group(
      ComponentsTestTitles().DRAWWER_TEST_TITLE,
      DrawwerTest.functional,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );

    group(
      ComponentsTestTitles().PROGR_IND_TEST_TITLE,
      ProgresIndicatorTest.functional,
      skip: skipGroup,
    );
  }
}