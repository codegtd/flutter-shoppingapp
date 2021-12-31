import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/core/custom_widgets/custom_indicator.dart';
import 'package:shopingapp/app/core/keys/cart_keys.dart';
import 'package:shopingapp/app/core/keys/custom_drawer_keys.dart';
import 'package:shopingapp/app/core/keys/overview_keys.dart';
import 'package:shopingapp/app/core/texts/messages.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/orders/components/custom_tiles/collapsable_tile.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/app_tests_properties.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/testdb_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';

class OrdersTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestDbUtils dbTestUtils;
  final TestsUtils testUtils;

  OrdersTests({
    required this.isWidgetTest,
    required this.finder,
    required this.uiTestUtils,
    required this.dbTestUtils,
    required this.testUtils,
  });

  Future<void> orderProduct_using_cartView_tapping_orderNowButton(
    WidgetTester tester,
    int interval, {
    required int ordersDoneQtde,
  }) async {
    // await uiTestUtils.testInitialization(
    //   tester,
    //   isWidgetTest: isWidgetTest,
    //   appDriver: app.AppDriver(),
    // );

    await create_order_from_cartView(tester, interval);

    //D) OPEN ORDERS-DRAWER-OPTION AND CHECK THE ORDER DONE ABOVE
    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: interval,
      optionKey: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    uiTestUtils.check_widgetQuantityInAView(
      widgetView: OrdersView,
      widgetType: CollapsableTile,
      widgetQtde: ordersDoneQtde,
    );

    //E) PRESS BACK-BUTTON AND GO-BACK TO OVERVIEW-PAGE
    await uiTestUtils.navigateBetweenViews(
      tester,
      interval: interval,
      from: OrdersView,
      to: OverviewView,
      trigger: BackButton,
    );
  }

  Future<void> create_order_from_cartView(tester, int interval) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    //A) ADDING ONE PRODUCT IN THE CART
    await tester.pumpAndSettle(testUtils.delay(interval));
    expect(finder.type(OverviewView), findsOneWidget);
    await tester.tap(finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0"));
    await tester.pumpAndSettle(testUtils.delay(interval));

    //B) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
    await tester.tap(finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(interval));
    expect(finder.type(CartView), findsOneWidget);

    //C) CLICKING ORDER-NOW-BUTTON AND GO BACK TO THE PREVIOUS PAGE
    await tester.tap(finder.key(CART_PAGE_ORDERSNOW_BUTTON_KEY));
    await tester.pump(testUtils.delay(interval));
    expect(finder.type(CustomIndicator), findsOneWidget);
    await tester.pumpAndSettle(testUtils.delay(interval));
    expect(finder.type(OverviewView), findsOneWidget);
  }

  Future<void> check_emptyView_noOrderInDb(
    WidgetTester tester,
    int interval,
  ) async {
    if (!isWidgetTest) {
      await dbTestUtils.removeCollection(tester, url: TESTDB_ORDERS_URL, interval: DELAY);
    }
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: interval,
      optionKey: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    expect(finder.type(OrdersView), findsOneWidget);
    expect(finder.type(CircularProgressIndicator), findsNothing);
    expect(finder.text(NO_ORDERS_FOUND_YET), findsOneWidget);

    await uiTestUtils.navigateBetweenViews(
      tester,
      interval: interval,
      from: OrdersView,
      to: OverviewView,
      trigger: BackButton,
    );
  }

  Future<void> test_page_backbutton(
    WidgetTester tester,
    int interval, {
    required Type from,
    required Type to,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    await tester.pumpAndSettle();

    await uiTestUtils.navigateBetweenViews(
      tester,
      interval: interval,
      from: OrdersView,
      to: OverviewView,
      trigger: BackButton,
    );
  }
}