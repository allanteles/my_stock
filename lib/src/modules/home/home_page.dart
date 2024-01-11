import 'package:flutter/material.dart';
import 'package:my_stock/src/modules/home/home_controller.dart';
import 'package:my_stock/src/modules/home/widgets/card_variation.dart';
import 'package:my_stock/src/services/stock_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    DateTime now = DateTime.now();
    DateTime dateLess30days = DateTime.now().subtract(const Duration(days: 30));

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: ElevatedButton(
                onPressed: () async {
                  await controller
                      .findStockByInterval(
                    'PETR4.SA',
                    dateLess30days,
                    now,
                  )
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(controller.errorMessage)));
                  });
                },
                child: const Text('PETR4'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.listStock.length,
                itemBuilder: (context, i) {
                  if (controller.hasError) {
                    return Text(
                      controller.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  if (controller.hasData) {
                    final inicialValue = controller.listStock[0].price;
                    return CardVariation(
                      day: (i + 1).toString(),
                      date: controller.listStock[i].date,
                      price: controller.listStock[i].price,
                      sequenceVariation: StockService.calculatePercent(
                        controller.listStock[i > 0 ? i - 1 : 0].price,
                        controller.listStock[i].price,
                      ),
                      firstVariation: StockService.calculatePercent(
                        inicialValue,
                        controller.listStock[i].price,
                      ),
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
