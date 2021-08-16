import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/messages/field_form_validation_provided.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';

import '../../../../config/bindings/inventory_test_bindings.dart';
import '../../../../config/tests_config.dart';
import '../../../../config/titles/inventory_test_titles.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'inventory_tests.dart';

class InventoryViewValidationFunctionalTest {
  late bool _isWidgetTest;
  final _utils = Get.put(TestUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _bindings = Get.put(InventoryTestBindings());
  final _titles = Get.put(InventoryTestTitles());

  InventoryViewValidationFunctionalTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    var _products = <Product>[];

    final _tests = Get.put(InventoryTests(
      testUtils: _utils,
      dbTestUtils: _dbUtils,
      uiTestUtils: _uiUtils,
      isWidgetTest: _isWidgetTest,
    ));

    setUpAll(() async {
      _utils.globalSetUpAll(_tests.runtimeType.toString());
      _products = await _utils.load_4ProductsInDb(isWidgetTest: _isWidgetTest);
    });

    tearDownAll(
        () => _utils.globalTearDownAll(_tests.runtimeType.toString(), _isWidgetTest));

    setUp(() {
      _utils.globalSetUp();
      _bindings.bindingsBuilderMockedRepo(isUnitTest: _isWidgetTest);
    });

    tearDown(_utils.globalTearDown);

    //TITLE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------------
    testWidgets(_titles.validation_title_size, (tester) async {
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        validationErrorMessage: SIZE_05_INVALID_ERROR_MSG,
        productToUpdate: _products[0],
      );
    });

    testWidgets(_titles.validation_title_empty, (tester) async {
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        validationErrorMessage: EMPTY_FIELD_INVALID_ERROR_MSG,
        productToUpdate: _products[0],
      );
    });

    testWidgets(_titles.validation_title_inject, (tester) async {
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        validationErrorMessage: TEXT_NUMBER_INVALID_ERROR_MSG,
        productToUpdate: _products[0],
      );
    });

    //DESCRIPTION CHECK VALIDATIONS + CHECK INJECTIONS -------------------------
    testWidgets(_titles.validation_descript_size, (tester) async {
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        validationErrorMessage: SIZE_10_INVALID_ERROR_MSG,
        productToUpdate: _products[0],
      );
    });

    testWidgets(_titles.validation_descript_empty, (tester) async {
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        validationErrorMessage: EMPTY_FIELD_INVALID_ERROR_MSG,
        productToUpdate: _products[0],
      );
    });

    testWidgets(_titles.validation_descript_inject, (tester) async {
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        validationErrorMessage: TEXT_NUMBER_INVALID_ERROR_MSG,
        productToUpdate: _products[0],
      );
    });

    //PRICE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------------
    testWidgets(_titles.validation_price_size, (tester) async {
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "evilLetterrr",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        validationErrorMessage: PRICE_INVALID_ERROR_MSG,
        productToUpdate: _products[0],
      );
    });

    testWidgets(_titles.validation_price_empty, (tester) async {
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        validationErrorMessage: EMPTY_FIELD_INVALID_ERROR_MSG,
        productToUpdate: _products[0],
      );
    });

    testWidgets(_titles.validation_price_inject, (tester) async {
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        validationErrorMessage: PRICE_INVALID_ERROR_MSG,
        productToUpdate: _products[0],
      );
    });

    //URL CHECK VALIDATIONS + CHECK INJECTIONS ---------------------------------
    testWidgets(_titles.validation_url_size, (tester) async {
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "evilLetter",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        validationErrorMessage: URL_INVALID_ERROR_MSG,
        productToUpdate: _products[0],
      );
    });

    testWidgets(_titles.validation_url_empty, (tester) async {
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        validationErrorMessage: EMPTY_FIELD_INVALID_ERROR_MSG,
        productToUpdate: _products[0],
      );
    });

    testWidgets(_titles.validation_url_inject, (tester) async {
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        validationErrorMessage: URL_INVALID_ERROR_MSG,
        productToUpdate: _products[0],
      );
    });
  }
}