import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../../../core/custom_widgets/custom_snackbar/button_snackbar.dart';
import '../../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../../core/keys/overview_keys.dart';
import '../../../../core/properties/app_properties.dart';
import '../../../../core/texts_icons_provider/generic_words.dart';
import '../../../../core/texts_icons_provider/pages/overview/messages_snackbars_provided.dart';
import '../../../../core/texts_icons_provider/pages/overview/overview_texts_icons_provided.dart';
import '../../../../core/utils/animations_utils.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../inventory/entity/product.dart';
import '../../controller/overview_controller.dart';
import '../../service/i_overview_service.dart';
import '../../view/overview_item_details_view.dart';
import 'icustom_grid_item.dart';

class AnimatedGridItem extends StatelessWidget implements ICustomGridtile {
  final Product _product;

  final _cartController = Get.find<CartController>();
  final _animations = Get.find<AnimationsUtils>();
  final _uniqueController = OverviewController(service: Get.find<IOverviewService>());
  final String index;
  final void Function(GlobalKey)? onClick;
  final GlobalKey imageGlobalKey = GlobalKey();

  AnimatedGridItem(this._product, this.index, {this.onClick});

  @override
  Widget build(BuildContext context) {
    _uniqueController.favoriteStatusObs.value = _product.isFavorite;

    return Obx(
      () => AnimatedPhysicalModel(
          duration: const Duration(milliseconds: 350),
          curve: Curves.fastOutSlowIn,
          elevation: _uniqueController.gridItemElevateAnimationObs.value ? 0 : 30.0,
          shape: BoxShape.rectangle,
          shadowColor: Colors.black,
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onEnd: () => _uniqueController.elevateGridItemAnimation(true),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(220, 220, 220, 10)),
                  borderRadius: BorderRadius.circular(10.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: customGridTile(context, _product, index, _uniqueController),
              ))),
    );
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
        fit: BoxFit.cover);

    return _animations.openContainer(
      openingWidget: OverviewItemDetailsView(product.id),
      closingWidget: GridTile(
          key: Key("$K_OV_ITM_DET_PAGE$index"),
          child: Container(
              key: imageGlobalKey,
              child:
                  ClipRRect(borderRadius: BorderRadius.circular(10.0), child: fadeImage)),
          footer: GridTileBar(
              leading: Obx(() => _favButton(index, context, uniqueController, product)),
              title: Text(product.title, key: Key("$K_OV_GRD_PRD_TIT$index")),
              trailing: _shopCartButton(index, uniqueController, product, context),
              backgroundColor: Colors.black87)),
    );
  }

  IconButton _favButton(
      String index, context, OverviewController uniqueController, Product product) {
    return IconButton(
        key: Key("$K_OV_GRD_FAV_BTN$index"),
        color: Theme.of(context).colorScheme.secondary,
        icon: uniqueController.favoriteStatusObs.value ? OV_ICO_FAV : OV_ICO_NOFAV,
        onPressed: () {
          uniqueController.toggleFavoriteStatus(product.id!).then((response) {
            response
                ? SimpleSnackbar().show(SUCES, TOG_STATUS_SUCES)
                : SimpleSnackbar().show(OPS, TOG_STATUS_ERROR);
          });
        });
  }

  IconButton _shopCartButton(
      String index, OverviewController uniqueController, Product product, context) {
    return IconButton(
        key: Key("$K_OV_GRD_CRT_BTN$index"),
        icon: OV_ICO_SHOPCART,
        onPressed: () {
          uniqueController.elevateGridItemAnimation(false);
          _cartController.addCartItem(product);
          // onClick!(imageGlobalKey);
          ButtonSnackbar(
            context: context,
            labelButton: UNDO,
            function: () => _cartController.addCartItemUndo(product),
          ).show(DONE, "${product.title}$ITEMCART_ADDED");
        },
        color: Theme.of(context).colorScheme.secondary);
  }
}