import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/components/core_alert_dialog.dart';
import '../../../../../core/components/snackbar/core_snackbar.dart';
import '../../../../../core/properties/properties.dart';
import '../../../../../core/texts/core_labels.dart';
import '../../../../../core/texts/core_messages.dart';
import '../../../../../core/utils/core_animations_utils.dart';
import '../../../../overview/controller/overview_controller.dart';
import '../../../controller/inventory_controller.dart';
import '../../../entity/product.dart';
import '../../../view/inventory_details_view.dart';
import '../../../view/inventory_product_zoom_view.dart';
import '../../inventory_icons.dart';
import '../../inventory_keys.dart';
import '../../inventory_labels.dart';
import 'icustom_listtile.dart';

class AnimatedListTile implements ICustomListTile {
  final _icons = Get.find<InventoryIcons>();
  final _inventoryController = Get.find<InventoryController>();
  final _overviewController = Get.find<OverviewController>();
  final _animations = Get.find<CoreAnimationsUtils>();
  final _messages = Get.find<CoreMessages>();
  final _words = Get.find<CoreLabels>();
  final _keys = Get.find<InventoryKeys>();
  final _labels = Get.find<InventoryLabels>();

  @override
  Widget customListTile(Product _product) {
    var _id = _product.id!;

    return OpenContainer(
      transitionDuration: Duration(milliseconds: DELAY_MILLISEC_LISTTILE),
      transitionType: ContainerTransitionType.fadeThrough,
      openBuilder: (context, void Function({Object? returnValue}) openContainer) {
        return InventoryDetailsView(_id);
      },
      closedBuilder: (context, void Function() openContainer) {
        return ListTile(
            key: Key('${_keys.k_inv_item_key}$_id'),
            leading: _openInventoryImageViewProduct(_product),
            title: _rowTitleStockqtde(_product),
            trailing: Container(
                width: 100,
                child: Row(children: <Widget>[
                  _updateIconButton(_id, openContainer, context),
                  _deleteIconButton(_id, context, _product),
                ])));
      },
    );
  }

  Row _rowTitleStockqtde(Product _product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_product.title),
        Text(
            // _product.stockQtde.toString()
            _product.stockQtde <= 9
                ? _product.stockQtde.toString().padLeft(2, '0')
                : _product.stockQtde.toString(),
            style: GoogleFonts.lato(
                textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            )))
      ],
    );
  }

  OpenContainer<Object> _openInventoryImageViewProduct(Product _product) {
    return _animations.openContainer(
        openingWidget: InventoryProductZoomView(_product.title, _product.imageUrl),
        closingWidget: CircleAvatar(backgroundImage: NetworkImage(_product.imageUrl)));
  }

  IconButton _deleteIconButton(String _id, BuildContext context, Product _product) {
    return IconButton(
        key: Key('${_keys.k_inv_del_btn}$_id'),
        icon: _icons.icon_delete(),
        // @formatter:off
                    onPressed: ()
                        {
                            CoreAlertDialog.showOptionDialog(
                            context,
                            _labels.inv_edt_del_conf_tit,
                            '${_labels.inv_edt_del_conf_message}${_product.title}',
                            _words.yes(),
                            _words.no(),
                            () => _deleteItemConfirmed(_id),
                            () => {},
                            );
                        },
        // @formatter:on
        color: Theme.of(context).errorColor);
  }

  IconButton _updateIconButton(String _id, void openContainer(), BuildContext context) {
    return IconButton(
        key: Key('${_keys.k_inv_upd_btn}$_id'),
        icon: _icons.icon_update(),
        onPressed: openContainer,
        color: Theme.of(context).errorColor);
  }

  Future<Null> _deleteItemConfirmed(String _id) {
    return _inventoryController.deleteProduct(_id).then((statusCode) {
      if (statusCode >= 200 && statusCode < 400) {
        _inventoryController.updateInventoryProductsObs();
        _overviewController.deleteProduct(_id);
        _overviewController.updateFilteredProductsObs();
        CoreSnackbar().show(_words.suces, _messages.suces_inv_prod_del);
      }
      if (statusCode >= 400) {
        CoreSnackbar().show(_words.ops, _messages.error_inv_prod);
      }
    });
  }
}