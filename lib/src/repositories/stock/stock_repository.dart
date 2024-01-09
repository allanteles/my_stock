import '../../models/stock.dart';

abstract interface class StockRepository {
  Future<List<Stock>> fecthAllData(String symbol);
}
