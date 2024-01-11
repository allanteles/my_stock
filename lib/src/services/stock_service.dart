class StockService {
  static double calculatePercent(double inicialValue, double targetValue) {
    double result = ((targetValue - inicialValue) / inicialValue) * 100;
    return result;
  }
}
