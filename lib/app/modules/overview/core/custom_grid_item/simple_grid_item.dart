import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/custom_widgets/custom_snackbar/button_snackbar.dart';
import '../../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../../core/keys/overview_keys.dart';
import '../../../../core/properties/app_properties.dart';
import '../../../../core/properties/app_routes.dart';
import '../../../../core/texts_icons_provider/generic_words.dart';
import '../../../../core/texts_icons_provider/pages/overview/messages_snackbars_provided.dart';
import '../../../../core/texts_icons_provider/pages/overview/overview_texts_icons_provided.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../inventory/entity/product.dart';
import '../../controller/overview_controller.dart';
import '../../service/i_overview_service.dart';
import 'icustom_grid_item.dart';

class SimpleGridItem extends StatelessWidget implements ICustomGridtile {
  final Product _product;

  final _cartController = Get.find<CartController>();
  final _uniqueController = OverviewController(service: Get.find<IOverviewService>());
  final String index;

  SimpleGridItem(this._product, this.index);

  @override
  Widget build(BuildContext context) {
    _uniqueController.favoriteStatusObs.value = _product.isFavorite;
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(220, 220, 220, 10)),
            borderRadius: BorderRadius.circular(10.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: customGridTile(context, _product, index, _uniqueController),
        ));
  }

  @override
  Widget customGridTile(
    context,
    Product product,
    String index,
    OverviewController uniqueController,
  ) {
    var fadeImage = FadeInImage(
      placeholder: AssetImage(IMAGE_PLACEHOLDER),
      image: NetworkImage(product.imageUrl),
      fit: BoxFit.cover,
    );

    return GridTile(
        child: GestureDetector(
            key: Key("$K_OV_ITM_DET_PAGE$index"),
            onTap: () => Get.toNamed('${AppRoutes.OVERVIEW_ITEM_DETAILS}${product.id}'),
            child: fadeImage),
        footer: GridTileBar(
            leading: Obx(
              () => _favButton(index, product, context),
            ),
            title: Text(product.title, key: Key("$K_OV_GRD_PRD_TIT$index")),
            trailing: _shopCartButton(index, product, context),
            backgroundColor: Colors.black87));
  }

  IconButton _shopCartButton(String index, Product product, context) {
    return IconButton(
        key: Key("$K_OV_GRD_CRT_BTN$index"),
        icon: OV_ICO_SHOPCART,
        onPressed: () {
          _cartController.addCartItem(product);
          ButtonSnackbar(
            context: context,
            labelButton: UNDO,
            function: () => _cartController.addCartItemUndo(product),
          ).show(
            DONE,
            "${product.title}$ITEMCART_ADDED",
          );
        },
        color: Theme.of(context).colorScheme.secondary);
  }

  IconButton _favButton(String index, Product product, context) {
    return IconButton(
        key: Key("$K_OV_GRD_FAV_BTN$index"),
        icon: _uniqueController.favoriteStatusObs.value ? OV_ICO_FAV : OV_ICO_NOFAV,
        onPressed: () {
          _uniqueController.toggleFavoriteStatus(product.id!).then((response) {
            response
                ? SimpleSnackbar().show(SUCES, TOG_STATUS_SUCES)
                : SimpleSnackbar().show(OPS, TOG_STATUS_ERROR);
          });
        },
        color: Theme.of(context).colorScheme.secondary);
  }
}