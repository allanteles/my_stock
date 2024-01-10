import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/src/repositories/stock/stock_repository.dart';
import 'package:my_stock/src/repositories/stock/stock_repository_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StockRepository repository = StockRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime dateLess30days = DateTime.now().subtract(const Duration(days: 30));
    String formattedDate = DateFormat.yMMMMd('pt_BR').format(now);
    log(formattedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  repository.fecthByDateInterval(
                      'PETR4.SA', dateLess30days, now);
                },
                child: const Text('PETR4'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
