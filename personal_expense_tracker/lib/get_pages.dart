import 'package:get/get.dart';

import 'binding.dart';
import 'screens/create_transaction_screen.dart';
import 'screens/home_screen.dart';
import 'shared/route.dart';

final class GetPages {
  const GetPages._();

  static final pages = <GetPage>[
    GetPage(name: Routes.home, page: () => const HomeScreen(), binding: RouteBindings.home),
    GetPage(name: Routes.createTransaction, page: () => const CreateTransactionScreen()),
  ];
}
