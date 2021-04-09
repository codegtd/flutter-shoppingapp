import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:shopingapp/app/pages_modules/custom_widgets/app_messages_provided.dart';

import '../../../core/properties/app_routes.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../components/managed_product_item.dart';
import '../controller/managed_products_controller.dart';
import '../core/managed_products_widget_keys.dart';
import '../core/texts_icons/managed_products_texts_icons_provided.dart';

class ManagedProductsPage extends StatelessWidget {
  final ManagedProductsController controller;

  ManagedProductsPage({this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text(MAN_PROD_TIT_APPBAR), actions: <Widget>[
        IconButton(
            key: Key(K_MP_ADD_BTN),
            icon: MAN_PROD_ICO_ADD_APPBAR,
            onPressed: () =>
                Get.toNamed(AppRoutes.MANAGED_PRODUCTS_ADDEDIT_PAGE))
      ]),

      // GERENCIA DE ESTADO REATIVA - COM O GET
      body: Obx(() => (controller.getManagedProductsObs().length == 0
          ? CustomProgressIndicator.message(message: NO_PROD, fontSize: 20)
          : RefreshIndicator(
              onRefresh: controller.getProducts,
              child: controller.getManagedProductsObs().length == 0
                  ? Center(child: Text('cccc'))
                  : ListView.builder(
                      itemCount: controller.getManagedProductsObs().length,
                      itemBuilder: (ctx, i) => Column(children: [
                            ManagedProductItem(
                              product: controller.getManagedProductsObs()[i],
                              managedProductsController: controller,
                              overviewController: Get.find(),
                            ),
                            Divider()
                          ]))))),
    );
  }
}
// GERENCIA DE ESTADO SIMPLES - COM O GET
//      body: GetBuilder<ManagedProductsController>(
//          init: ManagedProductsController(),
//          builder: (_) => ListView.builder(
//              itemCount: _.managedProducts.length,
//              itemBuilder: (ctx, item) => Column(children: [
//                    ManagedProductItem(
//                      _.managedProducts[item].id,
//                      _.managedProducts[item].title,
//                      _.managedProducts[item].imageUrl,
//                    ),
//                    Divider()
//                  ]))),

//----------
