import 'package:get/get.dart';

import '../../core/entities/cart_item.dart';
import '../../core/entities/order.dart';
import '../repo/i_orders_repo.dart';
import 'i_orders_service.dart';

class OrdersService implements IOrdersService {
  final IOrdersRepo _repo = Get.find();

  @override
  Future<List<Order>> getAllOrders() async {
    return _repo.getAllOrders();
  }

  @override
  void clearOrders() {
    _repo.clearOrdersList();
  }

  @override
  void addOrder(List<CartItem> cartItemsList, double amount) {

    var newOrder = Order(
        id: DateTime.now().toString(),
        amount: amount.toString(),
        cartItemsList: cartItemsList,
        datetime: DateTime.now().toString());

    _repo.addOrder(newOrder);
  }

//  @override
//  Future<int> ordersQtde() async {
//    return _repo.getAllOrders().asStream().length;
//  }
}

//    Order(
//      DateTime.now().toString(),
//      amount,
//      cartItemsList,
//      DateTime.now().toString(),
//    )