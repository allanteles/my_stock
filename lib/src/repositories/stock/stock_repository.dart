import '../../models/stock.dart';

abstract interface class StockRepository {
  Future<List<Stock>> fecthByDateInterval(
      String symbol, DateTime inicialDate, DateTime endDate);
}
