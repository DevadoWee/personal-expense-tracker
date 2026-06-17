import 'package:flutter/widgets.dart';

import 'app.dart';
import 'services/local_database_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabaseService.instance.initialize();
  runApp(const ExpenseTrackerApp());
}
