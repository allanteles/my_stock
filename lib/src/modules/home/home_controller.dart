import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_stock/src/repositories/stock/stock_repository.dart';

import '../../core/exceptions/repository_exeception.dart';
import '../../models/stock.dart';

class HomeController extends ChangeNotifier {
  final StockRepository stockRepository;

  var isLoading = false;
  var hasData = false;
  var hasError = false;
  var errorMessage = '';
  List<Stock> _listStock = [];
  List<Stock> get listStock => _listStock;

  HomeController({required this.stockRepository});

  void _update(
      {bool isLoading = false,
      bool hasData = false,
      bool hasError = false,
      String errorMessage = ''}) {
    this.isLoading = isLoading;
    this.hasData = hasData;
    this.hasError = hasError;
    this.errorMessage = errorMessage;
    notifyListeners();
  }

  Future<void> findStockByInterval(
      String symbol, DateTime inicalDate, DateTime endDate) async {
    try {
      _update(isLoading: true);
      _listStock = await stockRepository.fecthByDateInterval(
        symbol,
        inicalDate,
        endDate,
      );
      _update(hasData: true);
      log(_listStock.length.toString());
    } on RepositoryException catch (e) {
      _update(hasError: true, errorMessage: e.message);
    } catch (e) {
      _update(
          hasError: true,
          errorMessage: 'Ocorreu um erro. Tente novamente mais tarde');
    }
  }
}
