import 'package:flutter/material.dart';
import 'package:my_stock/my_app.dart';

import 'src/core/env/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.instance.load();

  runApp(const MyApp());
}
