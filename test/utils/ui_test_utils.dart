import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../config/tests_properties.dart';
import 'finder_utils.dart';
import 'tests_utils.dart';

class UiTestUtils {
  final _finder = Get.put(FinderUtils());
  final _testUtils = Get.put(TestsUtils());

  Future<void> navigateBetweenViews(
    WidgetTester tester, {
    required int interval,
    required Type from,
    required Type to,
    required Type trigger,
  }) async {
    expect(_finder.type(from), findsOneWidget);
    await tester.tap(_finder.type(trigger));
    await tester.pump();
    await tester.pumpAndSettle(_testUtils.delay(interval));
    expect(_finder.type(to), findsOneWidget);
  }

  Future<void> tapButton_CheckResult(
    WidgetTester tester, {
    required int interval,
    required String triggerKey,
    required Type resultWidget,
  }) async {
    await tester.tap(_finder.key(triggerKey));
    await tester.pump();
    await tester.pump(_testUtils.delay(interval));
    await tester.pumpAndSettle();
    expect(_finder.type(resultWidget), findsWidgets);
  }

  Future<void> openDrawer_SelectAnOption(
    WidgetTester tester, {
    required int interval,
    required String optionKey,
    required GlobalKey<ScaffoldState> scaffoldGlobalKey,
  }) async {
    await tester.pumpAndSettle();
    scaffoldGlobalKey.currentState!.openDrawer();
    await tester.pumpAndSettle(Duration(milliseconds: interval * 1000 + EXTRA_DELAY));
    await tester.tap(_finder.key(optionKey));
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: interval * 1000 + EXTRA_DELAY));
  }

  void check_widgetQuantityInAView({
    required Type widgetView,
    required Type widgetType,
    required int widgetQtde,
  }) {
    expect(_finder.type(widgetView), findsOneWidget);
    expect(
      _finder.type(widgetType),
      widgetQtde == 0 ? findsNothing : findsNWidgets(widgetQtde),
    );
  }

  Future<void> sendAppToBackground({required int interval}) async {
    await Future.delayed(Duration(seconds: interval), () {
      print('Application Closed.');
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  Future<void> testInitialization(
    WidgetTester tester, {
    required bool isWidgetTest,
    required Widget appDriver,
  }) async {
    isWidgetTest ? await tester.pumpWidget(appDriver) : runApp(appDriver);
    await tester.pumpAndSettle(_testUtils.delay(DELAY));
  }

  void resetTestDeviceScreen(tester) {
    // resets the screen to its original size after the test end
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  }

  Future<void> setTestDeviceScreen(
    WidgetTester tester, {
    required double dx,
    required double dy,
  }) async {
    // define the screen-size for this test
    var _screenSizeDefinition = Size(dx, dy);
    await tester.binding.setSurfaceSize(_screenSizeDefinition);
    tester.binding.window.physicalSizeTestValue = _screenSizeDefinition;
    tester.binding.window.devicePixelRatioTestValue = 1.0;
  }

  double testDeviceScreenWidth(WidgetTester tester) =>
      tester.binding.window.physicalSize.width;

  double testDeviceScreenHeight(WidgetTester tester) =>
      tester.binding.window.physicalSize.height;
}
