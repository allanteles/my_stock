import 'package:flutter_test/flutter_test.dart';
import 'package:my_stock/src/services/stock_service.dart';

void main() {
  test('should be 10% of profit', () {
    expect(StockService.calculatePercent(100, 110), 10);
  });

  test('should be 10% of loss', () {
    expect(StockService.calculatePercent(100, 90), -10);
  });
}
