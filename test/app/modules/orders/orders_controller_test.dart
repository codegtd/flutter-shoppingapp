import 'package:shopingapp/app/modules/orders/controller/orders_controller.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';
import 'package:shopingapp/app/modules/orders/service/i_orders_service.dart';
import 'package:shopingapp/app/modules/orders/service/orders_service.dart';
import 'package:test/test.dart';

import '../../../test_utils/mocked_datasource/orders_mocked_datasource.dart';
import 'orders_test_config.dart';

class OrdersControllerTest {
  static void integration() {
    IOrdersRepo _repo;
    IOrdersService _service;
    OrdersController _controller;

    setUp(() {
      _repo = OrdersTestConfig().testsRepo;
      _service = OrdersService(repo: _repo);
      _controller = OrdersController(service: _service);
    });

    test('Checking Tests Instances', () {
      expect(_repo, isA<IOrdersRepo>());
      expect(_service, isA<IOrdersService>());
      expect(_controller, isA<OrdersController>());
    });

    test('Getting Orders', () {
      expect(_controller.getQtdeOrdersObs(), isZero);
      expect(_controller.getOrdersObs().length, isZero);

      _controller.getOrders().forEach((value) {
        expect(value.id.toString(), isIn(OrdersMockedDatasource().orders()));
        expect(_controller.getQtdeOrdersObs(), isNonZero);
        expect(_controller.getOrdersObs().length, isNonZero);
      });
    });

    test('Clearing Orders', () {
      _controller.getOrders().forEach((value) {
        expect(_controller.getQtdeOrdersObs(), isZero);
        expect(_controller.getOrdersObs().length, isZero);
        expect(value.id.toString(), isIn(OrdersMockedDatasource().orders()));
        expect(_controller.getQtdeOrdersObs(), isNonZero);
        expect(_controller.getOrdersObs().length, isNonZero);
        _controller.clearOrder();
        expect(_controller.getQtdeOrdersObs(), isZero);
        expect(_controller.getOrdersObs().length, isZero);
      });
    });
  }
}