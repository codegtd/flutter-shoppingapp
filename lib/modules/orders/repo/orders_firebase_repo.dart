import 'package:dio/dio.dart';

import '../../core/configurable/app_properties.dart';
import '../../core/connection/custom_dio.dart';
import '../../core/entities/order.dart';
import 'i_orders_repo.dart';

class OrdersFirebaseRepo extends IOrdersRepo {
  final List<Order> _orders = [];
  final CustomDio _connect = CustomDio();

  @override
  Future<int> addOrder(Order order) async {
//    try {
//      var response =
//          await _connect.get_dio.call().post(ORDERS_URL, data: order.toJson());
//      return response.statusCode;
//    } on DioError catch (error) {
//      throw (error.message);
//    }
  }

  @override
  Future<List<Order>> getAllOrders() async {
//    try {
//      var response = await _connect.get_dio().get(ORDERS_URL);
//      return (response.data as List)
//          .map((order) => Order.fromJson(order))
//          .toList();
//    } on DioError catch (error) {
//      throw (error.message);
//    }
  }

  @override
  void clearOrdersList() {
    _orders.clear();
  }
}

//    var response = await _client
//        .post("/post", data: order)
//        .then((value) => value.statusCode)
//        .catchError((eventualError) {
//      throw (eventualError.toString());
//    });