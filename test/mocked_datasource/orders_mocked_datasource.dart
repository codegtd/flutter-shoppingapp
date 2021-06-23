import 'dart:convert';
import 'dart:io';

import 'package:shopingapp/app/modules/orders/entities/order.dart';

class OrdersMockedDatasource {
  final MOCKED_DATASOURCE = "test/mocked_datasource/mocked_datasource.json";
  String _MockedDatasource;

  OrdersMockedDatasource() {
    _MockedDatasource = MOCKED_DATASOURCE;
  }

  List<Order> orders() {
    final file = File(_MockedDatasource);
    final json = jsonDecode(file.readAsStringSync())["orders"];
    List<Order> result = json.map<Order>((json) => Order.fromJson(json)).toList();
    return result;
  }

  Order order() {
    final file = File(_MockedDatasource);
    final json = jsonDecode(file.readAsStringSync())["orders"];
    List<Order> result = json.map<Order>((json) => Order.fromJson(json)).toList();
    return result.elementAt(0);
  }

  List<Order> ordersEmpty() {
    return [];
  }
}