class StockService {
  static double calculatePercent(double inicialValue, double targetValue) {
    return ((targetValue - inicialValue) / targetValue) * 100.0;
  }
}
