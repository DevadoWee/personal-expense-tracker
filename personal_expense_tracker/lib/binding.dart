import 'package:get/get.dart';

import 'controllers/create_transaction_controller.dart';
import 'controllers/home_controller.dart';

final class RouteBindings {
  const RouteBindings._();

  static Bindings home = BindingsBuilder(() {
    Get.put(HomeController());
  });

  static Bindings createTransaction = BindingsBuilder(() {
    Get.put(CreateTransactionController());
  });
}
