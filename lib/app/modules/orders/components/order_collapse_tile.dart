import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../config/app_properties.dart';
import '../../../config/titles_icons/views/orders.dart';
import '../order.dart';
import 'order_collapse_tile_controller.dart';

class OrderCollapseTile extends StatelessWidget {
  final Order _order;

//  final OrderCollapseTileController _controller =
//  Get.put(OrderCollapseTileController());
//  final _controller = OrderCollapseTileController();
//  final OrderCollapseTileController _controller = Get.find();

  OrderCollapseTile(this._order);

  @override
  Widget build(BuildContext context) {
    OrderCollapseTileController _controller;
//PAREI AQUI
//ERRO
//    The following NoSuchMethodError was thrown building OrderCollapseTile(dirty):
//    The getter 'toggleCollapseTile' was called on null.
//    Receiver: null
//    Tried calling: toggleCollapseTile
    GetInstance().create(() {
      _controller = OrderCollapseTileController();
    });

    return Card(
        margin: EdgeInsets.all(15),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, boxShadow: [_boxShadow(Colors.grey, 5.0)]),
            child: ListTile(
                dense: true,
                title: Text(_order.get_amount().toStringAsFixed(2)),
                subtitle:
                    Text(DateFormat(DATE_FORMAT).format(_order.get_datetime())),
                trailing: IconButton(
                    icon: Obx(
                      () => _controller.isTileCollapsed.value == false
                          ? ORDERS_ICO_COLLAPSE
                          : ORDERS_ICO_UNCOLLAPSE,
                    ),
                    onPressed: _controller.toggleCollapseTile)),
          ),
          Obx(
            () => Visibility(
                visible: _controller.isTileCollapsed.value,
                child: Container(
                    height: _order.get_cartItemsList().length * 48.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: Colors.white,
                        boxShadow: [_boxShadow(Colors.grey, 5.0)]),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: LayoutBuilder(builder: (_, specs) {
                      return ListView(
                          padding: EdgeInsets.all(5),
                          children: _order
                              .get_cartItemsList()
                              .map((item) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _rowContainer('${item.title}', 18,
                                            specs.maxWidth * 0.55),
                                        _rowContainer('x${item.qtde}', 18,
                                            specs.maxWidth * 0.15),
                                        _rowContainer(
                                            '${item.price.toString()}',
                                            18,
                                            specs.maxWidth * 0.2)
                                      ]))
                              .toList());
                    }))),
          )
        ]));
  }

  BoxShadow _boxShadow(Color color, double radius) {
    return BoxShadow(
        color: color, offset: Offset(1.0, 1.0), blurRadius: radius);
  }

  Container _rowContainer(String text, int fonSize, double width) {
    return Container(
        padding: EdgeInsets.only(top: 5),
        alignment: Alignment.centerLeft,
        width: width,
        child: Text(text,
            style: TextStyle(
                fontSize: fonSize.toDouble(), fontWeight: FontWeight.bold)));
  }
}
