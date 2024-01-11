import 'package:flutter_test/flutter_test.dart';
import 'package:my_stock/src/core/env/env.dart';
import 'package:my_stock/src/core/exceptions/repository_exeception.dart';
import 'package:my_stock/src/models/stock.dart';
import 'package:my_stock/src/repositories/stock/stock_repository.dart';
import 'package:my_stock/src/repositories/stock/stock_repository_impl.dart';

void main() {
  group('tests stock repository', () {
    test('should return data', () async {
      await Env.instance.load();
      StockRepository repository = StockRepositoryImpl();
      DateTime now = DateTime.now();
      DateTime dateLess30days =
          DateTime.now().subtract(const Duration(days: 30));
      List<Stock> list =
          await repository.fecthByDateInterval('PETR4.SA', dateLess30days, now);

      expect(list.length, greaterThan(0));
    });

    test('should throw exception', () async {
      await Env.instance.load();
      StockRepository repository = StockRepositoryImpl();
      DateTime now = DateTime.now();
      DateTime dateLess30days =
          DateTime.now().subtract(const Duration(days: 30));

      expect(repository.fecthByDateInterval('ABC', dateLess30days, now),
          throwsA(isA<RepositoryException>()));
    });
  });
}
