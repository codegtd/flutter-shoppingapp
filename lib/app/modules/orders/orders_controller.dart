import 'package:get/get.dart';

import '../../modules/cart/cart_item.dart';
import 'order.dart';
import 'service/i_orders_service.dart';

class OrdersController {
  final IOrdersService _service = Get.find();

  var qtdeOrders = 0.obs;

  List<Order> getAllOrders() {
    return _service.getAllOrders();
  }

  void clearOrders() {
    _service.clearOrders();
  }

  void addOrder(List<CartItem> cartItemsList, double amount) {
    _service.addOrder(cartItemsList, amount);
    qtdeOrders.value = getAllOrders().length;
  }
}
