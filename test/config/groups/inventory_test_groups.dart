import 'package:flutter_test/flutter_test.dart';

import '../../app/modules/inventory/inventory_controller_test.dart';
import '../../app/modules/inventory/repo/inventory_repo_test.dart';
import '../../app/modules/inventory/service/inventory_service_test.dart';
import '../../app/modules/inventory/view/inventory_view_edit_test.dart';
import '../../app/modules/inventory/view/inventory_view_test.dart';
import '../../app/modules/inventory/view/inventory_view_validation_test.dart';
import '../tests_properties.dart';
import '../titles/inventory_tests_titles.dart';

class InventoryTestGroups {
  void groups({required bool skipGroup}) {
    group(
      InventoryTestsTitles().REPO_TITLE,
      InventoryRepoTests.unit,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );

    group(
      InventoryTestsTitles().SERVICE_TITLE,
      InventoryServiceTests.unit,
      skip: skipGroup,
    );

    group(
      InventoryTestsTitles().CONTROLLER_TITLE,
      InventoryControllerTests.integration,
      skip: skipGroup,
    );

    group(
      "${InventoryTestsTitles().VIEW_TITLE}",
      InventoryViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );

    group(
      InventoryTestsTitles().VIEW_VALID_TITLE,
      InventoryViewValidationTest(isWidgetTest: WIDGET_TEST).functional,
      skip: skipGroup,
    );

    group(
      InventoryTestsTitles().VIEW_EDIT_TITLE,
      InventoryViewEditTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}