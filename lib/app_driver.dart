import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import 'modules/core/app_routes.dart';
import 'modules/core/configurable/app_properties.dart';
import 'modules/core/configurable/theme/app_theme.dart';
import 'modules/core/configurable/theme/dark_theme_controller.dart';
import 'modules/core/shared_preferences/i_shared_prefs_repo.dart';
import 'modules/core/shared_preferences/shared_prefs_repo.dart';


class AppDriver extends StatelessWidget {
  final _appTheme = Get.put(AppTheme());
  final _darkTheme = Get.put(DarkThemeController());
  final _repo = Get.put<ISharedPrefsRepo>(SharedPrefsRepo());

  @override
  Widget build(BuildContext context) {
    _repo.get('isDarkOption').then(
          (value) => value == null
              ? _darkTheme.isDark.value = false
              : _darkTheme.isDark.value = value,
        );

    return GetMaterialApp(
      debugShowCheckedModeBanner: APP_DEBUG_CHECK,
      title: APP_TITLE,

      theme: _appTheme.theme(_darkTheme.isDark.value),

      //Get PARAMETROS:
//      initialBinding: CoreBinding(),
//      smartManagement: SmartManagement.keepFactory,
//      home: OverviewPage(Popup.All),
      initialRoute: AppRoutes.OVERVIEW_ALL_ROUTE,
      getPages: AppRoutes.getAppRoutes,
    );
  }
}