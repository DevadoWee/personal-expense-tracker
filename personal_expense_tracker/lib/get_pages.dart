import 'package:get/get.dart';


import 'screens/home_screen.dart';
import 'shared/route.dart';

final class GetPages {
  const GetPages._();

  static final pages = <GetPage>[
    GetPage(name: Routes.home, page: () => const HomeScreen()),
  ];
}
