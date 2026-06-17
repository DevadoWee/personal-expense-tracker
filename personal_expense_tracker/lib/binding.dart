import 'package:get/get.dart';

import 'controllers/home_controller.dart';

final class RouteBindings {
  const RouteBindings._();

  static Bindings home = BindingsBuilder(() {
    Get.put(HomeController());
  });
}
