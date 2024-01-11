import 'package:flutter/material.dart';
import 'package:my_stock/my_app.dart';
import 'package:my_stock/src/modules/home/home_controller.dart';
import 'package:my_stock/src/repositories/stock/stock_repository_impl.dart';
import 'package:provider/provider.dart';

import 'src/core/env/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.instance.load();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => HomeController(
          stockRepository: StockRepositoryImpl(),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}
