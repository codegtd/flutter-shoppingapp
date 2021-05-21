import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app/core/components/components_test_groups.dart';
import 'app/modules/cart/cart_test_groups.dart';
import 'app/modules/inventory/inventory_test_groups.dart';
import 'app/modules/inventory/view/inventory_view_functional_test.dart';
import 'app/modules/orders/orders_test_groups.dart';
import 'app/modules/orders/view/orders_view_functional_test.dart';
import 'app/modules/overview/overview_test_groups.dart';
import 'app_tests_config.dart';

void main() {
  const _testType = String.fromEnvironment('myVar', defaultValue: UNIT_TESTS);
  if (_testType == UNIT_TESTS) _unitTests();
  if (_testType == INTEGRATION_TESTS) _integrationTests();
  if (_testType != UNIT_TESTS && _testType != INTEGRATION_TESTS) _testTypeNotAllowed;
}

void _testTypeNotAllowed() {
  print('TestType not Allowed.');
}

void _unitTests() {
  CartTest().groups();
  OrdersTest().groups();
  OverviewTest().groups();
  InventoryTest().groups();
  ComponentsTest().groups();
}

void _integrationTests() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // group('Orders|Integration-Tests: ',
  //     OrdersViewFunctionalTest(testType: INTEGRATION_TESTS).functional);
  group('Inventory|Integration-Tests: ',
      InventoryViewFunctionalTests(testType: INTEGRATION_TESTS).functional);
}
