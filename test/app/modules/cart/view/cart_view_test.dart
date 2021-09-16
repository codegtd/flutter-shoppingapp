import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';

import '../../../../config/bindings/cart_test_bindings.dart';
import '../../../../config/tests_properties.dart';
import '../../../../config/titles/cart_tests_titles.dart';
import '../../../../tests_datasource/mocked_datasource.dart';
import '../../../../utils/dbtest_utils.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/tests_global_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'cart_tests.dart';

class CartViewTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _titles = Get.put(CartTestsTitles());
  final _bindings = Get.put(CartTestBindings());
  final _testUtils = Get.put(TestsUtils());
  final _globalMethods = Get.put(TestsGlobalUtils());

  CartViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    var _products = <dynamic>[];

    final _tests = Get.put(CartTests(
        finder: _finder,
        dbTestUtils: _dbUtils,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async {
      _globalMethods
          .globalSetUpAll('${_tests.runtimeType.toString()} $SHARED_STATE_TITLE');
      // _products = await _testUtils.post_databuilderProductList_InDb(
      //   isWidgetTest: _isWidgetTest,
      //   numberOfProducts: TOTAL_SAMPLEDATA_ITEMS_LOADED_IN_TESTDB,
      // );
      _products = _isWidgetTest
          ? await Future.value(MockedDatasource().products())
          : await _dbUtils.getCollection(url: PRODUCTS_URL);
    });

    tearDownAll(() => _globalMethods.globalTearDownAll(
          _tests.runtimeType.toString(),
          isWidgetTest: _isWidgetTest,
        ));

    setUp(() {
      _globalMethods.globalSetUp();
      _bindings.bindingsBuilderMockedRepo(isWidgetTest: _isWidgetTest);
    });

    tearDown(_globalMethods.globalTearDown);

    testWidgets(_titles.clearCart_tapClearButton, (tester) async {
      await _tests.ClearingCart_tappingClearButton(tester);
    });

    testWidgets(_titles.add_product_check_appbar_shopCart, (tester) async {
      await _tests.Add2Products_checkAppbarCartIconQtde(tester);
    });

    testWidgets(_titles.check_2products_inCartPage, (tester) async {
      await _tests.Check_2Products_inCartPage(tester, _products);
    });

    testWidgets(_titles.add_product_check_snackbar, (tester) async {
      await _tests.AddProduct_checkSnackbar(tester, _products);
    });

    testWidgets(_titles.denying_dismissingCartItem, (tester) async {
      await _tests.Denying_dismissingCartItem(tester, _products);
    });

    testWidgets(_titles.dismissing_first_added_product, (tester) async {
      await _tests.Dismissing_firstAddedProduct(tester, _products);
    });

    testWidgets(_titles.dismissing_all_added_products, (tester) async {
      await _tests.Dismissing_allAddedProducts(tester, _products);
    });

    testWidgets(_titles.emptyCart_blockAccessCartPage, (tester) async {
      await _tests.EmptyCart_blockAccessCartPage(tester);
    });

    testWidgets(_titles.open_cartPage_check2Products, (tester) async {
      await _tests.Opening_cartPage_check2Products(tester, _products);
    });

    // testWidgets(_titles.clearCart_tapClearButton, (tester) async {
    //   await _tests.ClearingCart_tappingClearButton(tester, _products);
    // });

    testWidgets(_titles.check_amount_cart, (tester) async {
      await _tests.Check_amountCart(tester, _products);
    });

    testWidgets(_titles.order_cartProducts_tapOrderNowButton, (tester) async {
      await _tests.Ordering_cartProducts_tappingOrderNowButton(tester, _products);
    });

    testWidgets(_titles.test_page_backbutton, (tester) async {
      await _tests.Testing_pageBackButton(tester);
    });
  }
}