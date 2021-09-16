import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';

import '../../../../config/bindings/orders_test_bindings.dart';
import '../../../../config/tests_properties.dart';
import '../../../../config/titles/orders_tests_titles.dart';
import '../../../../utils/dbtest_utils.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/tests_global_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'orders_tests.dart';

class OrdersViewTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _titles = Get.put(OrdersTestsTitles());
  final _bindings = Get.put(OrdersTestBindings());
  final _globalMethods = Get.put(TestsGlobalUtils());
  final _testUtils = Get.put(TestsUtils());

  OrdersViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(OrdersTests(
        finder: _finder,
        dbTestUtils: _dbUtils,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async => _globalMethods
        .globalSetUpAll('${_tests.runtimeType.toString()} $SHARED_STATE_TITLE'));

    tearDownAll(() => _globalMethods.globalTearDownAll(
          _tests.runtimeType.toString(),
          isWidgetTest: _isWidgetTest,
        ));

    setUp(() {
      _globalMethods.globalSetUp();
      _bindings.bindingsBuilderMockedRepo(isWidgetTest: _isWidgetTest);
    });

    tearDown(_globalMethods.globalTearDown);

    testWidgets(_titles.orderingAProduct_inCartView_tapping_OrderNowButton,
        (tester) async {
      await _tests.orderProduct_inCartView_tapOrderNowButton(
        tester,
        DELAY,
        ordersDoneQtde: _isWidgetTest ? 2 : 1,
      );
    });

    testWidgets(_titles.check_orders_with_one_orderInDB, (tester) async {
      await _tests.create_order_from_cartView(tester, DELAY);
    });

    testWidgets(_titles.tap_viewBackButton, (tester) async {
      await _tests.tappingBackButtonInOrdersView(
        tester,
        DELAY,
        from: OrdersView,
        to: OverviewView,
      );
    });

    // testWidgets(_titles.check_emptyView_noOrderInDb, (tester) async {
    //   _bindings.bindingsBuilderMockRepoEmptyDb(isWidgetTest: _isWidgetTest);
    //   await _tests.check_emptyOrderCollection(tester, DELAY);
    // });
  }
}